from django.http import JsonResponse
import requests
from urllib.parse import unquote
import uuid
from apscheduler.schedulers.background import BackgroundScheduler
import random
from django.views.decorators.csrf import csrf_exempt
from rest_framework.permissions import IsAuthenticated
from sympy import true
from .serializers import ResSerializer,EmailSerializer
from rest_framework.views import APIView
from .models import Users
from .serializers import *
import time
import os
import random
import smtplib
from .redis import r
from email.mime.text import MIMEText
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth import authenticate
from django.contrib.auth.models import User
from django.utils.decorators import method_decorator
from rest_framework_simplejwt.tokens import RefreshToken,AccessToken
# Create your views here.
BASE_URL="http://81.70.119.19:8080"
def clear_fangke_set():
    r.delete("fangke")
    r.sadd("fangke")  #重建空集合，key不会消失
    print("=== 已清空点赞集合 ===")
scheduler = BackgroundScheduler()
# cron：每天12点0分0秒执行
scheduler.add_job(clear_fangke_set, "cron", hour=0, minute=0, second=0)
# 启动
scheduler.start()
def get_province_by_ip(ip):
    try:
        url = f"http://ip-api.com/json/{ip}?lang=zh-CN"
        res = requests.get(url,timeout=3)
        data = res.json()
        if data["status"] == "success":
            province = data["regionName"]
            city = data["city"]
            return province,city
    except Exception as e:
        print("查询位置失败",e)
    return "未知","未知"
def clear_dir(folder):
    for f in os.listdir(folder):
        fp = os.path.join(folder, f)
        if os.path.isfile(fp):
            os.remove(fp)
def get_username_from_token(token):
    try:
        print(token)
        token_obj=AccessToken(token)
        username=User.objects.filter(id=token_obj.get("user_id")).first().username
        if not username:
            return 0
        return username
    except:
        return 0
def send_code_email(receiver_email, code):
    sender = "3163981881@qq.com"
    auth_code = "qcfhiaywwgpxdgja"  # 你的授权码
    msg = MIMEText(f"验证码：{code}，三分钟内有效")
    msg["Subject"] = "邮箱验证"
    msg["From"] = sender
    msg["To"] = receiver_email
    # QQ邮箱SSL方式，465端口
    server = smtplib.SMTP_SSL("smtp.qq.com", 465)
    server.login(sender, auth_code)
    server.sendmail(sender, receiver_email, msg.as_string())
    server.quit()
# @method_decorator(csrf_exempt,name='dispatch')
class LoginView(APIView):
    def post(self,request):
        data=request.data
        username=data.get('username')
        password=data.get('password')
        print(username,password)
        user=authenticate(username=username,password=password)
        if user:
            email = User.objects.filter(username=username).first().email
            refresh = RefreshToken.for_user(user)
            access_token=str(refresh.access_token)
            refresh_token=str(refresh)
            r.set("username",username)
            r.set("email",email)
            return Response(data={"access_token":access_token,"refresh_token":refresh_token,"code":200},status=status.HTTP_200_OK)
        if not r.get("times"):
            r.set("times",1,ex=3600*24)
        else:
            i=int(r.get("times"))
            r.set("times",i+1,ex=3600*24)
        warn=''
        if r.get("times")!=None and int(r.get("times"))>=3:
            warn=f"你今天已经尝试{r.get('times')}次,若错误次数超过6次,将被锁定"
        if int(r.get("times"))>=6:
            warn="已锁定,请24小时后重新登录"
        print(warn)
        return Response(data={'code':400,'msg':'登陆失败,账号或密码错误'},status=status.HTTP_400_BAD_REQUEST)
class SendEmail(APIView):
    def post(self,request):
        ser=EmailSerializer(data=request.data)
        if not ser.is_valid():
            print(list(ser.errors.values())[0][0])
            return Response({"msg":list(ser.errors.values())[0][0]},status=status.HTTP_400_BAD_REQUEST)
        if User.objects.filter(email=request.data["email"]).exists():
            return Response({"msg":"该邮箱已注册账号"},status=status.HTTP_400_BAD_REQUEST)
        if r.exists("time") and time.time()-float(r.get("time"))<60:
            return Response({"msg":"60秒内请勿重复发送"},status=status.HTTP_400_BAD_REQUEST)
        email=request.data.get(('email'))
        vertifycode=random.randint(100000,1000000)
        ver=str(vertifycode)
        request.session["email"]=email
        request.session["ver"]=ver
        print(email,ver)
        now=time.time()
        r.set("time", str(now))
        try:
            r.setex(str(email), 180, str(vertifycode))
            send_code_email(email, ver)
            return Response({"msg":"验证码发送成功"},status=status.HTTP_200_OK)
        except:
            return Response({"msg":"无效的邮箱号"},status=status.HTTP_400_BAD_REQUEST)
