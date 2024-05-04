# Guide
- link['https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent']  
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
|   . ooo++ *.    |git clone [REPO_URL] [DIR]
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
For `~/.ssh/config` 
```
Host *
  IgnoreUnknown AddKeysToAgent,UseKeychain
  AddKeysToAgent yes
  UseKeychain yes
```
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
git clone (-b [branch_name])[REPO_URL] [DIR]

git fetch
git pull origin master
git checkout [branch_name]

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
## Reset and Revert
```
git log
git reset --hard [commit_hash]
git revert (--no-commit) [commit_hash]
```

## branch
```
git branch # to check a list of branch
git branch [new_branch_name]
git switch (-c) [branch_name] 
  # -c : to create a branch and move
git branch -d [banch_name] # -d : to delete a branch
git branch -d [banch_name] # -D : to delete a branch by force
git branch -m [old_name] [new_name] # to change a branch name
git log --all --decorate --oneline --graph

```

### merge and rebase
- merge : 두 브랜치를 한 커밋에 이어붙입니다.
  - 브랜치 사용내역을 남길 필요가 있을 때 적합한 방식입니다.
  - 다른 형태의 merge에 대해서도 이후 다루게 될 것입니다.  
  
  To merge `branch_A` into `main`
  ```
  git switch main
  git merge [branch_name]
  git reset --hard [commit_hash] # `merge` is revertible with `reset` 
  git branch -d [branch_name] # remove an unnecessary branch after merging
  ```
  
  If collision occurs,
  ```
  1) 
  $ git merge --abrort
  

  2)
  solve the collision part with >>>>
  $ git add .
  $ git commit -m `commit_message`
  ```
- rebase : 브랜치를 다른 브랜치에 이어붙입니다.
  - 한 줄로 깔끔히 정리된 내역을 유지하기 원할 때 적합합니다.
  - 이미 팀원과 공유된 커밋들에 대해서는 사용하지 않는 것이 좋습니다.
  
  To rebase `branch_B` into `main`
  ```
  git switch branch_B
  git rebase main
  git switch main # move to main
  git merge branch_B # fast-forward
  ```

  If cossion occurs,
  ```
  1)
  git rebase --abort
  
  2)
  solve the collision part with >>>>>
  $ git rebase --continue
  ```
# Reference
- https://snwo.tistory.com/169
- [Git] fatal: Authentication failed | https://eehoeskrap.tistory.com/319 : 
- https://git-scm.com/book/ko/v2/Git%EC%9D%98-%EA%B8%B0%EC%B4%88-Git-%EC%A0%80%EC%9E%A5%EC%86%8C-%EB%A7%8C%EB%93%A4%EA%B8%B0
