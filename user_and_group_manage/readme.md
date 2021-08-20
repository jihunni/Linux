# 사용자 계정 관련 파일 및 명령
## 사용자 계정 관련 파일
- /etc/passwd: 로그인ID:x:UID:GID:설명:home directory:shell
- /etc/shade: 로그인ID:암호:최종 변경일:MIN:MAX:Warning:Inactive:expire:flag
- /etc/login.defs
- /etc/group: 그룹이름:x:GID:그룹멤버
- /etc/gshadow: 그룹이름:그룹암호:관리자:그룹멤버
- /etc/skel
  - 사용자 계정을 생성할 때 시스템 운영 정책에 따라 사용자 게정의 홈 디렉토리에 공통으로 배포해야 할 파일
  - /etc/skel 디렉터리에 파일을 만들어 놓으면 사용자 계정 생성 시에 자동으로 복사된다.

## 명령 
```
useradd -m -d /home/[username/userID] -u [UID] -g [GID] -s [shell] [username]
```
> -m : to make a home directory (required)  
> -d : to assign an address for home directory  
> /etc/default/useradd (Warning! Do not modify directly)

```
passwd [UserName ] #change passwd
```
> -l : lock an account
> -u : unlock an account
> -d : remove password
> /etc/shadow
> > '!!' means an account is locked.
```
passwd -g [GroupName]
```

```
usermod -u [UID] -o -g [GID] -G [GID] -d [directory] -s [shell] -c [description] -f [inactive date] -e [expire date]
```

# `CentOS7` Disk Quota
```
# run quota tool with expert mode
[root@dlp ~]# xfs_quota -x /home
```
> -x : expert mode   
> /home : directory  


```
# show current status
xfs_quota> state
User quota state on /home (/dev/sdb1)
  Accounting: ON
  Enforcement: ON
  Inode: #136 (2 blocks, 2 extents)
Group quota state on /home (/dev/sdb1)
  Accounting: ON
  Enforcement: ON
  Inode: #137 (2 blocks, 2 extents)
Project quota state on /home (/dev/sdb1)
  Accounting: OFF
  Enforcement: OFF
  Inode: #137 (2 blocks, 2 extents)
Blocks grace time: [7 days 00:00:30]
Inodes grace time: [7 days 00:00:30]
Realtime Blocks grace time: [7 days 00:00:30]
```

```
# show usage reports
xfs_quota> report -h
User quota on /home (/dev/sdb1)
                        Blocks
User ID      Used   Soft   Hard Warn/Grace
---------- ---------------------------------
root            0      0      0  00 [------]
cent          16K      0      0  00 [------]

Group quota on /home (/dev/sdb1)
                        Blocks
Group ID     Used   Soft   Hard Warn/Grace
---------- ---------------------------------
root            0      0      0  00 [------]
cent          16K      0      0  00 [------]

```

```
# set Soft Limit 9G, Hard Limit 10G (specify with kilo bytes) to "cent" user
xfs_quota> limit bsoft=9g bhard=10g cent
```


```
# show reports
xfs_quota> report -h -u
User quota on /home (/dev/sdb1)
                        Blocks
User ID      Used   Soft   Hard Warn/Grace
---------- ---------------------------------
root            0      0      0  00 [------]
cent          16K     9G    10G  00 [------]
```
> -h: human readable  
> -u : user  
> -g : group  


```
# possible to set on non-interactive mode
[root@dlp ~]# xfs_quota -x -c 'limit -g bsoft=9g bhard=10g cent' /home
[root@dlp ~]# xfs_quota -x -c 'report -h -g' /home
Group quota on /home (/dev/sdb1)
                        Blocks
Group ID     Used   Soft   Hard Warn/Grace
---------- ---------------------------------
root            0      0      0  00 [------]
cent          16K     9G    10G  00 [------]
```

# Reference
- https://www.server-world.info/en/note?os=CentOS_7&p=quota
