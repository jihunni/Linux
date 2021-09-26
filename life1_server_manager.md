systemctl stop docker.service
systemctl stop docker.socket

firewall-cmd --get-active-zones


# session timeout
/etc/profile.d/timeout.sh
```
TMOUT = 10800
```
- reference : https://ostechnix.com/auto-logout-inactive-users-period-time-linux/


```
# linux
find /dir -iname *filename*

# R
Sys.getenv()
Sys.setenv()
.libPaths
```

# future 
- notification after job :
  -  https://superuser.com/questions/345447/how-can-i-trigger-a-notification-when-a-job-process-ends
  - https://github.com/arlowhite/process-watcher
- xhost 사용

# MEME
```
make
make install
./configure --prefix=/opt/MEME_Suite/5.4.1_2/ --enable-build-libxml2 --enable-build-libxslt
```
