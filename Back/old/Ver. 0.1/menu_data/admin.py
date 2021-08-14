from django.contrib import admin

# Register your models here.
from .models import Cbhs1_Menu
from .models import Cbhs2_Menu
from .models import Cbhs3_Menu

## 아래의 코드를 입력하면 BlogData를 admin 페이지에서 관리할 수 있습니다.
admin.site.register(Cbhs1_Menu)
admin.site.register(Cbhs2_Menu)
admin.site.register(Cbhs3_Menu)