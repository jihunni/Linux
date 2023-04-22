# install shell (Ubuntu)
```
# 설치 csh , tcsh 
sudo apt install csh
sudo apt install tcsh

#확인
which csh
which tcsh
```

# greeting
- /etc/issue : 로그인 전, 콘솔(로컬) 접속시도시 보여줄 메시지파일
- /etc/issue.net : 원격지에서 접속시도시 보여줄 메시지파일
- /etc/motd : 로컬접속, 원격접속 모두에 해당하며 로그인 성공 후 보여줄 메시지파일


# System management
- top  
	Ref : https://zzsza.github.io/development/2018/07/18/linux-top/
- check GPU
	```
	watch -d -n 0.5 nvidia-smi
	```
- shutdown
	Ref: https://nan1004au.tistory.com/entry/%EB%A6%AC%EB%88%85%EC%8A%A4-%EC%98%88%EC%A0%95%EB%90%9C-%EC%8B%9C%EA%B0%84%EC%97%90-%EC%A2%85%EB%A3%8C%EC%8B%9C%ED%82%A4%EA%B8%B0
	```
	$ shutdown -h now
	$ shutdown -h +210 # after 210 minuite, system shut downs
	```
- GPU - NVIDIA
	GPU memory release : check PID and kill the PID
	```
	$ lshw -C video
	$ lspci | grep VGA

	$ nvidia-smi
	# nvidia-smi --query | fgrep 'Product Name'
			Product Name                          : NVIDIA GeForce RTX 3090
	```

# File management
- print file tree
	Ref: https://www.cyberciti.biz/faq/linux-show-directory-structure-command-line/
	```
	Install in Ubuntu
	$ sudo apt-get install tree
	
	Print a file tree
	$ tree
	$ tree /path/to/directory
	$ tree [options] tree [options] /path/to/directory
	```

## File transfer
Ref: https://devconnected.com/4-ways-to-transfer-files-and-directories-on-linux/
### rsync
Ref: https://stackoverflow.com/questions/15687755/how-to-use-rsync-to-copy-only-specific-subdirectories-same-names-in-several-dir

```
rsync -av rsync://data.sbgrid.org/10.15785/SBGRID/843 . -v --exclude='843/exp1_classification/*'
```

```
rsync -r -v --dry-run                       \
	--include='/'                           \
	--include='/company*/'                  \
	--include='/company*/unique_folder1/'   \
	--include='/company*/unique_folder1/**' \
	--exclude='*'
```
	
### scp
### FTP -> Local  
	
	```
	$ wget -r --user="USER_ID" --password="PASSWORD"  ftp://ftp.example.com/subdirectory/*
	$ scp -r -v host@xxx.xx.xx.xx:/home/jihun/data host@xxx.xx.xx.xx:/home/jihun/server_backup/
	```
### File integrity check
- md5sum
	reference: https://bio-info.tistory.com/47  
	```
	$ md5sum [filename]

	Example
	$ md5sum *.gz
	```

- checksum
	ref: https://stackoverflow.com/questions/14569281/checksum-and-md5-not-the-same-thing  
	```
	$ sum [filename]
	```


# Parallel 
Ref: 
- https://manpages.ubuntu.com/manpages/xenial/en/man1/scontrol.1.html
- https://www.cyberciti.biz/faq/how-to-run-command-or-code-in-parallel-in-bash-shell-under-linux-or-unix/
To install,
```
[ubuntu]$ sudo apt install parallel
[RHEL/CentOS]$ sudo yum install parallel
[Fedora]$ sudo dnf install parallel
```

To prepare the script to parallely run
```
$ vi parallel_commands.list

command_1
command_2
command_3
...
```
To run the scirpt parallely, 
```
$ parallel -j [threads] --bar {} < parallel_commands.list
e.g. $ parallel -j 27 --bar {} < 14_jihun_interface_design_production_commands.list
```

To run the specific line on a given bash script file of multiple lines,
```
bash <(sed -n '5p' script.sh) # to run 5th line on script.sh 
```

## tty1 shell screen
`Ctrl` + `Alt` + `F1`

# etc
-gedit [fileName]
