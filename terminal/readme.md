# basic command
- top  
	Ref : https://zzsza.github.io/development/2018/07/18/linux-top/

# greeting
- /etc/issue : 로그인 전, 콘솔(로컬) 접속시도시 보여줄 메시지파일
- /etc/issue.net : 원격지에서 접속시도시 보여줄 메시지파일
- /etc/motd : 로컬접속, 원격접속 모두에 해당하며 로그인 성공 후 보여줄 메시지파일

# md5sum
```
$ md5sum [filename]
```

running code
```
# md5sum *.gz
```


reference: 
- https://bio-info.tistory.com/47

# checksum
```
sum [filename]
```
ref:
- https://stackoverflow.com/questions/14569281/checksum-and-md5-not-the-same-thing

# GPU - NVIDIA
GPU memory release : check PID and kill the PID
```
$ lshw -C video
$ lspci | grep VGA

$ nvidia-smi
# nvidia-smi --query | fgrep 'Product Name'
    Product Name                          : NVIDIA GeForce RTX 3090
```

# shutdown
Ref: https://nan1004au.tistory.com/entry/%EB%A6%AC%EB%88%85%EC%8A%A4-%EC%98%88%EC%A0%95%EB%90%9C-%EC%8B%9C%EA%B0%84%EC%97%90-%EC%A2%85%EB%A3%8C%EC%8B%9C%ED%82%A4%EA%B8%B0
```
shutdown -h now
shutdown -h +210 # after 210 minuite, system shut downs
```
