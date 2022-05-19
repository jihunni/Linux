# Open Babel 3 Install
Documentation : https://openbabel.org/docs/dev/Installation/install.html    
Source : https://github.com/openbabel/openbabel/releases  
Requirement : cmake, wxWidgets toolkit [link](https://github.com/jihunni/Linux/blob/master/Software_Cheminfo/wxWidgets.md)
```
$ tar zxf openbabel-2.3.1.tar.gz   # (this creates openbabel-2.3.1)
$ mkdir build
$ cmake ../openbabel-2.3.1  -DBUILD_GUI=ON #GUI
$ make -j24    # parallel build across 24 processors
```
