# basic configuration (Ubuntu)
Ref : https://phoenixnap.com/kb/ubuntu-20-04-change-hostname
To set hostname 
```
# hostnamectl
# hostnamectl set-hostname gpu1
```

## disk
check available disk
```
lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL
```
# Package
- Unattended upgrade : an automatic upgrade system in Ubuntu

# Software update
Ref : https://jjudrgn.tistory.com/6
- shell 
  Ref : https://bywords.tistory.com/143
  Note that `/bin/sh` does not supoort 
- vim
  Ref : https://gabii.tistory.com/entry/Ubuntu-vim-%EC%84%A4%EC%B9%98-%EB%B0%8F-%EC%84%A4%EC%A0%95
  To install new version vim
  ```
  apt-get install vim
  ```
  vim setting
  ```
  vi ~/.vimrc
  ```
  ```
  set number    " line 표시
  set ai    " auto indent
  set si " smart indent
  set cindent    " c style indent
  set shiftwidth=4    " 자동 공백 채움 시 4칸
  set tabstop=4    " tab을 4칸 공백으로
  set ignorecase    " 검색 시 대소문자 무시
  set hlsearch    " 검색 시 하이라이트
  set nocompatible    " 방향키로 이동 가능
  set fileencodings=utf-8,euc-kr    " 파일 저장 인코딩 : utf-8, euc-kr
  set fencs=ucs-bom,utf-8,euc-kr    " 한글 파일은 euc-kr, 유니코드는 유니코드
  set bs=indent,eol,start    " backspace 사용가능
  set ruler    " 상태 표시줄에 커서 위치 표시
  set title    " 제목 표시
  set showmatch    " 다른 코딩 프로그램처럼 매칭되는 괄호 보여줌
  set wmnu    " tab 을 눌렀을 때 자동완성 가능한 목록
  syntax on    " 문법 하이라이트 on
  filetype indent on    " 파일 종류에 따른 구문 강조
  set mouse=a    " 커서 이동을 마우스로 가능하도록
  ```

- gcc, make
  ```
  apt-get install gcc make
  ```
- environment module
  Ref : https://modules.readthedocs.io/en/stable/INSTALL.html
  
  1. Install `Tcl`
  ```
  apt-get install tcl-dev
  ```
  2. ...
  3. configuration
  4. symbolic link : to activate `module` command
- screen
  https://github.com/jihunni/Linux/blob/305b8e89b5df33ab9d820693285959466713256b/Software/screen.md
- symbolic link
  ```
  심볼릭 링크 조회
  ls -l /usr/bin/py*

  심볼릭 링크 삭제
  rm -f /usr/bin/python2.6

  심볼릭 링크 생성
  ln -s /usr/bin/python2.7 /usr/bin/python
  ```
- anaconda3
  https://github.com/jihunni/Linux/blob/master/Software/anaconda.md
- 