class Res(APIView):
    def post(self,request):
        data=request.data
        ser=ResSerializer(data=data)
        not_same=data.get("password")!=data.get("password_1")
        email_err=data.get("email")!=request.session.get("email")
        ver_err=data.get("vertifycode")!=request.session.get("ver")
        if not ser.is_valid() or not_same or email_err or ver_err:
            sa_ms=""
            us=''
            email_ms=''
            ver_ms=''
            if not data.get("username").isdigit():
                us="请输入纯数字"
            if not_same:
                sa_ms="两次密码不一致"
            if email_err:
                email_ms="邮箱错误"
            if ver_err:
                ver_ms="验证码错误"
            errs=ser.errors
            print(errs)
            return Response({"username_err":errs.get("username",[""])[0],"password_err":errs.get("password",[""])[0],"not_digit":us,"not_same":sa_ms,"email_err":email_ms,"ver_err":ver_ms},status=status.HTTP_400_BAD_REQUEST)
        else:
            if User.objects.filter(username=data.get("username")):
                return Response({'msg':"该账号已存在","code":403},status=status.HTTP_403_FORBIDDEN)
            User.objects.create_user(username=data.get("username"),password=data.get("password"),email=data.get("email"))
            Fans.objects.create(username=data.get("username"),fans_username=data.get("username"))
            Users.objects.create(username=data.get("username"),name="用户"+data.get("username"),fans=0,guanzhu=0,fangke=0,avatar="avatar\\img.png")
            Files.objects.create(username=data.get("username"))
            del request.session['email']
            del request.session['ver']
            r.set(f'{data.get("username")}gender','')
            r.set(f'{data.get("username")}ip','')
            return Response(status=status.HTTP_200_OK)
