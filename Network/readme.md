Ref: https://it-serial.tistory.com/7
```
ifconfig
netstat -anp
vi /etc/sysconfig/network-scripts/ifcfg-eth1 
ping [ip_address]
```

# firewall (CentOS7) : https://www.server-world.info/en/note?os=CentOS_7&p=firewalld

## Intro to filewall
![image](https://user-images.githubusercontent.com/48517782/131292643-2f1ef58d-605a-466a-bfd1-fce9c0594e3c.png)
Linux 커널 2.2 까지는 ipchains 이라는 패킷 필터링/방화벽 프레임워크가 구현되어 있었고 2.4부터는 더 유연하고 다양한 기능을 가진 netfilter 로 프레임워크가 교체 되었습니다.
iptables 은 netfilter 프레임워크의 최상단에 위치하는 사용자 레벨의 프로그램으로 시스템 관리자는 iptables 명령어로 리눅스 서버로 들어오고 나가는 패킷을 필터링하거나 포트 포워딩을 설정할 수 있으며 방화벽으로도 사용할 수 있습니다.
iptables 는 숙련된 관리자가 아니면 사용이 어려운 단점이 있었는데 이런 문제를 해결하고자 RHEL/CentOS 7 부터는 방화벽을 firewalld 라는 데몬으로 교체하였고 이에 따라 사용자 레벨의 프로그램은 iptables 명령어 대신 명령행에서는 firewall-cmd , GUI 환경에서는 firewall-config 를 사용하게 되었습니다.

## permanent
기본적으로 firewall-cmd 로 방화벽 정책을 변경했을 경우 현재 구동되고 있는 firewalld 에 즉시 적용되지만 정책은 지속성이 없이 임시로 적용되며 정책을 재구동하는 명령어인 firewall-cmd --reload 를 실행하거나 시스템을 재부팅하면 예전 정책으로 다시 초기화 되며 이로 인해 서비스의 장애가 발생할 수 있습니다.
이때문에 방화벽 정책을 영구적으로 유지하기 위해서는 --permanent 옵션을 추가해서 실행하면 되지만 이는 즉시 적용되지 않고 firewall-cmd --reload 명령어로 방화벽 정책을 재구동하거나 재부팅을 하기 전에는 변경한 방화벽 설정이 적용되지 않습니다.
firewalld 를 처음에 사용할 때 이 때문에 혼란을 겪고 정책 설정을 잘못한 걸로 오해하는 사용자가 많으므로 아래 표를 보고 방화벽 정책의 즉시 적용 여부와 지속성 여부를 꼭 익혀 두어야 합니다.




                      즉시 적용(firewall-cmd --reload 불필요)	
재부팅시 정책의 지속 여부	예	                  아니요
방화벽 정책 적용 여부      아니오	              예


예로 fireall-cmd 로 정책을 추가했을 경우 즉시 반영되지만 만약 잘못된 설정이었을 경우에 firewall-cmd --reload 명령어를 실행하면 예전 정책으로 복구됩니다.

하지만 firewall-cmd --permanent  로 정책을 추가했을 경우 firewall-cmd --reload 명령어를 실행해야 변경한 정책이 적용되며 예전 정책으로 복구하려면 새로 추가한 정책을 삭제하고 다시 방화벽을 구동해야 합니다.



```
systemctl enable firewalld
systemctl start firewalld
systemctl stop firewalld
systemctl status firewalld
```

```
#check status
firewall-cmd --state

#reload
firewall-cmd --reload
```

```
#Print zone
firewall-cmd --get-zones
firewall-cmd --get-default-zone

#change the default zone to 'dmz'
firewall-cmd  --set-default-zone=dmz

#print currently activated zone
firewall-cmd --get-active-zones

firewall-cmd --list-service
firewall-cmd --add-service=http
```

To add new port
```
#check port
firewall-cmd --list-port 

#add new port
firewall-cmd --add-port=8787/tcp
firewall-cmd --permanent --add-port=8787/tcp

#reload
firewall-cmd --reload
```

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
