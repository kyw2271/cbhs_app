from django.apps import AppConfig


class MenuDataConfig(AppConfig):
    name = 'menu_data'

    def ready(self):
        from Menu_Paser import schedule_05m_menu_cbhs1
        schedule_05m_menu_cbhs1().start()