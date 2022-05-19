# wxWidgets
## install
Source : https://www.wxwidgets.org/downloads/  
Documentation : https://www.binarytides.com/install-wxwidgets-ubuntu/  
```
$ sudo apt-get install libgtk-3-dev build-essential checkinstall
$ mkdir gtk-build
$ cd gtk-build/
$ ../configure --disable-shared --enable-unicode
$ make
$ sudo checkinstall
  # Checkinstall would ask few questions during the process and make sure to provide a version number when asked, otherwise it would fail.
```
