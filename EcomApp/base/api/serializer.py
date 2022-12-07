from rest_framework.serializers import ModelSerializer
from base.models import UserProfile

class UserProfileSerializer(ModelSerializer):
    class Meta:
        model = UserProfile
        fields = '__all__'