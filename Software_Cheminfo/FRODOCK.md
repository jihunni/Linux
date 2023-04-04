# FRODOCK
Ref: https://chaconlab.org/modeling/frodock/frodock-intro  
# Trial and Error
Error
```
/opt/frodock/3.1.2/bin//frodock: error while loading shared libraries: libmkl_intel_lp64.so: cannot open shared object file: No such file or directory
```
Solution
```
$ sudo apt-get install libmkl-intel-lp64
```
