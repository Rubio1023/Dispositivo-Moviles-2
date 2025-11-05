from django.urls import path
from . import views

urlpatterns = [
    # productos
    path('products/', views.product_list, name='product-list'),
    path('search/', views.search_products, name='search_products'),
    
    # usuarios
    path('register/', views.register_user, name='register-user'),
    path('login/', views.login_user, name='login-user'),

    # carrito
    path('products/', views.product_list, name='product_list'),
    path('cart/<int:user_id>/', views.get_cart, name='get_cart'),
    path('add-to-cart/', views.add_to_cart, name='add_to_cart'),
    path('update-cart-item/', views.update_cart_item, name='update_cart_item'),
    path('remove-cart-item/<int:item_id>/', views.remove_cart_item, name='remove_cart_item'),
    path('checkout/', views.checkout, name='checkout'),

]
