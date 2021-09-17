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
