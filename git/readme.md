# Private Repository
```
#Generate SSH key
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/jihun/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/jihun/.ssh/id_rsa
Your public key has been saved in /home/jihun/.ssh/id_rsa.pub
The key fingerprint is:
XXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX jihun@workstation-for-jihun-jeung
The key's randomart image is:
+---[RSA 3072]----+
|   . ++o. o*E .  |
|    o B= o..++.  |
|     +.=* +o=o.  |
|   . ooo++ *.    |
|    = *+S        |
|   . B.B .       |
|  . o *          |
|   . .           |
|                 |
+----[SHA256]-----+


# public key
$ cat /home/jihun/.ssh/id_rsa.pub

# private key
$ cat /home/jihun/.ssh/id_rsa

Insert public key into Github account setting
![image](https://user-images.githubusercontent.com/48517782/131660953-1ca4d37a-9d86-4fc4-a90b-c392581e6e6a.png)

```
# creating a personal access token
https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token

# Git 
Git 설정
```
git config --global user.email "~~@~~.com"
git config --global user.name "깃허브이름"

git init

git remote add origin [github_repo_address]
git remote -v
git remote remove origin

```


```
git fetch
git pull

git add . #전체파일 스테이징
git add (파일명) #파일명 스테이징

git commit -m "msg" #메시지와 커밋
git commit -am "msg" #스테이징과 커밋을 메시지와 동시에!
git commit --amend #메시지 수정

#원격저장소로 올리기
git push origin master
git push origin main
```

# Reference
- https://snwo.tistory.com/169
- [Git] fatal: Authentication failed | https://eehoeskrap.tistory.com/319 : 
- https://git-scm.com/book/ko/v2/Git%EC%9D%98-%EA%B8%B0%EC%B4%88-Git-%EC%A0%80%EC%9E%A5%EC%86%8C-%EB%A7%8C%EB%93%A4%EA%B8%B0
