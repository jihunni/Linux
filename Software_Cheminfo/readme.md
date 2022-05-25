# Software for chemoinformatics
- AutoDock
  Ref : https://vina.scripps.edu/manual/#linux
- AutoDock Vina
  Ref : https://vina.scripps.edu/manual  
  Dependency : ADFRSuite, Meeko  
  ```
   # to install Meeko
   pip install -U numpy openbabel meeko
  ```
- MGLTools
  Ref : https://ccsb.scripps.edu/mgltools/downloads/
- Open Babel
  Ref : https://open-babel.readthedocs.io/en/latest/Installation/install.html#install-binaries  
  Source : https://github.com/openbabel/openbabel/releases  
- smina (centos7)
  Ref : https://sourceforge.net/projects/smina/
  cmake  
  yum install eigen3-devel  
  yum install gcc gcc-c++ kernel-devel mak  
  
  ```
  apt install git libboost-all-dev libopenbabel-dev build-essential libeigen3-dev
  git clone https://git.code.sf.net/p/smina/code smina-code
  cd smina-code
  mkdir build
  cd build
  cmake ..
  make -j12
  ```
- 
