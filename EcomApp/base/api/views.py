from rest_framework.decorators import api_view
from rest_framework.response import Response
from base.models import UserProfile
from .serializer import UserProfileSerializer
@api_view(['GET'])
def getShop(request):
    routes =[
        'GET /api/shops',
        'GET /api/shops/:id'
    ]
    return Response(routes)

@api_view(['GET'])
def getProfile(request):
    profiles = UserProfile.objects.all()
    serializer = UserProfileSerializer(profiles, many = True)
    return Response(serializer.data)