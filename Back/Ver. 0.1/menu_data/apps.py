from django.apps import AppConfig


class MenuDataConfig(AppConfig):
    name = 'menu_data'

    def ready(self):
        from API_TEST.Menu_Paser import schedule_menu_cbhs
        schedule_menu_cbhs().start()