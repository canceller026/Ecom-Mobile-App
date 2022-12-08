from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout, get_user_model
from django.urls import reverse_lazy, reverse
from django.db import connection
from .models import *
from .forms import *

User = get_user_model()
# Create your views here.

@login_required(login_url=reverse_lazy('login'))
def HomeView(request):
    list = Product.objects.all()
    context = {
        'list':list
    }
    return render(request, 'home.html', context)


def LoginView(request):
    if request.user.is_authenticated:
        return redirect('home')

    error = ''

    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        try:
            user = User.objects.get(username = username)
            user = authenticate(request, username = username, password= password)
            if user is not None:
                login(request, user)
                return redirect('home')
            else:
                error = 'Username and password does not match'
        except:
            error = 'User does not exist'
    
    context = {
        'error': error
    }
    return render(request, 'log.html', context)

def RegisterView(request):

    if request.user.is_authenticated:
        return redirect('home')

    form = RegisterForm()

    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():
            user = form.save()

            if user is not None:
                login(request,user)
                return redirect('home')
        else:
            form = RegisterForm(request.POST)

    context = {
        'form': form
    }
    return render(request, 'register.html', context)

def LogoutView(request):
    if request.user.is_authenticated:
        logout(request)

    return redirect(reverse('login'))

@login_required(login_url=reverse_lazy('login'))
def CartView(request):
    return render(request, 'cart.html')

@login_required(login_url=reverse_lazy('login'))
def ProductView(request):
    return render(request, 'product.html')

@login_required(login_url=reverse_lazy('login'))
def ListingView(request):
    data = Listing.objects.all()
    listings = {"listings":data}
    return render(request, 'listing.html',{"listings":data})

@login_required(login_url=reverse_lazy('login'))
def ShopView(request):
    data = Shop.objects.all()
    return render(request, 'shop.html',{"shops":data})

@login_required(login_url=reverse_lazy('login'))
def ShopViewID(request, pk):
    data = Product.objects.filter(shop=pk)
    print(data)
    return render(request, 'shop_id.html',{"product":data})