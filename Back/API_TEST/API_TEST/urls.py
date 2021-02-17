"""API_TEST URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from django.conf.urls import url,include
from rest_framework import routers

from rest_framework_swagger.views import get_swagger_view

import menu_data.api

router = routers.DefaultRouter()
router.register('cbhs1_menu', menu_data.api.Cbhs1_Menu_ViewSet)


urlpatterns = [

    path('admin/', admin.site.urls),
    url(r'^api/doc', get_swagger_view(title='Rest API Document')),
    url(r'^api/', include((router.urls, 'menu_data'), namespace='api')),

]
