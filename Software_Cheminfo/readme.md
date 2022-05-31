# Software for chemoinformatics
- AutoDock
  Ref : https://vina.scripps.edu/manual/#linux
- AutoDock Vina
  Ref : https://vina.scripps.edu/manual  
  - Python library vina
    ```
    $ conda create -n vina python=3
    $ conda activate vina
    $ conda config --env --add channels conda-forge
    $ conda install -c conda-forge numpy swig boost-cpp sphinx sphinx_rtd_theme
    $ pip install vina
    ```
  - vina
    Dependency : ADFRSuite, Meeko  
    Ref : 
    - source & Git code
      ```
      ```
      ```
      set version     1.1.2

      prepend-path    PATH    /opt/autodock_vina/1.1.2/bin
      prepend-path    PATH    /opt/autodock_vina/AutoDock-Vina-develop/example/autodock_scripts

      ```
    - To install OpenBabel
      ref: https://open-babel.readthedocs.io/en/latest/Installation/install.html#install-binaries
      ```
      cmake ../ -DCMAKE_INSTALL_PREFIX=/opt/open_babel/3.1.1
      make -j10
      make install
      ```
    - 3rd party software
      ```
       # to install Meeko
       pip install -U numpy openbabel meeko
       conda install -c openbabel openbabel
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
