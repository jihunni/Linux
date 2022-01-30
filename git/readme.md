# Environment
- Sourcetree
- iTerm2
  - d2codingfont. 
    https://github.com/naver/d2codingfont. 
    
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
Ref : https://www.youtube.com/watch?v=1I3hMwQU6GU&ab_channel=%EC%96%84%ED%8C%8D%ED%95%9C%EC%BD%94%EB%94%A9%EC%82%AC%EC%A0%84
## Git 설정
```
git config --global user.email "~~@~~.com"
git config --global user.name "깃허브이름"
git config --global init.defaultBranch main

git init

git remote add origin [github_repo_address]
git remote -v
git remote remove origin

```
## git ignore
Ref : https://git-scm.com/docs/gitignore
```
$ git status
$ vi .gitignore
  ~~~
  file_name_for_ignore
  ~~~
```

Git ignore format
````
# 이렇게 #를 사용해서 주석

# 모든 file.c
file.c

# 최상위 폴더의 file.c
/file.c

# 모든 .c 확장자 파일
*.c

# .c 확장자지만 무시하지 않을 파일
!not_ignore_this.c

# logs란 이름의 파일 또는 폴더와 그 내용들
logs

# logs란 이름의 폴더와 그 내용들
logs/

# logs 폴더 바로 안의 debug.log와 .c 파일들
logs/debug.log
logs/*.c

# logs 폴더 바로 안, 또는 그 안의 다른 폴더(들) 안의 debug.log
logs/**/debug.log
````

## git modification
```
$ git diff
```
작업	Vi 명령어	상세
위로 스크롤	k	git log등에서 내역이 길 때 사용
아래로 스크롤	j	git log등에서 내역이 길 때 사용
끄기	:q	:가 입력되어 있으므로 q만 눌러도 됨



## Git basics
```
git fetch
git pull origin master

git add . #전체파일 스테이징
git add (파일명) #파일명 스테이징

git commit -m "msg" #메시지와 커밋
git commit -am "msg" #스테이징과 커밋을 메시지와 동시에!
git commit --amend #메시지 수정

#원격저장소로 올리기
git push origin master
git push origin main
```

remove large files which is impossible to upload on git
Method 1
ref: https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-large-files-on-github
```
To remove the file, enter git rm --cached: (Stage our giant file for removal, but leave it on disk)
$ git rm --cached giant_file

Commit this change using --amend -CHEAD:
$ git commit --amend -CHEAD
# Amend the previous commit with your change
# Simply making a new commit won't work, as you need
# to remove the file from the unpushed history as well
```

Method 2
Ref : https://rtyley.github.io/bfg-repo-cleaner/
```
ava -jar /home/jihun/bfg-1.14.0.jar --strip-blobs-bigger-than 100M ~/'metabolism_evolution_project(2021.09)'/.git
```
# Reset and Revert

# Reference
- https://snwo.tistory.com/169
- [Git] fatal: Authentication failed | https://eehoeskrap.tistory.com/319 : 
- https://git-scm.com/book/ko/v2/Git%EC%9D%98-%EA%B8%B0%EC%B4%88-Git-%EC%A0%80%EC%9E%A5%EC%86%8C-%EB%A7%8C%EB%93%A4%EA%B8%B0
