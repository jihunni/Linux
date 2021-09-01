# change docker bridge network
Reference : https://docs.docker.com/network/bridge/

```
# systemctl stop docker.service
# ip addr show docker0   
4: docker0: <BROADCAST,MULTICAST> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:a1:65:bc:55 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 scope global docker0
       valid_lft forever preferred_lft forever
       
# ip link set dev docker0 down
# ifconfig

# vi /etc/docker/daemon.json
{
"bip": "10.0.0.1/16"
}

# ip link set dev docker0 up 
# ifconfig

# systemctl start docker.service
       

```

# reference
- https://www.manualfactory.net/10153
- https://www.lesstif.com/ws/firewalld-43844015.html
