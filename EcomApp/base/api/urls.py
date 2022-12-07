from django.urls import path, include
from . import views
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenRefreshView

router = DefaultRouter()
router.register(r'added', views.AddedViewSet)
router.register(r'category', views.CategoryViewSet)
router.register(r'product', views.ProductViewSet)
router.register(r'orders', views.OrdersViewSet)
router.register(r'listing', views.ListingViewSet)
router.register(r'shop', views.ShopViewSet)
router.register(r'courier', views.CourierViewSet)
router.register(r'user', views.AuthUserViewSet)
router.register(r'profile', views.UserProfileViewSet)

urlpatterns = [
    path('token/', views.UserTokenObtainPairView.as_view(), name='token_obtain'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('', include(router.urls)),

]
"""
path('profile', views.getProfile),
path('added', views.getAdded),
path('user', views.getUser),
path('category', views.getCategory),
path('product', views.getProduct),
path('orders', views.getOrders),
path('listing', views.getListing),
path('shop', views.getShop),
path('courier', views.getCourier),
"""