"""server URL Configuration

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

from menu_data.api.viesets import *

admin.site.site_header = '오소리 관리사이트'
admin.site.site_title = '오소리'

router = routers.DefaultRouter()
router.register('cbhs1', Cbhs1_Menu_ViewSet)
router.register('cbhs2', Cbhs2_Menu_ViewSet)
#router.register('cbhs3', Cbhs2_Menu_ViewSet)


urlpatterns = [
    path('admin/', admin.site.urls),
    url(r'^menu/', include((router.urls, 'menu_data'), namespace='api')),
]
