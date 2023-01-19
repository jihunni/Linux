# Ubuntu Installation
## USB format (Window 10)
Ref: https://taktak2.tistory.com/entry/USB-%ED%8F%AC%EB%A7%B7%EB%B0%A9%EB%B2%95-%EC%99%84%EB%B2%BD%EC%A0%95%EB%A6%AC
- 
## Ubuntu booting usb

# Initial Setting for Ubuntu
# Basic setting (Ubuntu, Bash shell)
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
# Install program
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
