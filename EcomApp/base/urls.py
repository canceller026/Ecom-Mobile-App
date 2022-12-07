from django.urls import path
from .views import HomeView, LoginView, CartView, ProductView

urlpatterns = [
    path('', HomeView, name='home'),
    path('login/', LoginView, name='login'),
    path('cart/', CartView, name='cart'),
    path('product/', ProductView, name='product')
]
