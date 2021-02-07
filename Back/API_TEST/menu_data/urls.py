from django.conf.urls import url
from rest_framework.urlpatterns import format_suffix_patterns
from menu_data import views



urlpatterns = [
    url(r'/1/', views.Cbhs1_Menu_ViewSet),
    url(r'1/', views.l),
]

urlpatterns = format_suffix_patterns(urlpatterns)