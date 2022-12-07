from django.urls import path
from . import views

urlpatterns = [
    path('', views.getShop, name ="shopAPI"),
    path('profile', views.getProfile, name ="profileAPI")
]