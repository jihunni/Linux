# Ubuntu Installation
## USB format (Window 10)
Ref: https://taktak2.tistory.com/entry/USB-%ED%8F%AC%EB%A7%B7%EB%B0%A9%EB%B2%95-%EC%99%84%EB%B2%BD%EC%A0%95%EB%A6%AC
- 
## Ubuntu booting usb


# Initial Setting for Ubuntu
## File system

## Basic setting (Ubuntu, Bash shell)
- Terminal setting
	~/.exrc
	```
	set autoindent
	set ai 
	set number
	set bs=2
	set ts=4
	set sts=4
	set shiftwidth=4
	set nocp
	set hlsearch
	set showmatch
	```
- host name
	REF: https://www.cyberciti.biz/faq/ubuntu-change-hostname-command/
	```
	sudo vi /etc/hostname
	sudo vi /etc/hosts
	reboot
	```
- ssh remote connection
	Ref: https://visu4l.tistory.com/entry/ssh-%EC%9B%90%EA%B2%A9-%EC%A0%91%EC%86%8D-%EC%97%90%EB%9F%ACWARNING-REMOTE-HOST-IDENTIFICATION-HAS-CHANGED
	```
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
	Someone could be eavesdropping on you right now (man-in-the-middle attack)!
	It is also possible that a host key has just been changed.
	The fingerprint for the ED25519 key sent by the remote host is
	SHA256:xxxxxxxxx/xxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxx.
	Please contact your system administrator.
	Add correct host key in /home/jihun/.ssh/known_hosts to get rid of this message.
	Offending ED25519 key in /home/jihun/.ssh/known_hosts:14
	  remove with:
	  ssh-keygen -f "/home/jihun/.ssh/known_hosts" -R "xxx.xx.xx.xx"
	Host key for xxx.xx.xx.xx has changed and you have requested strict checking.
	Host key verification failed.
	```
	```
	ssh-keygen -R xxx.xx.xx.xx
	```

- remove nouveau 커널 드라이버 (Ubuntu Server, for NVIDIA driver installation)
	Ref https://blog.boxcorea.com/wp/archives/3323
- [trial_error] apt update error
	Ref: https://phoenixnap.com/kb/temporary-failure-in-name-
	```
	$ sudo vi /etc/resolv.conf
	
	nameserver 8.8.8.8
	```
- 
## Install program
- c++
	```
	apt install gcc
  apt install cmake
  apt-get install g++

	```
- python
  ```
	$ sudo apt-get update
	$ sudo apt-get install pip3
  ```
- nvidia-driver
- screen : https://github.com/jihunni/Linux/blob/master/Software/screen.md
	- install
	- bash environment setting
- module environment : https://github.com/jihunni/Linux/blob/master/Software/module_environment.md
- lm_sensors: https://github.com/jihunni/Linux/blob/master/Software/lm_sensors.md
- network : 
	```
	apt-get install net-tools
	```
- WPS PDF
- git
- visual studio code
	- Lunach visual studio code from bash command line [link](https://code.visualstudio.com/docs/setup/mac#:~:text=Use%20double%2Dclick%20for%20some,by%20double%20clicking%20the%20icon.)
   		- Launch VS Code.
		- Open the Command Palette (Cmd+Shift+P) and type 'shell command' to find the Shell Command: Install 'code' command in PATH command. ([link](https://stackoverflow.com/questions/63013813/vs-code-how-to-open-a-file-by-its-full-path-in-the-command-palette)) : 
		  ```
			code [filename]
   		```
