from rest_framework.viewsets import ModelViewSet 
from .serializer import *
from base.models import UserProfile, Added, AuthUser, Category, Courier, Listing, Orders,Product, Shop

class ShopViewSet(ModelViewSet):
    queryset = Shop.objects.all()
    serializer_class = ShopSerializer
    
class AddedViewSet(ModelSerializer):
    queryset = Added.objects.all()
    serializer_class = AddedSerializer
    
class CategoryViewSet(ModelSerializer):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

class OrdersViewSet(ModelSerializer):
    queryset = Orders.objects.all()
    serializer_class = OrdersSerializer
    
class CourierViewSet(ModelSerializer):
    queryset = Courier.objects.all()
    serializer_class = CourierSerializer
    
class ListingViewSet(ModelSerializer):
    queryset = Listing.objects.all()
    serializer_class = ListingSerializer
    
class ProductViewSet(ModelSerializer):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

    