class Index(APIView):
    def get(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        username=get_username_from_token(token)
        if not username:
            return Response({'code':403},status=status.HTTP_403_FORBIDDEN)
        user=Users.objects.filter(username=username)
        ser=UsersSerializer(user,many=True)
        data=ser.data
        usernames_ob=Fans.objects.filter(fans_username=username).all()
        username_list=[]
        for i in usernames_ob:
            username_list.append(i.username)
        dos=Dongtai.objects.filter(username__in=username_list)
        ddd=dos.order_by("-id")[:2]
        ser2=Dong_Serializer(ddd,many=True)
        data2=ser2.data
        dongs=Users_Who_Likes.objects.filter(username=username).all()
        ll=[]
        dt=Fans.objects.filter(fans_username=username).all()
        pp=[]
        for n in dt:
            pp.append(n.username)
        files=Files.objects.exclude(username__in=pp)
        ser3=Files_Serializer(files,many=True)
        da=ser3.data
        oopp=Files.objects.get(username=username)
        ip=oopp.ip
        gender=oopp.gender
        d=random.sample(da,k=min(len(da),3))
        new_ms=[]
        print(r.smembers(f"new_message{username}"))
        if r.smembers(f"new_message{username}")!=[]:
            for n in r.smembers(f"new_message{username}"):
                new_ms.append(n)
        for l in d:
            print(l.get("username"))
            ui=Users.objects.get(username=l['username'])
            av=ui.avatar.url
            nn=ui.name
            l['avatar_url']=av
            l["name"]=nn
        print(d)
        llll=Dongtai.objects.filter(username=username).all()
        ol=[]
        for ooo in llll:
            ol.append(ooo.id)
        qs=Users_Who_Likes.objects.filter(dong_id__in=ol)
        lk=qs.count()
        for oo in dongs:
            ll.append(oo.dong_id)
        return Response([data,data2,{'dongs_list':ll},{'now_username':username,'gender':gender,'ip':ip},{"file_list":d},{"fangke":lk,"new_ms":new_ms}],status=status.HTTP_200_OK)
class Send_Img(APIView):
    def post(self,request):
        token=request.POST.get("token")
        t=AccessToken(token)
        username=get_username_from_token(token)
        if not username:
            return Response({'code':401},status=status.HTTP_401_UNAUTHORIZED)
        id=t['user_id']
        img=request.FILES.get("img")
        # 取出原始后缀 .jpg/.png
        ext = os.path.splitext(img.name)[-1]
        # 生成随机唯一英文名称
        random_name = str(uuid.uuid4()) + ext
        # 最终存储路径
        p = f"media/article/{random_name}"
        # path=p+"1"
        path=p
        # if not os.path.exists(path):
        #     r.set(f'{img.name}',1)
        # if os.path.exists(path):
        #     nu=int(r.get(f"{img.name}"))+1
        #     r.set(f"{img.name}",nu)
        #     path=p+str(nu)
        with open(path,"wb") as f:
            for chunk in img.chunks():
                f.write(chunk)
        url=f"{BASE_URL}/{path}"
        return Response({'img_url':url},status=status.HTTP_200_OK)
class Chexiao_img(APIView):
    def post(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        t=AccessToken(token)
        url=request.data.get("url")
        os.remove(unquote(url[len(BASE_URL)+1:]))
        return Response(status=status.HTTP_200_OK)
class Release(APIView):
    def post(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        print(token)
        t=AccessToken(token)
        username=get_username_from_token(token)
        if not username:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        data=request.data
        name=Users.objects.filter(username=username).first().name
        data['name']=name
        data["username"]=username
        if t['user_id']==13:
            data['img1_url']='media/avatar/img_1.png'
            data['img2_url'] = 'media/avatar/img_1.png'
            data['img3_url'] = 'media/avatar/img_1.png'
            data['text']='我是李明轩,这是我照片,我就是个乐子🤣🤣🤣'
        print(data)
        ser=Dong_Serializer(data=data)
        if ser.is_valid():
            ser.save()
        else:
            print(ser.errors)
            return Response(status=status.HTTP_400_BAD_REQUEST)
        user=Users.objects.filter(username=username).first()
        user.dongtai+=1
        user.save()
        return Response(status=status.HTTP_200_OK)
class Del_Dong(APIView):
    def delete(self,request,pk):
        username=Dongtai.objects.get(id=pk).username
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        u=get_username_from_token(token)
        id=User.objects.get(username=username).id
        if id==13:
            return Response(status=status.HTTP_402_PAYMENT_REQUIRED)
        try:
            obj=Dongtai.objects.get(id=pk)
            for i in range(6):
                path=getattr(obj,f"img{i+1}_url")
                if path!='':
                    print(path)
                    os.remove(path)
            Users_Who_Likes.objects.filter(dong_id=pk).delete()
            username=obj.username
            print(f"new_message{u}",str(pk))
            if r.sismember(f"new_message{u}", str(pk)):
       	        r.srem(f"new_message{u}", str(pk))
                print("删除后的集合:",r.smembers(f"new_message{username}"))
            user = Users.objects.filter(username=username).first()
            Comments1.objects.filter(dong_id=pk).delete()
            user.dongtai-=1
            user.save()
            obj.delete()
            return Response(status=status.HTTP_200_OK)
        except:
            return Response(status=status.HTTP_404_NOT_FOUND)
class Get_dongtai(APIView):
    def get(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        print(token)
        username=get_username_from_token(token)
        if not username:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        aaa=request.GET.get("pk")

        print(aaa)
        users = Fans.objects.filter(fans_username=username).all()
        usernames = []
        for u in users:
            usernames.append(u.username)
        dongtais = Dongtai.objects.filter(username__in=usernames)
        if aaa:
            print('红红火火恍恍惚惚',aaa)
            dongtais=Dongtai.objects.filter(username=aaa)
        ddd=Users_Who_Likes.objects.filter(username=username).all()
        id_list=[]
        d={}
        for m in ddd:
            id_list.append(m.dong_id)
        ser=Dong_Serializer(dongtais,many=True)
        data=ser.data[::-1]
        for l in data:
            d[f"{l.get('id')}"]=l.get('username')
            l["username1"]=username
        print(data)
        return Response([data,{"id_list":id_list},{'username':username},d],status.HTTP_200_OK)
class Avatar(APIView):
    def post(self,request):
        token=request.POST.get("token")
        print(token)
        token_obj=AccessToken(token)
        if time.time() > token_obj["exp"]:
            return Response({'code':403},status=status.HTTP_403_FORBIDDEN)
        if token_obj["user_id"]==13:
            return Response({'code':402},status=status.HTTP_402_PAYMENT_REQUIRED)
        old_url=request.data.get("url")
        print(old_url)
        if old_url!="/media/avatar/img.png":
            os.remove(old_url[1:])
        png=request.FILES.get("img")
        username=User.objects.filter(id=token_obj["user_id"]).first().username
        if not png:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        with open(f"media/avatar/{png.name}","wb") as f:
            for i in png.chunks():
                f.write(i)
        user=Users.objects.filter(username=username)
        user.update(avatar=f"avatar/{png.name}")
        dongs=Dongtai.objects.filter(username=username).all()
        for dong in dongs:
            dong.ava_url=f"{BASE_URL}/media/avatar/{png.name}"
            dong.save()
        return Response(status=status.HTTP_200_OK)
class NichengModify(APIView):
    def post(self,request):
        token=request.data.get("token")
        token_obj=AccessToken(token)
        now=time.time()
        if now > token_obj["exp"]:
            return Response({'code':403},status=status.HTTP_403_FORBIDDEN)
        username=User.objects.filter(id=token_obj["user_id"]).first().username
        if token_obj['user_id']==13:
            return Response(status=status.HTTP_402_PAYMENT_REQUIRED)
        new_nicheng=request.data.get("nicheng")
        if len(new_nicheng)>8:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        user=Users.objects.filter(username=username)
        user.update(name=new_nicheng)
        user_1=Dongtai.objects.filter(username=username)
        user_1.update(name=new_nicheng)
        return Response(status=status.HTTP_200_OK)
class Offer_Center_Message(APIView):
    def post(self,request):
        token=request.data.get("token")
        token_obj=AccessToken(token)
        username=User.objects.filter(id=token_obj["user_id"]).first().username
        user=Users.objects.filter(username=username).first()
        return Response({'nicheng':user.name,'username':username,'avatar_url':user.avatar.url},status=status.HTTP_200_OK)
class Vertify(APIView):
    def post(self,request):
        token=request.data.get("token")
        username=get_username_from_token(token)
        email=User.objects.filter(username=username).first().email
        email_input=request.data.get("email")
        if not username:
            return Response({'code':403},status=status.HTTP_403_FORBIDDEN)
        if email_input!=email:
            return Response({'code':400},status=status.HTTP_400_BAD_REQUEST)
        vertify_code=random.randint(100000,999999)
        try:
            r.setex("vertifycode",180,vertify_code)
            send_code_email(email,vertify_code)
            return Response(status=status.HTTP_200_OK)
        except:
            return Response({'code':500},status=status.HTTP_500_INTERNAL_SERVER_ERROR)
class New_Password_Vertification(APIView):
    def post(self,request):
        token=request.data.get("token")
        username=get_username_from_token(token)
        if not username:
            return Response({'code':403},status=status.HTTP_403_FORBIDDEN)
        user=User.objects.filter(username=username).first()
        ok=user.check_password(request.data.get("password1"))
        ok2=request.data.get("vertifycode")==r.get("vertifycode")
        print(request.data.get("password2"))
        if not ok or not ok2:
            password_msg="原密码错误" if not ok else ' '
            ver_msg="验证码错误" if not ok2 else ' '
            return Response({"code":400,'pwd_msg':password_msg,'ver_msg':ver_msg},status=status.HTTP_400_BAD_REQUEST)
        if request.data.get("password2") != request.data.get("password3"):
            return Response({'code':401},status=status.HTTP_401_UNAUTHORIZED)
        if request.data.get("password2")==None:
            return Response({'code':406},status=status.HTTP_406_NOT_ACCEPTABLE)
        if len(request.data.get("password2"))<8 or len(request.data.get("password2"))>12:
            return Response({'code':405},status=status.HTTP_405_METHOD_NOT_ALLOWED)
        user.set_password(request.data.get("password2"))
        user.save()
        return Response(status=status.HTTP_200_OK)
class Delete_User(APIView):
    def post(self,request):
        token=request.data.get("token")
        username=get_username_from_token(token)
        token_obj=AccessToken(token)
        id=token_obj.get("user_id")
        password=request.data.get("password")
        user=User.objects.filter(id=id).first()
        ok=user.check_password(password)
        if not username:
            return Response({'code':403},status=status.HTTP_403_FORBIDDEN)
        if not ok:
            return Response({'code':400},status=status.HTTP_400_BAD_REQUEST)
        user.delete()
        Files.objects.filter(username=username).delete()
        Fans.objects.filter(username=username).delete()
        Fans.objects.filter(fans_username=username).delete()
        Users_Who_Likes.objects.filter(username=username)
        Dongtai.objects.filter(username=username).delete()
        Comments1.objects.filter(user_id=id).delete()
        Files.objects.filter(username=username).delete()
        Users.objects.filter(username=username).delete()
        r.flushdb()
        return Response(status=status.HTTP_200_OK)
class Liked(APIView):
    def post(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        username=get_username_from_token(token)
        if not username:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        dongtai_id=request.data.get('dongtai_id')
        print(dongtai_id)
        dong=Dongtai.objects.filter(id=dongtai_id).first()
        dong.likes+=1
        dong.save()
        Users_Who_Likes.objects.create(dong_id=dongtai_id,username=username)
        return Response({'likes':dong.likes,"username1":dong.username,'username2':username},status=status.HTTP_200_OK)
class Disliked(APIView):
    def post(self,request):
        token = request.META.get("HTTP_AUTHORIZATION")[7:]
        username = get_username_from_token(token)
        if not username:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        dongtai_id=request.data.get('dongtai_id')
        dong = Dongtai.objects.filter(id=dongtai_id).first()
        dong.likes-=1
        dong.save()
        msg=Users_Who_Likes.objects.filter(dong_id=dongtai_id,username=username)
        msg.delete()
        return Response({"likes":dong.likes,"username1":username,"username2":dong.username},status=status.HTTP_200_OK)
class Comment(APIView):
    def post(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        username=get_username_from_token(token)
        if not username:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        text=request.data.get("text")
        dong_id=request.data.get("dong_id")
        user=Users.objects.filter(username=username).first()
        dong=Dongtai.objects.filter(id=dong_id).first()
        now=time.time()
        dt=time.localtime(now)
        s=time.strftime("%Y-%m-%d %H:%M",dt)
        if username=='999999':
            Comments1.objects.create(comment='我李明轩就是个东子🤣🤣🤣', user=user, dong=dong, time=s)
            return Response(status=status.HTTP_200_OK)
        Comments1.objects.create(comment=text,user=user,dong=dong,time=s)
        dong.comments+=1
        dong.save()
        auth=Dongtai.objects.get(id=dong_id).username
        if username!=auth:
            r.sadd(f"new_message{auth}",dong_id)
        return Response(status=status.HTTP_200_OK)
    def get(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        print(token)
        username=get_username_from_token(token)
        if not username:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        dong_id=request.GET.get("dong_id")
        print(r.smembers(f"new_message{username}"))
        print(type(r.smembers(f"new_message{username}")))
        if r.sismember(f"new_message{username}",dong_id):
            r.srem(f"new_message{username}",dong_id)
            print(r.smembers(f"new_message{username}"))
        dong=Dongtai.objects.filter(id=int(dong_id)).first()
        comments=Comments1.objects.filter(dong_id=int(dong_id))
        print(comments.query)
        data_list=[]
        for i in comments:
            data={}
            data["id"]=i.id
            data["username"]=i.user.username
            data["blog_username"]=i.dong.username
            data["now_username"]=username
            data["ava_url"]=i.user.avatar.url
            data["name"]=i.user.name
            data["time"]=i.time
            data["text"]=i.comment
            data_list.append(data)
        return Response(data_list[::-1],status=status.HTTP_200_OK)
class Del_Co(APIView):
    def delete(self,request,pk):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        username=get_username_from_token(token)
        if not username:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        comment=Comments1.objects.filter(id=pk).first()
        dong=comment.dong
        dong.comments-=1
        dong.save()
        comment.delete()
        print(dong.comments)
        return Response({"co_num":dong.comments},status=status.HTTP_200_OK)
class Get_Files(APIView):
    def get(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        username=get_username_from_token(token)
        if not username:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        aaa=request.GET.get("pk")
        print("哈哈哈哈哈:",aaa)
        if aaa:
            username=aaa
            username1 = get_username_from_token(token)
            r.sadd("fangke",username1)
            r.expire("fangke",24*3600)
            print("红红火火恍恍惚惚")
        file=Files.objects.filter(username=username).first()
        username1 = get_username_from_token(token)
        ser=Files_Serializer(file)
        data=ser.data
        opp=Users.objects.get(username=username)
        avatar_url=opp.avatar.url
        name=opp.name
        data['avatar_url']=avatar_url
        data['name']=name
        oopp=Fans.objects.filter(username=username,fans_username=username1)
        if oopp.exists():
            data['iffocus']="yes"
        else:
            data['iffocus']="no"
        qian=r.get(f"{username}qianming")
        if qian==None:
            data["qian"]=''
        else:
            data["qian"]=qian
        data["username1"]=username1
        print(data)
        return Response(data,status=status.HTTP_200_OK)
    def post(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        username = get_username_from_token(token)
        if not username:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        data=request.data
        data["username"]=username
        file = Files.objects.filter(username=username).first()
        ser = Files_Serializer(file)
        print(ser.data,data)
        if ser.data==data:
            return Response(status=status.HTTP_204_NO_CONTENT)
        ser2=Files_Serializer(instance=file,data=data,partial=True)
        if ser2.is_valid():
            ser2.save()
        return Response(status=status.HTTP_200_OK)
class Focus(APIView):
    def post(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        username=get_username_from_token(token)
        if not username:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        username1=request.data.get("username")
        Fans.objects.create(username=username1,fans_username=username)
        gg=Users.objects.get(username=username)
        gg2=Users.objects.get(username=username1)
        gg2.fans+=1
        gg2.save()
        gg.guanzhu+=1
        gg.save()
        return Response(status=status.HTTP_200_OK)
    def get(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        username=get_username_from_token(token)
        if not username:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        users=Fans.objects.filter(fans_username=username).exclude(username=username).all()
        if not users.exists():
            return Response(status=status.HTTP_400_BAD_REQUEST)
        user_list=[]
        data_list=[]
        for n in users:
            user_list.append(n.username)
        for u in user_list:
            uu=Users.objects.get(username=u)
            uui=Files.objects.get(username=u)
            d={}
            d['ye']=''
            fa = Fans.objects.filter(username=username,fans_username=u)
            if fa.exists():
                d['ye']="互相关注"
            d['username']=u
            d['uid']=uui.id
            d['avatar_url']=uu.avatar.url
            d['name']=uu.name
            d['ip']=uui.ip
            d['gender']=uui.gender
            data_list.append(d)
        return Response(data_list,status=status.HTTP_200_OK)
    def delete(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        username=get_username_from_token(token)
        username1=request.data.get("username")
        user1=Users.objects.get(username=username)
        user2=Users.objects.get(username=username1)
        user1.guanzhu-=1
        user2.fans-=1
        user1.save()
        user2.save()
        Fans.objects.get(username=username1, fans_username=username).delete()
        return Response(status.HTTP_200_OK)
class Get_Fans(APIView):
    def get(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        username=get_username_from_token(token)
        if not username:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        fa=Fans.objects.filter(username=username).exclude(fans_username=username).all()
        if not fa.exists():
            return Response(status=status.HTTP_404_NOT_FOUND)
        ul=[]
        data_list=[]
        for u in fa:
            ul.append(u.fans_username)
        for t in ul:
            uu = Users.objects.get(username=t)
            uui = Files.objects.get(username=t)
            d = {}
            d['ye'] = '回关'
            fe = Fans.objects.filter(username=t, fans_username=username)
            if fe.exists():
                d['ye'] = "互相关注"
            d['username'] = t
            d['avatar_url'] = uu.avatar.url
            d['name'] = uu.name
            d['ip'] = uui.ip
            d['gender'] = uui.gender
            data_list.append(d)
        return Response(data_list,status=status.HTTP_200_OK)
class Qian(APIView):
    def get(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        username=get_username_from_token(token)
        username1=request.GET.get("username")
        if username!=username1:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        return Response(status=status.HTTP_200_OK)    
    def post(self,request):
        token=request.data.get("token")
        username=get_username_from_token(token)
        if username!=0:
            r.set(f"{username}qianming",request.data.get("val"))
        return Response(status=status.HTTP_200_OK)
class More2(APIView):
    def get(self,request):
        token=request.META.get("HTTP_AUTHORIZATION")[7:]
        username=get_username_from_token(token)
        username1=request.GET.get("username")
        dongs=Dongtai.objects.filter(username=str(username1)).all()
        ser=Dong_Serializer(dongs,many=True)
        data=ser.data
        lo=Users_Who_Likes.objects.filter(username=username).all()
        dongid_li=[]
        for i in lo:
            dongid_li.append(i.dong_id)
        print(dongid_li)
        for m in data:
            m['lik_li']=dongid_li
            m["username1"]=username
        print(data)
        return Response(data,status=status.HTTP_200_OK)
class If_Focus(APIView):
    def post(self,request):
        token=request.data.get("token")
        username=get_username_from_token(token)
        username1=request.data.get("username1")
        ggg=Fans.objects.filter(username=username1,fans_username=username)
        if ggg.exists():
            return Response(status=status.HTTP_200_OK)
        return Response(status=status.HTTP_400_BAD_REQUEST)
