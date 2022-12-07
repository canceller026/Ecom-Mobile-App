from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.urls import reverse_lazy

# Create your views here.

@login_required(login_url=reverse_lazy('login'))
def HomeView(request):
    return render(request, 'home.html')


def LoginView(request):
    return render(request, 'log.html')

def RegisterView(request):
    return render(request, 'register.html')

@login_required(login_url=reverse_lazy('login'))
def CartView(request):
    return render(request, 'cart.html')

@login_required(login_url=reverse_lazy('login'))
def ProductView(request):
    return render(request, 'product.html')