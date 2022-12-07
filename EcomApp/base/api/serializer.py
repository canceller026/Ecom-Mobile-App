from rest_framework.serializers import ModelSerializer
from base.models import UserProfile, Added, AuthUser, Category, Courier, Listing, Orders,Product, Shop

class UserProfileSerializer(ModelSerializer):
    class Meta:
        model = UserProfile
        fields = '__all__'

class AddedSerializer(ModelSerializer):
    class Meta:
        model = Added
        fields = '__all__'
        
class CategorySerializer(ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'
        
class OrdersSerializer(ModelSerializer):
    class Meta:
        model = Orders
        fields = '__all__'
        

class AuthUserSerializer(ModelSerializer):
    class Meta:
        model = AuthUser
        fields = '__all__'

class CategorySerializer(ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'
        
class CourierSerializer(ModelSerializer):
    class Meta:
        model = Courier
        fields = '__all__'
        
class ListingSerializer(ModelSerializer):
    class Meta:
        model = Listing
        fields = '__all__'

class ProductSerializer(ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'
        
class ShopSerializer(ModelSerializer):
    class Meta:
        model = Shop
        fields = '__all__'
