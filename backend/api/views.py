from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.shortcuts import get_object_or_404
from django.db import transaction
from django.http import JsonResponse
from .supabase_client import supabase
from django.db.models import Q


from django.contrib.auth.models import User
from .models import Product, Cart, CartItem
from .serializers import ProductSerializer, CartSerializer, CartItemSerializer, AddCartItemSerializer, UpdateCartItemSerializer

# Productos 
@api_view(['GET'])
def product_list(request):
    
    try:
        response = supabase.table('products').select('*').execute()

        
        if response.data is None:
            return Response(
                {"error": "No se pudieron obtener los productos"},
                status=500
            )

        return Response(response.data)

    except Exception as e:
        return Response({"error": str(e)}, status=500)

# Obtener carrito del usuario 
@api_view(['GET'])
def get_cart(request, user_id):
    user = get_object_or_404(User, id=user_id)
    cart, _ = Cart.objects.get_or_create(user=user)
    serializer = CartSerializer(cart)
    return Response(serializer.data)

# Agregar al carrito 
@api_view(['POST'])
def add_to_cart(request):
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

# Actualizar cantidad de un item del carrito
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

# Eliminar item 
@api_view(['DELETE'])
def remove_cart_item(request, item_id):
    item = get_object_or_404(CartItem, id=item_id)
    item.delete()
    return Response({'message': 'Item eliminado'}, status=status.HTTP_200_OK)


# Pagar (descontar stock y vaciar carrito) 
@api_view(['POST'])
def checkout(request):
    product_id = request.data.get('product_id')
    quantity = int(request.data.get('quantity', 1))

    try:
        # Leer producto desde Supabase
        product = supabase.table("products").select("*").eq("id", product_id).execute()
        if not product.data:
            return Response({'error': 'Producto no encontrado'}, status=status.HTTP_404_NOT_FOUND)

        stock = product.data[0]['stock']
        if stock < quantity:
            return Response({'error': 'Stock insuficiente', 'available': stock}, status=status.HTTP_400_BAD_REQUEST)

        new_stock = stock - quantity

        # Actualizar en Supabase
        result = supabase.table("products").update({"stock": new_stock}).eq("id", product_id).execute()
        print("Resultado Supabase:", result)

        return Response({'message': 'Pago procesado correctamente', 'new_stock': new_stock}, status=status.HTTP_200_OK)

    except Exception as e:
        import traceback
        traceback.print_exc()
        return Response({'error': 'Error procesando pago', 'detail': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)




# Busqueda
@api_view(['GET'])
def search_products(request):
    query = request.GET.get('q', '').strip()

    if query:
        # usamos icontains (insensible a mayúsculas/minúsculas)
        # y también filtramos por descripción si quieres hacerlo más útil
        products = Product.objects.filter(
            Q(name__icontains=query) | Q(description__icontains=query)
        )
    else:
        products = Product.objects.all()

    serializer = ProductSerializer(products, many=True)
    print("🔎 Query recibida:", query)
    print("🧾 Productos encontrados:", products.count())
    return Response(serializer.data)




# Autenticación con Supabase 
from .supabase_client import supabase
from django.views.decorators.csrf import csrf_exempt
import json
from django.http import JsonResponse
from rest_framework.decorators import api_view

@csrf_exempt
@api_view(['POST'])
def register_user(request):
    try:
        data = json.loads(request.body)
        name = data.get("name")
        email = data.get("email")
        password = data.get("password")

        # Validar campos obligatorios
        if not name or not email or not password:
            return JsonResponse({"detail": "Faltan datos"}, status=400)

        # Verificar si el usuario ya existe
        existing = supabase.table("users").select("*").eq("email", email).execute()
        if existing.data:
            return JsonResponse({"detail": "El usuario ya existe"}, status=400)

        # Crear usuario en Supabase
        response = supabase.table("users").insert({
            "name": name,
            "email": email,
            "password": password
        }).execute()

        user = response.data[0]

        # Devuelve respuesta con Flutter
        return JsonResponse({
            "status": 200,
            "message": "Usuario registrado exitosamente",
            "user": {
                "id": user.get("id"),
                "name": user.get("name"),
                "email": user.get("email")
            }
        }, status=200)

    except Exception as e:
        print(" Error en register_user:", e)
        return JsonResponse({"detail": str(e)}, status=500)


@csrf_exempt
@api_view(['POST'])
def login_user(request):
    try:
        data = json.loads(request.body)
        email = data.get("email")
        password = data.get("password")

        # Validar datos
        if not email or not password:
            return JsonResponse({"detail": "Faltan datos"}, status=400)

        # Buscar usuario en Supabase
        response = supabase.table("users").select("*").eq("email", email).eq("password", password).execute()

        if not response.data:
            return JsonResponse({"detail": "Credenciales inválidas"}, status=401)

        user = response.data[0]

        # Enviar información completa al cliente
        return JsonResponse({
            "status": 200,
            "message": "Inicio de sesión exitoso",
            "user": {
                "id": user.get("id"),
                "name": user.get("name"),
                "email": user.get("email")
            }
        }, status=200)

    except Exception as e:
        print(" Error en login_user:", e)
        return JsonResponse({"detail": str(e)}, status=500)
    
    
    