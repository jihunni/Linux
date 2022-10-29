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


