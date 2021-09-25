# systemctl
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

# login error
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
