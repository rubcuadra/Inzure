from django.conf.urls import url, include
from rest_framework_nested import routers
from .views import *

router = routers.SimpleRouter()
router.register(r'android',AndroidViewSet)
router.register(r'mac',MacViewSet)

urlpatterns = [
	url(r'^api/v1/', include(router.urls)),
]