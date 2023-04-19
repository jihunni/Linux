# virtual machine and docker
## install (with GPU support)
Ref: https://docs.docker.com/desktop/install/ubuntu/  
Ref: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html  
```
 $ sudo apt-get update
 $ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

install docker automatically
```
curl -fsSL https://get.docker.com/ | sudo sh
```
## install (CentOS)
https://docs.docker.com/engine/install/centos/

## 
To run Docker as a non-privileged user, consider setting up the Docker daemon in rootless mode for your user:
```
dockerd-rootless-setuptool.sh install
```
Visit https://docs.docker.com/go/rootless/ to learn about rootless mode.  
  
To run the Docker daemon as a fully privileged service, but granting non-root users access, refer to https://docs.docker.com/go/daemon-access/

WARNING: Access to the remote API on a privileged Docker daemon is equivalent to root access on the host. Refer to the 'Docker daemon attack surface' documentation for details: https://docs.docker.com/go/attack-surface/

## docker execution and service
```
# 부팅시에 실행하도록 systemctl에 등록
systemctl enable docker.service

# docker 실행
systemctl start docker.service

# systemctl의 docker status 확인
systemctl status docker.service
```

# basic
```
$ docker version
Client: Docker Engine - Community
 Version:           20.10.8
 API version:       1.41
 Go version:        go1.16.6
 Git commit:        3967b7d
 Built:             Fri Jul 30 19:54:27 2021
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/version": dial unix /var/run/docker.sock: connect: permission denied
```
> Server 정보가 안나오고 Error response from daemon: Bad response from Docker engine이라는 메시지가 출력되는 경우는 보통 docker daemon이 정상적으로 실행되지 않았거나 sudo를 입력하지 않은 경우입니다.


```
$ sudo docker version
Client: Docker Engine - Community
 Version:           20.10.8
 API version:       1.41
 Go version:        go1.16.6
 Git commit:        3967b7d
 Built:             Fri Jul 30 19:54:27 2021
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.8
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.16.6
  Git commit:       75249d8
  Built:            Fri Jul 30 19:52:33 2021
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.9
  GitCommit:        e25210fe30a0a703442421b0f60afac609f950a3
 runc:
  Version:          1.0.1
  GitCommit:        v1.0.1-0-g4144b63
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

![image](https://user-images.githubusercontent.com/48517782/131222342-367f7db8-6064-48f7-9c8d-3388bf289562.png)
혹시, 특이한 부분을 찾으셨나요? 버전정보가 클라이언트와 서버로 나뉘어져 있습니다. 도커는 하나의 실행파일이지만 실제로 클라이언트와 서버역할을 각각 할 수 있습니다. 도커 커맨드를 입력하면 도커 클라이언트가 도커 서버로 명령을 전송하고 결과를 받아 터미널에 출력해 줍니다.

```
docker -v
```

## sudo authorization
```	
$ sudo usermod -aG docker $USER # 현재 접속중인 사용자에게 권한주기
$ sudo usermod -aG docker your-user # your-user 사용자에게 권한주기
```
## Basic usage
```
# download images
$ docker pull {image_name}:{tag}
$ docker images
$ docker ps -a # to check the executing containers
$ docker rmi [images_name]

# execute container
$ docker run (-i) (-t) (-d) --name [container_name] -p host_port:conatiner_port (-v host_filesystem:container_filesystem) [image_names] 
	-d : background execution
$ docker stasrt/stop [container_name]```
$ docker rm (--force) [container_nanme] # to remove a container
$ docker rmi [images_name]
$ docker logs
$ docker exec [containter_name] [command] # execute
$ docker exec -i -t [container_name] /bin/bash 
	-i: interactive
	-p : putty
```

## general setting in a container
```
# docker exec -i -t ubuntu_18.04 /bin/bash 
$ apt-get update # to configure (update) the channel information
$ apt-get install python 	#install python 2.7
$ apt-get install python-pip	#install PyPI of python 2.7 
$ apt-get install python3 
$ apt install vim

$ sudo apt-get install openjdk-8-jdk
$ sudo apt-get install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc unzip bc wget
```
 
## the setting for installing Rosetta 3.7 (Ubuntu 18.04, Python 2.7, GCC 6, SCONS 3.1.2)
	```
	To set the Ubuntu environment in a container
	# docker pull ubuntu:18.04
	# docker run -i -t -d --name ubuntu_18.04 -v /home/jihun/rosetta/:/opt/rosetta/ ubuntu:18.04
	
	To set the installation environment in a container
	# docker exec -i -t ubuntu_18.04 /bin/bash 
	# apt-get update # to configure (update) the channel information
	# apt-get install python 	#install python 2.7
 	# apt-get install python-pip	#install PyPI of python 2.7 
	# pip install scons==3.1.2
	# apt-get install sudo
	# sudo apt-get install boost # install boost
	# sudo apt-get install libboost-all-dev # to install libboost
	# sudo apt-get -y install libsqlite3-0 libsqlite3-dev
	
	To install gcc version 6
	# sudo apt update && \
	sudo apt install build-essential software-properties-common -y && \
	sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
	sudo apt update && \
	sudo apt install gcc-6 g++-6 -y && \
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6 && \
	gcc -v
	
	To install Rosetta 3.9
	apt-get install ninja-build
	
	# ./scons.py -j 25 mode=release bin extra=static
	```
	- scons: https://scons.org/scons-312-is-available.html

### Rifdock
```
sudo apt-get install libxmu-dev libxmu-headers freeglut3-dev libxext-dev libxi-dev
sudo apt-get install libpthread-stubs0-dev
```
# Reference
- https://docs.docker.com/engine/install/
- https://www.yalco.kr/36_docker/
- https://subicura.com/2017/01/19/docker-guide-for-beginners-2.html
