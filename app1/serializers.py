from rest_framework import serializers
from django.contrib.auth.models import User
from .models import *
class ResSerializer(serializers.ModelSerializer):
    class Meta:
        model=User
        fields=["username","password","email"]
    username = serializers.CharField(required=True,min_length=5,max_length=12,error_messages={"min_length":"用户名不能小于5位","max_length":"用户名不能大于12位"})
    password=serializers.CharField(min_length=8,max_length=12,required=True,error_messages={"min_length":"密码不能小于8位","max_length":"密码不能大于12位"})
class EmailSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True,error_messages={"required": "不能为空","invalid": "邮箱格式不正确"})
class UsersSerializer(serializers.ModelSerializer):
    class Meta:
        model = Users
        fields = ['name','fans','guanzhu','fangke','avatar','dongtai','username']
class Dong_Serializer(serializers.ModelSerializer):
    class Meta:
        model=Dongtai
        fields = "__all__"
class Files_Serializer(serializers.ModelSerializer):
    class Meta:
        model=Files
        exclude=["id"]

