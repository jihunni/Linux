# IP
## IP address check
Ref: https://it-serial.tistory.com/7
```
ifconfig
netstat -anp
vi /etc/sysconfig/network-scripts/ifcfg-eth1 
ping [ip_address]
```

## static IP address setting on Ubuntu
Ref: https://www.manualfactory.net/13079
- `/etc/resolv.conf` (instantaneous IP address setting)
- `yaml` file on `/etc/netplan` (permanent IP address setting)
  ```
  # This is the network config written by 'subiquity'
  network:
    ethernets:
      enp0s3:
        addresses: [192.168.0.136/24]
        gateway4: 192.168.0.1
        nameservers:
          addresses: [8.8.8.8,8.8.4.4]
    version: 2
  ```
  ```
  $ netplan apply
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
firewall-cmd --permanent --zone=public --remove-port=80/tcp
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

# firewall (Ubuntu)
Ref : https://webdir.tistory.com/206
```
# firewall service
sudo ufw enable # to activate fiewall
sudo ufw disable # to inactivate firewall
sudo ufw status verbose #check UFW status

# Port
sudo ufw allow 22
sudo ufw allow 22/tcp

sudo ufw deny 22 # to deny the only specific port
sudo ufw deny 22/tcp
sudo ufw delete deny 22/tcp

# logg
sudo ufw logging on
sudo ufw logging off
```

# trial
- TCL connection
  - check the firewall on sever
  - check the firewall on client

# SSH protocol (ubuntu)
Ref : https://codechacha.com/ko/ubuntu-install-openssh/  

In sever
```
Installation
$ sudo apt update
$ sudo apt install openssh-server

To activate the serivce
$ sudo systemctl status ssh
$ sudo systemctl enable ssh
$ sudo systemctl start ssh

Firewall
$ sudo ufw status
$ sudo ufw allow ssh
```

In client  
```
$ sudo apt-get install openssh-client
$ ip a
$ ssh username@ip_address
```

## SSH key
Ref (Microsoft Visual Studio) : https://code.visualstudio.com/docs/remote/troubleshooting   
Ref (Youtube video, outdated) : https://www.youtube.com/watch?v=vpk_1gldOAE    
- Create your local SSH key pair, if there is no SSH key pair on local machine (usually, ` ~/.ssh/id_ed25519`).
  ```
  ssh-keygen -t ed25519 -b 4096
  ```
- Restrict the permissions on the private key file
  ```
  chmod 400 ~/.ssh/id_ed25519
  ```
- Authorize local machine to connect : Copy the public key of local machine to the authorized key list on host machine (`~/.ssh/authorized_keys`)
  Use `ssh-copy-id` command
  ```
  export USER_AT_HOST="your-user-name-on-host@hostname"
  export PUBKEYPATH="$HOME/.ssh/id_ed25519.pub"
  ssh-copy-id -i "$PUBKEYPATH" "$USER_AT_HOST"
  ```
  Or, copy and pase.
  ```
  $USER_AT_HOST="your-user-name-on-host@hostname"
  $PUBKEYPATH="$HOME\.ssh\id_ed25519.pub"
  $pubKey=(Get-Content "$PUBKEYPATH" | Out-String); ssh "$USER_AT_HOST" "mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo '${pubKey}' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
  ```


# Trouble shooting
## Running a Network Path Trace
  Ref : https://player.support.brightcove.com/troubleshooting/running-network-path-trace.html
## The collision between private network (172.27.xxx.xxx) and Docker network (172.17.xxx.xxx)
  Ref: https://waspro.tistory.com/635  
  - Cause : Installation of Docker and the collision of network configuration
    - Our lab use 172.27.xxx.xxx for private network (eth0 or eth1)
    - Docker network uses 172.17.xxx.xxx (docker0)
    - The collision between eth0 and docker0 triggers out bound traffic and prevent the proper connection to Life3 server outside of the lab.
  - Solution : changing the network configuration of Docker from 172.17.xxx.xxx to 10.10.10.0
