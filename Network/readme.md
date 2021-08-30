# firewall (CentOS7) : https://www.server-world.info/en/note?os=CentOS_7&p=firewalld
```
systemctl enable firewalld
systemctl start firewalld
systemctl status firewalld
```

```
#check status
firewall-cmd --state

#reload
firewall-cmd --reload

#Print zone
firewall-cmd --get-zones
firewall-cmd --get-default-zone
firewall-cmd --get-active-zones

firewall-cmd --list-service
firewall-cmd --add-service=http

#check port
firewall-cmd --list-port 

#add new port
firewall-cmd --add-port=8787/tcp
```

# reference
- https://www.manualfactory.net/10153
- 
