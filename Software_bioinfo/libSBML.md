# libSBML installation for R
Ref: https://www.sbml.org/software/libsbml/libsbml-docs/installation/
- Download a stable libSBML install package for R  
  Link: https://sourceforge.net/projects/sbml/  
  e.g. libSBML_5.19.0.tar.gz  
- Install in R
  ```
  $ R CMD INSTALL [libSBML_install_file.tar.gz]
  ```
# rsbml installation for R
``` R
$ Sys.setenv(LIBSBML_CFLAGS = "/opt/libSBML/5.19.0/usr/include", LIBSBML_LIBS="/opt/libSBML/5.19.0/usr/include")
$ BiocManager::install("rsbml")
```
