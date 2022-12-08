from django.urls import path
from .views import HomeView, LoginView, CartView, ProductView, RegisterView, LogoutView, ListingView, ShopView

urlpatterns = [
    path('', HomeView, name='home'),
    path('login/', LoginView, name='login'),
    path('register/', RegisterView, name='register'),
    path('logout/', LogoutView, name='logout'),
    path('cart/', CartView, name='cart'),
    path('product/', ProductView, name='product'),
    path('listing/', ListingView, name='listing'),
    path('shop/', ShopView, name='shop'),
]
