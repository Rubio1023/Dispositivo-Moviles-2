from django.urls import path
from . import views

urlpatterns = [
    # productos
    path('products/', views.product_list, name='product-list'),

    # carrito
    path('add-to-cart/', views.add_to_cart, name='add-to-cart'),
    path('cart/<int:user_id>/', views.get_cart, name='get-cart'),
    path('cart/update-item/', views.update_cart_item, name='update-cart-item'),
    path('cart/remove-item/<int:item_id>/', views.remove_cart_item, name='remove-cart-item'),
    path('checkout/', views.checkout, name='checkout'),
]
