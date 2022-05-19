# smina
## install (Ubuntu)
Ref : https://sourceforge.net/projects/smina/
- cmake
  apt-get update cmake
- wxWidgets
  Ref : https://www.binarytides.com/install-wxwidgets-ubuntu/  
  wxWidgets supports Open Babel GUI  
- Open Babel 3
  Ref : https://openbabel.org/docs/dev/Installation/install.html
- smina   
  Ref : https://sourceforge.net/p/smina/code/ci/master/tree/  
  ```
  apt install git libboost-all-dev libopenbabel-dev build-essential libeigen3-dev
  git clone https://git.code.sf.net/p/smina/code smina-code
  cd smina-code
  mkdir build
  cd build
  cmake ..
  make -j12
  ```
