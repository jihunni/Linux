# Open Babel 3 Install
Ref : https://openbabel.org/docs/dev/Installation/install.html
Requirement : wxWidgets toolkit
```
$ tar zxf openbabel-2.3.1.tar.gz   # (this creates openbabel-2.3.1)
$ mkdir build
$ cmake ../openbabel-2.3.1  -DBUILD_GUI=ON #GUI
$ make -j24    # parallel build across 24 processors
```
