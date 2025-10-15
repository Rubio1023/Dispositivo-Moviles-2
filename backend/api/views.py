from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.shortcuts import get_object_or_404
from django.db import transaction

from django.contrib.auth.models import User
from .models import Product, Cart, CartItem
from .serializers import ProductSerializer, CartSerializer, CartItemSerializer, AddCartItemSerializer, UpdateCartItemSerializer

# ---- Productos ----
@api_view(['GET'])
def product_list(request):
    qs = Product.objects.all()
    serializer = ProductSerializer(qs, many=True)
    return Response(serializer.data)

# ---- Obtener carrito del usuario (si no tiene, crea uno vacío) ----
@api_view(['GET'])
def get_cart(request, user_id):
    user = get_object_or_404(User, id=user_id)
    cart, _ = Cart.objects.get_or_create(user=user)
    serializer = CartSerializer(cart)
    return Response(serializer.data)

# ---- Agregar item al carrito ----
@api_view(['POST'])
def add_to_cart(request):
    """
    body: { "user_id": 1, "product_id": 2, "quantity": 3 }
    """
    user_id = request.data.get('user_id')
    product_id = request.data.get('product_id')
    quantity = int(request.data.get('quantity', 1))

    if not user_id or not product_id:
        return Response({'error': 'user_id y product_id son requeridos'}, status=status.HTTP_400_BAD_REQUEST)

    user = get_object_or_404(User, id=user_id)
    product = get_object_or_404(Product, id=product_id)

    if product.stock < quantity:
        return Response({'error': 'Stock insuficiente', 'available': product.stock}, status=status.HTTP_400_BAD_REQUEST)

    cart, _ = Cart.objects.get_or_create(user=user)

    # Si el item ya existe, sumamos la cantidad (sin exceder stock)
    cart_item, created = CartItem.objects.get_or_create(cart=cart, product=product)
    new_qty = cart_item.quantity + quantity if not created else quantity
    if new_qty > product.stock:
        return Response({'error': 'Stock insuficiente para la cantidad solicitada', 'available': product.stock}, status=status.HTTP_400_BAD_REQUEST)

    cart_item.quantity = new_qty
    cart_item.save()

    return Response({'message': 'Producto agregado al carrito'}, status=status.HTTP_200_OK)

# ---- Actualizar cantidad de un item del carrito ----
@api_view(['PUT'])
def update_cart_item(request):
    """
    body: { "item_id": 5, "quantity": 2 }  (setea cantidad; si quantity = 0 => borra)
    """
    serializer = UpdateCartItemSerializer(data=request.data)
    if not serializer.is_valid():
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    item_id = serializer.validated_data['item_id']
    quantity = serializer.validated_data['quantity']

    cart_item = get_object_or_404(CartItem, id=item_id)
    product = cart_item.product

    if quantity == 0:
        cart_item.delete()
        return Response({'message': 'Item eliminado del carrito'}, status=status.HTTP_200_OK)

    if quantity > product.stock:
        return Response({'error': 'Stock insuficiente', 'available': product.stock}, status=status.HTTP_400_BAD_REQUEST)

    cart_item.quantity = quantity
    cart_item.save()
    return Response({'message': 'Cantidad actualizada'}, status=status.HTTP_200_OK)

# ---- Eliminar item (alternativa) ----
@api_view(['DELETE'])
def remove_cart_item(request, item_id):
    item = get_object_or_404(CartItem, id=item_id)
    item.delete()
    return Response({'message': 'Item eliminado'}, status=status.HTTP_200_OK)

# ---- Checkout / pagar (descontar stock y vaciar carrito) ----
@api_view(['POST'])
def checkout(request):
    """
    body: { "user_id": 1 }
    Este endpoint intenta procesar el carrito entero:
     - Verifica stock
     - Descuenta stock
     - Elimina items del carrito (o elimina el carrito)
    """
    user_id = request.data.get('user_id')
    if not user_id:
        return Response({'error': 'user_id requerido'}, status=status.HTTP_400_BAD_REQUEST)

    user = get_object_or_404(User, id=user_id)
    cart = Cart.objects.filter(user=user).first()
    if not cart or cart.items.count() == 0:
        return Response({'error': 'Carrito vacío'}, status=status.HTTP_400_BAD_REQUEST)

    # Validar stock
    problems = []
    for item in cart.items.select_related('product'):
        if item.quantity > item.product.stock:
            problems.append({'product_id': item.product.id, 'available': item.product.stock, 'requested': item.quantity})

    if problems:
        return Response({'error': 'Stock insuficiente', 'details': problems}, status=status.HTTP_400_BAD_REQUEST)

    # Operación atómica: descontar stock y vaciar carrito
    try:
        with transaction.atomic():
            for item in cart.items.select_related('product'):
                p = item.product
                p.stock = p.stock - item.quantity
                p.save()
            # vaciar carrito
            cart.items.all().delete()
    except Exception as e:
        return Response({'error': 'Error procesando pago', 'detail': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    return Response({'message': 'Pago procesado correctamente'}, status=status.HTTP_200_OK)
