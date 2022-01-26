# SSH key
	ref : https://opentutorials.org/module/432/3742
	
	```
  $ ssh-keygen -t rsa
  $ ls -al $HOME/ssh-client/.ssh/
	```
	> -t : (default : rsa)  
	
	To send a file with public key to sever
	
	```
	$ scp $HOME/.ssh/id_rsa.pub egoing@egoing.net:id_rsa.pub
	```
	> scp source_fileName destination:fileName. 
	
	
	```
	$ mkdir .ssh
	$ chmod 700 .shh
	$ cat $HOME/id_rsa.pub >> $HOME/.ssh/authorized_keys
	```
	> `>>` redirection (append)
	> `>` redirection (replace, overwriting)
