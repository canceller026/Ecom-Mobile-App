from django.shortcuts import render

# Create your views here.
def HomeView(request):
    return render(request, 'home.html')

def LoginView(request):
    return render(request, 'log.html')

def CartView(request):
    return render(request, 'cart.html')

def ProductView(request):
    return render(request, 'product.html')