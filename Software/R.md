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
  
  To add environmental variable,
  Ref : https://shlee1990.tistory.com/1065
  ```
  export R=/opt/R/4.1.2
  export R_HOME=/opt/R/4.1.2
  export RSTUDIO_WHICH)R=/opt/R/4.1.2/bin/R
  ```
