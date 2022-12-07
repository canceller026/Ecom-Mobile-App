from rest_framework.decorators import api_view
from rest_framework.response import Response
from base.models import UserProfile, Added, AuthUser, Category, Courier, Listing, Orders,Product, Shop
from .serializer import *
from rest_framework.viewsets import ModelViewSet

class ShopViewSet(ModelViewSet):
    queryset = Shop.objects.all()
    serializer_class = ShopSerializer
    
class AddedViewSet(ModelViewSet):
    queryset = Added.objects.all()
    serializer_class = AddedSerializer
    
class CategoryViewSet(ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

class OrdersViewSet(ModelViewSet):
    queryset = Orders.objects.all()
    serializer_class = OrdersSerializer
    
class CourierViewSet(ModelViewSet):
    queryset = Courier.objects.all()
    serializer_class = CourierSerializer
    
class ListingViewSet(ModelViewSet):
    queryset = Listing.objects.all()
    serializer_class = ListingSerializer
    
class ProductViewSet(ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

    
"""
@api_view(['GET'])
def getProfile(request):
    tables = UserProfile.objects.all()
    serializer = UserProfileSerializer(tables, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def getAdded(request):
    tables = Added.objects.all()
    serializer = AddedSerializer(tables, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def getUser(request):
    tables = AuthUser.objects.all()
    serializer = AuthUserSerializer(tables, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def getCategory(request):
    tables = Category.objects.all()
    serializer = CategorySerializer(tables, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def getListing(request):
    tables = Listing.objects.all()
    serializer = ListingSerializer(tables, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def getOrders(request):
    tables = Orders.objects.all()
    serializer = OrdersSerializer(tables, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def getCourier(request):
    tables = Courier.objects.all()
    serializer = CourierSerializer(tables, many = True)
    return Response(serializer.data)
@api_view(['GET'])
def getProduct(request):
    tables = Product.objects.all()
    serializer = ProductSerializer(tables, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def getShop(request):
    tables = Shop.objects.all()
    serializer = ShopSerializer(tables, many = True)
    return Response(serializer.data)
"""
"""
@api_view(['GET'])
def getProfileByUsername(request, pk):
    tables = UserProfile.objects.all()
    serializer = UserProfileSerializer(tables, many = True)
    return Response(serializer.data)
@api_view(['GET'])
def getUser(request):
    tables = AuthUser.objects.all()
    serializer = AuthUserSerializer(tables, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def getAdded(request):
    tables = Added.objects.all()
    serializer = AddedSerializer(tables, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def getCategoryByName(request, name):
    tables = Category.objects.all()
    serializer = CategorySerializer(tables, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def getListing(request):
    tables = Listing.objects.all()
    serializer = ListingSerializer(tables, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def getOrders(request):
    tables = Orders.objects.all()
    serializer = OrdersSerializer(tables, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def getProduct(request):
    tables = Product.objects.all()
    serializer = ProductSerializer(tables, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def getShop(request):
    tables = Shop.objects.all()
    serializer = ShopSerializer(tables, many = True)
    return Response(serializer.data)
"""