# virtual machine and docker


## install
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
```
# download container
docker pull {image_name}:{tag}

# execute container
docker run -i -t 
```

```
docker images
```

# Reference
- https://docs.docker.com/engine/install/
- https://www.yalco.kr/36_docker/
- https://subicura.com/2017/01/19/docker-guide-for-beginners-2.html
