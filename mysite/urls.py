"""mysite URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
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
from django.views.generic import TemplateView
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path
from app1 import views
from rest_framework_simplejwt.views import TokenRefreshView
urlpatterns = [
    path('',TemplateView.as_view(template_name="index.html")),
    path('center/',TemplateView.as_view(template_name="center.html")),
    path('comments/',TemplateView.as_view(template_name="commens.html")),
    path('email/',TemplateView.as_view(template_name="email.html")),
    path('login/',TemplateView.as_view(template_name="login.html")),
    path('modify_password/',TemplateView.as_view(template_name="modify_password.html")),
    path('more/',TemplateView.as_view(template_name="more.html")),
    path('nicheng/',TemplateView.as_view(template_name="nicheng.html")),
    path('register/',TemplateView.as_view(template_name="res.html")),
    path('ziliao/',TemplateView.as_view(template_name="ziliao.html")),
    path("my_focus/",TemplateView.as_view(template_name="my_focus.html")),
    path("my_fans/",TemplateView.as_view(template_name="fans.html")),
    path("kongjian/<str:pk>",TemplateView.as_view(template_name="kongjian.html")),
    path("more2/<str:pk>",TemplateView.as_view(template_name="more2.html")),
    path('admin/', admin.site.urls),
    path('log/',views.LoginView.as_view()),
    path("sendmail/",views.SendEmail.as_view()),
    path("res/",views.Res.as_view()),
    path("refresh_token/",TokenRefreshView.as_view()),
    path("index/",views.Index.as_view()),
    path("upload_avatar/",views.Avatar.as_view()),
    path("nicheng_modify/",views.NichengModify.as_view()),
    path("get_center/",views.Offer_Center_Message.as_view()),
    path("vertify/",views.Vertify.as_view()),
    path("new_password_vertification/",views.New_Password_Vertification.as_view()),
    path("delete_acount/",views.Delete_User.as_view()),
    path("send_img/",views.Send_Img.as_view()),
    path("chexiao_img/",views.Chexiao_img.as_view()),
    path("release/",views.Release.as_view()),
    path("get_dongtai/",views.Get_dongtai.as_view()),
    path("liked/",views.Liked.as_view()),
    path("disliked/",views.Disliked.as_view()),
    path("comment/",views.Comment.as_view()),
    path("del_dong/<int:pk>/",views.Del_Dong.as_view()),
    path("get_files/",views.Get_Files.as_view()),
    path("del_co/<int:pk>",views.Del_Co.as_view()),
    path("focus/",views.Focus.as_view()),
    path("get_fans/",views.Get_Fans.as_view()),
    path("qianming/",views.Qian.as_view()),
    path("more_2/",views.More2.as_view()),
    path("if_focus/",views.If_Focus.as_view()),
]
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)