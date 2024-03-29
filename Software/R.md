# install R (CentOs 7)
  install source file : https://cran.r-project.org/
  Ref : https://docs.rstudio.com/resources/install-r-source/
  ```
  # ./configure \
    --prefix=/opt/R/${R_VERSION} \
    --enable-memory-profiling \
    --enable-R-shlib \
    --with-blas \
    --with-lapack

  # make
  # sudo make install
  ```
  
  Error during configuration :  
  error : --with-readline=yes (default) and headers/libs are not available

    ```
    yum list libX11*
    yum install libX11*
    yum install xorg*
    yum install readline*
    ```
    
  To verify the installation,
  ```
  /opt/R/${R_VERSION}/bin/R --version
  ```
  
  To add symbolic link,
  ```
  # ln -s /opt/R/${R_VERSION}/bin/R /usr/local/bin/R
  # ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/local/bin/Rscript
  ```
  
  To add environmental variable, (RSTUDIO : for commerical version rstudio)
  Ref : https://shlee1990.tistory.com/1065
  ```
  export R=/opt/R/4.1.2
  export R_HOME=/opt/R/4.1.2
  export RSTUDIO_WHICH_R=/opt/R/4.1.2/bin/R
  ```

  R version change for Rstudio (Open Source Edition)
  ```
  # vi /etc/rstudio/rserver.conf
    rsession-which-r=/opt/R/4.1.2/bin/R
  
  Close all session in Rstudio sever
  
  # systemctl restart rstudio-server.service
  ```
# Trial and error in R
```
Package harfbuzz was not found in the pkg-config search path.
Perhaps you should add the directory containing `harfbuzz.pc'
to the PKG_CONFIG_PATH environment variable
No package 'harfbuzz' found
Package fribidi was not found in the pkg-config search path.
Perhaps you should add the directory containing `fribidi.pc'
to the PKG_CONFIG_PATH environment variable
No package 'fribidi' found
Using PKG_CFLAGS=
Using PKG_LIBS=-lfreetype -lharfbuzz -lfribidi -lpng
--------------------------- [ANTICONF] --------------------------------
Configuration failed to find the harfbuzz freetype2 fribidi library. Try installing:
 * deb: libharfbuzz-dev libfribidi-dev (Debian, Ubuntu, etc)
 * rpm: harfbuzz-devel fribidi-devel (Fedora, EPEL)
 * csw: libharfbuzz_dev libfribidi_dev (Solaris)
 * brew: harfbuzz fribidi (OSX)
If harfbuzz freetype2 fribidi is already installed, check that 'pkg-config' is in your
PATH and PKG_CONFIG_PATH contains a harfbuzz freetype2 fribidi.pc file. If pkg-config
is unavailable you can set INCLUDE_DIR and LIB_DIR manually via:
R CMD INSTALL --configure-vars='INCLUDE_DIR=... LIB_DIR=...'
-------------------------- [ERROR MESSAGE] ---------------------------
<stdin>:1:10: fatal error: hb-ft.h: No such file or directory
compilation terminated.
--------------------------------------------------------------------
```
# Rstudio
## systemctl
```
# systemctl status -l rstudio-server
● rstudio-server.service - RStudio Server
   Loaded: loaded (/usr/lib/systemd/system/rstudio-server.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2021-09-14 14:55:57 KST; 25min ago
  Process: 63009 ExecStop=/usr/bin/killall -TERM rserver (code=exited, status=0/SUCCESS)
  Process: 63011 ExecStart=/usr/lib/rstudio-server/bin/rserver (code=exited, status=0/SUCCESS)
 Main PID: 63012 (rserver)
    Tasks: 28
   Memory: 10.7G
   CGroup: /system.slice/rstudio-server.service
           ├─61538 /usr/lib/rstudio-server/bin/rsession -u gyuho --session-use-secure-cookies 0 --session-root-path / --session-same-site 0 --launcher-token 9ADD87F3 --r-restore-workspace 2 --r-run-rprofile 2
           ├─63012 /usr/lib/rstudio-server/bin/rserver
           ├─64027 /usr/lib/rstudio-server/bin/rsession -u assistant_manager --session-use-secure-cookies 0 --session-root-path / --session-same-site 0 --launcher-token 884BBFC6 --r-restore-workspace 2 --r-run-rprofile 2
           ├─64700 /usr/lib/rstudio-server/bin/rsession -u swl409 --session-use-secure-cookies 0 --session-root-path / --session-same-site 0 --launcher-token 884BBFC6
           └─64801 bash -l

```

## login error
```
# remove the R login session info with error
rm -rf /home/gyuho/.local/*

# copy new login session info
cp -r /home/assistant_manager/.local/*  /home/gyuho/.local/

# change ownership from root to user
chown gyuho .local
```

# reference
https://onesixx.com/resuming-r-session/

# R Executable and Libraries
## locating R (5.1.1)
/etc/rstudio/rserver.conf

## locating shared library (5.1.2)
add elements to the default LD_LIBRARY_PATH for R sessions (as determined by the R ldpaths script) by adding an rsession-ld-library-path entry to the server config file. Note that this change will not take effect until the server is restarted.   

```
$ which R

/etc/rstudio/rserver.conf
rsession-which-r=/usr/local/bin/R
```


```
rsession-ld-library-path=/opt/someapp/lib:/opt/anotherapp/lib
```

```
installed.packages()


> .libPaths()
[1] "/usr/lib64/R/library" "/usr/share/R/library"
> .libPaths("/opt/R_shared_library/3.6.0")
> .libPaths()
[1] "/opt/R_shared_library/3.6.0" "/usr/lib64/R/library"       
[3] "/usr/share/R/library"
install.packages()


```

Installing and Managing Bioconductor Packages | [manual](https://cran.r-project.org/web/packages/BiocManager/vignettes/BiocManager.html)


## To set libarary path in Module Environment

Module script (/opt/Modules/modulefiles/R)
```
set version     3.6.0
set prefix      /usr/bin/R


setenv          MODULESHOME $prefix
prepend-path    PATH        /usr/bin
prepend-path    R_LIBS_SITE     /opt/R_shared_library/3.6.0
```
> `R_LIBS_SITE` is a directory for shared library.

R script
```
> Sys.getenv()
R_ARCH                  
R_BROWSER               /usr/bin/xdg-open
R_BZIPCMD               /usr/bin/bzip2
R_DOC_DIR               /usr/share/doc/R-3.6.0
R_GZIPCMD               /usr/bin/gzip
R_HOME                  /usr/lib64/R
R_INCLUDE_DIR           /usr/include/R
R_LIBS_SITE             /opt/R_shared_library/3.6.0
R_LIBS_USER             ~/R/x86_64-redhat-linux-gnu-library/3.6
R_PAPERSIZE             a4
R_PDFVIEWER             /usr/bin/xdg-open
R_PLATFORM              x86_64-redhat-linux-gnu
R_PRINTCMD              lpr
R_RD4PDF                times,hyper
R_SESSION_TMPDIR        /tmp/RtmpqwkRL5
R_SHARE_DIR             /usr/share/R
R_STRIP_SHARED_LIB      strip --strip-unneeded
R_STRIP_STATIC_LIB      strip --strip-debug
R_SYSTEM_ABI            linux,gcc,gxx,gfortran,gfortran
R_TEXI2DVICMD           /usr/bin/texi2dvi
R_UNZIPCMD              /usr/bin/unzip
R_ZIPCMD                /usr/bin/zip

```
