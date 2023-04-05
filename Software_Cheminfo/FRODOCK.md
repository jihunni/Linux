# FRODOCK
Ref: https://chaconlab.org/modeling/frodock/frodock-intro  
## Pre-requisite
- Get Intel® oneAPI Math Kernel Library (oneMKL)
  Ref: https://www.intel.com/content/www/us/en/developer/tools/oneapi/onemkl-download.html?operatingsystem=linux&distributions=online
  ```
  $ wget https://registrationcenter-download.intel.com/akdlm/IRC_NAS/cd17b7fe-500e-4305-a89b-bd5b42bfd9f8/l_onemkl_p_2023.1.0.46342.sh
  $ sudo sh ./l_onemkl_p_2023.1.0.46342.sh
  $ source /opt/intel/oneapi/setvars.sh
  ```

# Trial and Error
- case
  Error
  ```
  /opt/frodock/3.1.2/bin//frodock: error while loading shared libraries: libmkl_intel_lp64.so: cannot open shared object file: No such file or directory
  ```
  Solution
  ```
  $ sudo apt-get install libmkl-intel-lp64
  ```
- case
  Error
  ```
  /opt/frodock/3.1.2/bin//frodock: error while loading shared libraries: libmkl_intel_thread.so: cannot open shared object file: No such file or directory
  ```
  Solution
  ```
  $ sudo apt-get install  libmkl-intel-thread
  ```
