# install
Ref : https://www.ks.uiuc.edu/Development/Download/download.cgi


To change the configuration setting (to change the directory to install VMD)
```
$ vi configure
# Name of shell script used to start program; this is the name used by users
$install_name = "vmd";

# Directory where VMD startup script is installed, should be in users' paths.
$install_bin_dir="/opt/vmd/1.9.3/";

# Directory where VMD files and executables are installed
$install_library_dir="/opt/vmd/lib/$install_name";
```

```
$ ./configure
using configure.options: LINUXAMD64 OPENGL OPENGLPBUFFER FLTK TK ACTC CUDA IMD LIBSBALL XINERAMA XINPUT LIBOPTIX LIBOSPRAY LIBTACHYON VRPN NETCDF COLVARS TCL PYTHON PTHREADS NUMPY SILENT ICC
```



To install
```
$ cd src
$ sudo make install
```

To execute
```
$ /opt/vmd/1.9.3/vmd
```
