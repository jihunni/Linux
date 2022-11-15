# installation (Linux, Ubuntu)
Ref: https://new.rosettacommons.org/demos/latest/tutorials/install_build/install_build#pyrosetta-download-and-installation   
Installation
```
$ sudo apt install zlib1g-dev scons build-essential
$ tar -xvzf rosetta_src_3.13_bundle.tgz
```

Compiling
```
$ ./scons.py -j <number_of_cores_to_use> mode=release bin
e.g. $./scons.py -j 20 mode=release bin
```


# Trial and error
- error while loading shared libraries: libcppdb.s
  ```
  ./score_jd2.linuxgccrelease: error while loading shared libraries: libcppdb.so: cannot open shared object file: No such file or directory
  ```
  Ref: https://www.rosettacommons.org/node/10175  
  Sol : recompile  
