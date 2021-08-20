# Disk Quota
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
