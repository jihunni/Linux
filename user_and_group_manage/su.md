# 일반 사용자 su 명령어 막기
reference : https://mslee89.tistory.com/57  

```
ls -l /bin/su
chmod 4755 /bin/su
```
```
vi /etc/pam.d/su
auth  required  pam_wheel.so use_uid
```
주석해제

/etc/group
```
root:x:0:
bin:x:1:
daemon:x:2:
sys:x:3:
adm:x:4:
tty:x:5:
disk:x:6:
lp:x:7:
mem:x:8:
kmem:x:9:
wheel:x:10:root,jihun
```

