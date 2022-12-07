# from rest_framework.serializers import ModelSerializer
# from base.models import UserProfile, Added, Category, Courier, Listing, Orders,Product, Shop
# from django.contrib.auth import get_user_model
# from rest_framework_simplejwt.serializers import TokenObtainPairSerializer

# User = get_user_model()


# class UserProfileSerializer(ModelSerializer):
#     class Meta:
#         model = UserProfile
#         fields = '__all__'

# class AddedSerializer(ModelSerializer):
#     class Meta:
#         model = Added
#         fields = '__all__'
        
# class CategorySerializer(ModelSerializer):
#     class Meta:
#         model = Category
#         fields = '__all__'
        
# class OrdersSerializer(ModelSerializer):
#     class Meta:
#         model = Orders
#         fields = '__all__'
        

# class AuthUserSerializer(ModelSerializer):
#     class Meta:
#         model = User
#         fields = ['id','username', 'email', 'password']
#         extra_kwargs = {
#             'password': {
#                 'write_only': True,
#                 'style': {
#                     'input_type': 'password',
#                 },
#             },
#         }

#     def create(self, validated_data):
#         user = super().create(validated_data)
#         user.set_password(validated_data['password'])

#         user.save()
#         return user

# class CategorySerializer(ModelSerializer):
#     class Meta:
#         model = Category
#         fields = '__all__'
        
# class CourierSerializer(ModelSerializer):
#     class Meta:
#         model = Courier
#         fields = '__all__'
        
# class ListingSerializer(ModelSerializer):
#     class Meta:
#         model = Listing
#         fields = '__all__'

# class ProductSerializer(ModelSerializer):
#     class Meta:
#         model = Product
#         fields = '__all__'
        
# class ShopSerializer(ModelSerializer):
#     class Meta:
#         model = Shop
#         fields = '__all__'


# class UserTokenObtainPairSerializer(TokenObtainPairSerializer):
#     @classmethod
#     def get_token(cls, user):
#         token = super().get_token(user)

#         # Add custom claims
#         token['user'] = user.username

#         return token