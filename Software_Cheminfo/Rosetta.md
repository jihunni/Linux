# installation (Linux, Ubuntu)
Ref: https://new.rosettacommons.org/demos/latest/tutorials/install_build/install_build#pyrosetta-download-and-installation   

Set-up for installation
```
sudo apt-get install build-essential
```
Installation
```
$ sudo apt install zlib1g-dev scons build-essential
$ tar -xvzf rosetta_src_3.13_bundle.tgz
```

Compiling
```
$ ./scons.py -j <number_of_cores_to_use> mode=release bin extra=hdf5
e.g. $./scons.py -j 20 mode=release bin extra=hdf5
```

## PsiPred
```
$ sudo apt-get install csh tcsh
$ mkdir /opt/PsiPred; cd /opt/PsiPred
$ cp /home/jihun/Downloads/psipred.4.02.tar.gz  .
$ tar -xvzf psipred.4.02.tar.gz
$ mv psipred 4.02; cd 4.02
tcsh% cd src
tcsh% make
tcsh% make install
```
To set the proper directory, 
```
$ vi /opt/PsiPred/4.02/runpsipred_single

# Where the PSIPRED V4 programs have been installed
set execdir = /opt/PsiPred/4.02/bin

# Where the PSIPRED V4 data files have been installed
set datadir = /opt/PsiPred/4.02/data

```
To test,
```
$ /opt/PsiPred/4.02/runpsipred_single jihun_interface_design_production/00000/SEEEARRWEK_LUKER17O.fasta > /dev/null
```


# Trial and error in installation
- error while loading shared libraries: libcppdb.s
  ```
  ./score_jd2.linuxgccrelease: error while loading shared libraries: libcppdb.so: cannot open shared object file: No such file or directory
  ```
  Ref: https://www.rosettacommons.org/node/10175  
  Sol : Do not move the directory of Rosetta. Recompile.  
- `Comiler` Ubuntu 20.04 installation  (src_3.13 version)
  Ref: https://www.rosettacommons.org/node/11709  
  
  Problems: 
  ```
  Running versioning script ... Release package detected, using rosetta/main/.release.json to acquire version information...
  Done. (0.0 seconds)
  file ./options.dox being updated
  file ./full-options-list.md being updated
  Number of option files updated: 2
  Total 4580 options.
  Finished updating ResidueProperty code
  -- no changes needed
  Finished updating VariantType code
  -- no changes needed
  scons: done reading SConscript files.
  scons: Building targets ...
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/apps/public/AbinitioRelax.o -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/apps/public/AbinitioRelax.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/devel/init.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/devel/init.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/init/init.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/init/init.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/init/register1.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/init/register1.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/init/register2.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/init/register2.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/init/register3.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/init/register3.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/init/register4.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/init/register4.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody_legacy/AntibodyClass.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody_legacy/AntibodyClass.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody_legacy/AntibodyModeler.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody_legacy/AntibodyModeler.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody_legacy/CDRH3Modeler.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody_legacy/CDRH3Modeler.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody_legacy/LHRepulsiveRampLegacy.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody_legacy/LHRepulsiveRampLegacy.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody_legacy/LHSnugFitLegacy.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody_legacy/LHSnugFitLegacy.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody_legacy/GraftMover.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody_legacy/GraftMover.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody_legacy/Ubiquitin_E2C_Modeler.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody_legacy/Ubiquitin_E2C_Modeler.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody/Ab_TemplateInfo.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody/Ab_TemplateInfo.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody/AntibodyCDRGrafter.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody/AntibodyCDRGrafter.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody/AntibodyEnumManager.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody/AntibodyEnumManager.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody/AntibodyInfo.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody/AntibodyInfo.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody/AntibodyFeatures.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody/AntibodyFeatures.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody/AntibodyFeaturesCreator.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody/AntibodyFeaturesCreator.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody/AntibodyModelerProtocol.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody/AntibodyModelerProtocol.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  In file included from src/protocols/features/FeaturesReporterCreator.hh:21,
                   from src/protocols/antibody/AntibodyFeaturesCreator.hh:18,
                   from src/protocols/antibody/AntibodyFeaturesCreator.cc:15:
  src/protocols/features/FeaturesReporter.fwd.hh:27:14: error: 'uint64_t' in namespace 'std' does not name a type; did you mean 'wint_t'?
     27 | typedef std::uint64_t StructureID;
        |              ^~~~~~~~
        |              wint_t
  In file included from src/protocols/features/InterfaceFeatures.hh:18,
                   from src/protocols/antibody/AntibodyFeatures.hh:18,
                   from src/protocols/antibody/AntibodyFeaturesCreator.cc:21:
  src/protocols/features/FeaturesReporter.hh:99:17: error: 'StructureID' has not been declared
     99 |                 StructureID /*parent id*/,
        |                 ^~~~~~~~~~~
  src/protocols/features/FeaturesReporter.hh:109:17: error: 'StructureID' has not been declared
    109 |                 StructureID /*parent id*/,
        |                 ^~~~~~~~~~~
  src/protocols/features/FeaturesReporter.hh:124:17: error: 'StructureID' has not been declared
    124 |                 StructureID,
        |                 ^~~~~~~~~~~
  src/protocols/features/FeaturesReporter.hh:130:17: error: 'StructureID' has not been declared
    130 |                 StructureID,
        |                 ^~~~~~~~~~~
  In file included from src/protocols/features/InterfaceFeatures.hh:18,
                   from src/protocols/antibody/AntibodyFeatures.hh:18,
                   from src/protocols/antibody/AntibodyFeaturesCreator.cc:21:
  src/protocols/features/FeaturesReporter.hh:185:17: error: 'StructureID' has not been declared
    185 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody/AntibodyNumberingParser.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody/AntibodyNumberingParser.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  In file included from src/protocols/features/FeaturesReporter.hh:19,
                   from src/protocols/features/InterfaceFeatures.hh:18,
                   from src/protocols/antibody/AntibodyFeatures.hh:18,
                   from src/protocols/antibody/AntibodyFeatures.cc:14:
  src/protocols/features/FeaturesReporter.fwd.hh:27:14: error: 'uint64_t' in namespace 'std' does not name a type; did you mean 'wint_t'?
     27 | typedef std::uint64_t StructureID;
        |              ^~~~~~~~
        |              wint_t
  In file included from src/protocols/antibody/AntibodyFeatures.hh:18,
                   from src/protocols/antibody/AntibodyFeaturesCreator.cc:21:
  src/protocols/features/InterfaceFeatures.hh:71:17: error: 'StructureID' has not been declared
     71 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  src/protocols/features/InterfaceFeatures.hh:126:17: error: 'StructureID' has not been declared
    126 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  src/protocols/features/InterfaceFeatures.hh:135:17: error: 'StructureID' has not been declared
    135 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  src/protocols/features/InterfaceFeatures.hh:144:17: error: 'StructureID' has not been declared
    144 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  src/protocols/features/InterfaceFeatures.hh:156:17: error: 'StructureID' has not been declared
    156 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  src/protocols/features/InterfaceFeatures.hh:181:17: error: 'StructureID' has not been declared
    181 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  In file included from src/protocols/features/InterfaceFeatures.hh:18,
                   from src/protocols/antibody/AntibodyFeatures.hh:18,
                   from src/protocols/antibody/AntibodyFeatures.cc:14:
  src/protocols/features/FeaturesReporter.hh:99:17: error: 'StructureID' has not been declared
     99 |                 StructureID /*parent id*/,
        |                 ^~~~~~~~~~~
  src/protocols/features/FeaturesReporter.hh:109:17: error: 'StructureID' has not been declared
    109 |                 StructureID /*parent id*/,
        |                 ^~~~~~~~~~~
  src/protocols/features/FeaturesReporter.hh:124:17: error: 'StructureID' has not been declared
    124 |                 StructureID,
        |                 ^~~~~~~~~~~
  src/protocols/features/FeaturesReporter.hh:130:17: error: 'StructureID' has not been declared
    130 |                 StructureID,
        |                 ^~~~~~~~~~~
  In file included from src/protocols/features/InterfaceFeatures.hh:18,
                   from src/protocols/antibody/AntibodyFeatures.hh:18,
                   from src/protocols/antibody/AntibodyFeatures.cc:14:
  src/protocols/features/FeaturesReporter.hh:185:17: error: 'StructureID' has not been declared
    185 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  In file included from src/protocols/antibody/AntibodyFeatures.hh:18,
                   from src/protocols/antibody/AntibodyFeatures.cc:14:
  src/protocols/features/InterfaceFeatures.hh:71:17: error: 'StructureID' has not been declared
     71 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  src/protocols/features/InterfaceFeatures.hh:126:17: error: 'StructureID' has not been declared
    126 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  src/protocols/features/InterfaceFeatures.hh:135:17: error: 'StructureID' has not been declared
    135 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  src/protocols/features/InterfaceFeatures.hh:144:17: error: 'StructureID' has not been declared
    144 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  src/protocols/features/InterfaceFeatures.hh:156:17: error: 'StructureID' has not been declared
    156 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  src/protocols/features/InterfaceFeatures.hh:181:17: error: 'StructureID' has not been declared
    181 |                 StructureID struct_id,
        |                 ^~~~~~~~~~~
  In file included from src/protocols/antibody/AntibodyFeaturesCreator.cc:21:
  src/protocols/antibody/AntibodyFeatures.hh:84:27: error: 'protocols::features::StructureID' has not been declared
     84 |                 features::StructureID struct_id,
        |                           ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.hh:92:27: error: 'protocols::features::StructureID' has not been declared
     92 |                 features::StructureID struct_id,
        |                           ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.hh:98:27: error: 'protocols::features::StructureID' has not been declared
     98 |                 features::StructureID struct_id,
        |                           ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.hh:104:27: error: 'protocols::features::StructureID' has not been declared
    104 |                 features::StructureID struct_id,
        |                           ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.hh:111:27: error: 'protocols::features::StructureID' has not been declared
    111 |                 features::StructureID struct_id,
        |                           ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.hh:119:27: error: 'protocols::features::StructureID' has not been declared
    119 |                 features::StructureID struct_id,
        |                           ^~~~~~~~~~~
  g++ -o build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody/AntibodyNumberingConverterMover.os -c -std=c++0x -ffor-scope -isystem external/boost_submod/ -isystem external/ -isystem external/include/ -isystem external/dbio/ -isystem external/libxml2/include -isystem external/rdkit -pipe -Wall -Wextra -pedantic -Wno-long-long -Wno-strict-aliasing -march=core2 -mtune=generic -O3 -ffast-math -fno-finite-math-only -funroll-loops -finline-functions -finline-limit=20000 -s -Wno-unused-variable -Wno-unused-parameter -fPIC -DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_MATH_NO_LONG_DOUBLE_MATH_FUNCTIONS -DBOOST_DISABLE_THREADS -DPTR_STD -DNDEBUG -Isrc -Iexternal/include -Isrc/platform/linux/64/gcc/11 -Isrc/platform/linux/64/gcc -Isrc/platform/linux/64 -Isrc/platform/linux src/protocols/antibody/AntibodyNumberingConverterMover.cc
  g++: warning: switch '-ffor-scope' is no longer supported
  scons: *** [build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody/AntibodyFeaturesCreator.os] Error 1
  In file included from src/protocols/antibody/AntibodyFeatures.cc:14:
  src/protocols/antibody/AntibodyFeatures.hh:84:27: error: 'protocols::features::StructureID' has not been declared
     84 |                 features::StructureID struct_id,
        |                           ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.hh:92:27: error: 'protocols::features::StructureID' has not been declared
     92 |                 features::StructureID struct_id,
        |                           ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.hh:98:27: error: 'protocols::features::StructureID' has not been declared
     98 |                 features::StructureID struct_id,
        |                           ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.hh:104:27: error: 'protocols::features::StructureID' has not been declared
    104 |                 features::StructureID struct_id,
        |                           ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.hh:111:27: error: 'protocols::features::StructureID' has not been declared
    111 |                 features::StructureID struct_id,
        |                           ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.hh:119:27: error: 'protocols::features::StructureID' has not been declared
    119 |                 features::StructureID struct_id,
        |                           ^~~~~~~~~~~
  In file included from src/protocols/antibody/AntibodyFeatures.cc:30:
  src/protocols/features/util.hh:79:9: error: 'StructureID' was not declared in this scope
     79 |         StructureID struct_id,
        |         ^~~~~~~~~~~
  src/protocols/features/util.hh:80:42: error: expected primary-expression before 'db_session'
     80 |         utility::sql_database::sessionOP db_session
        |                                          ^~~~~~~~~~
  src/protocols/features/util.hh:81:1: error: expression list treated as compound expression in initializer [-fpermissive]
     81 | );
        | ^
  src/protocols/features/util.hh:83:18: error: 'StructureID' was not declared in this scope
     83 | utility::vector1<StructureID>
        |                  ^~~~~~~~~~~
  src/protocols/features/util.hh:83:29: error: template argument 1 is invalid
     83 | utility::vector1<StructureID>
        |                             ^
  src/protocols/features/util.hh:83:29: error: template argument 2 is invalid
  src/protocols/antibody/AntibodyFeatures.cc:118:9: error: 'StructureID' has not been declared
    118 |         StructureID struct_id,
        |         ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.cc:321:9: error: 'StructureID' has not been declared
    321 |         StructureID struct_id,
        |         ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.cc:443:9: error: 'StructureID' has not been declared
    443 |         StructureID struct_id,
        |         ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.cc:540:9: error: 'StructureID' has not been declared
    540 |         StructureID struct_id,
        |         ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.cc:557:9: error: 'StructureID' has not been declared
    557 |         StructureID struct_id,
        |         ^~~~~~~~~~~
  src/protocols/antibody/AntibodyFeatures.cc:623:9: error: 'StructureID' has not been declared
    623 |         StructureID struct_id,
        |         ^~~~~~~~~~~
  scons: *** [build/src/release/linux/5.19/64/x86/gcc/11/default/protocols/antibody/AntibodyFeatures.os] Error 1
  ```
  
  Solution
  `vi $ROSTTA/main/source/src/protocols/features/FeaturesReporter.fwd.hh` and add `#include <cstdint>`
  
- 

# Rosetta
## Architecture
- Code is organized so that libraries and namespaces (Cþþ namespaces provide a mechanism for grouping related class and function names) mirror the directory structure, thus making it easy to find code. Each library corresponds to a top-level namespace. Any subdirectory of a library directory corresponds to a nested namespace.
- The top-level directory src/ (source) contains:
  - utility/ : collect common data structures (a 1-indexed container, an owning pointer class, an optimized graph class) and numeric subroutines (vector and matrix classes, random number generators)
  numeric/, 
  - core/ : defines structures and supports structure I/O, scoring, packing, and minimization, 
  - protocols/ : consists of common structural modifications one might wish to make to a structure, and a means to control the distribution of jobs 
  - devel/
  - apps/ directory, in which executables with main() functions live; apps is not linked as a library.
## Data type
- PDB
- silent
  ```
  # silent to PDB
  /main/source/bin/extract_pdbs.default.linuxgccrelease -in:file:silent fold_silent.out -out:pdb –in:file:tags s_000001
  ```
- Pose : Rosetta's internal representation of a protein structure
  Contains: 
  - the atoms in the structure and the chemical connectivity 
  - how Rosetta interconverts internal/Cartesian coordinates (the FoldTree) 
  - the current energies 
  - any constraints applied to the structure
  - annotations from the original PDB.
- resfile  
  Ref: https://www.rosettacommons.org/docs/latest/rosetta_basics/file_types/resfiles  

# Rosetta Script
General
```
${ROSETTA}/rosetta_scripts parser:protocol [protocol.xml] -beta_nov16 -l pdb.list -mute protocols.rosetta_scripts.ParsedProtocol.REPORT -parser:script_vars string_var=something -out:prefix [str prefix_name] 
```

Example
```
/opt/rosetta/rosetta_src_2021.16.61629_bundle/main/source//bin/rosetta_scripts.linuxgccrelease -parser:protocol /home/jihun/minibinder/run_example/cao_2021_protocol/paper_motif_graft.xml -beta_nov16 -l pdb.list -mute protocols.rosetta_scripts.ParsedProtocol.REPORT -parser:script_vars CAO_2021_PROTOCOL=/home/jihun/minibinder/run_example/cao_2021_protocol @/home/jihun/minibinder/TAP1/grafting.flag -parser:script_vars motifpdb=/home/jihun/minibinder/TAP1/motifing/motifs/mot_1jj7_0001_docking_renum_revert_2_13_14_L.pdb.gz hotspots=1:2 -out:prefix mot_1jj7_0001_docking_renum_revert_2_13_14_L_ 
```
- computational alanine scanning   
Ref: https://www.rosettacommons.org/node/10610

## General
Ref (general run) : https://www.rosettacommons.org/docs/latest/rosetta_basics/running-rosetta-with-options  
Ref (input option): https://new.rosettacommons.org/docs/latest/rosetta_basics/options/input-options  
```
# To delcare a global variable
export Variable='contents'
```
## Protein preparation
- Idealize: The structure was idealized, which sets bond lengths and angles to their ideal values and then minimizes the structure in the presence of coordinate constraints. 
  ```
  ${path_to_Rosetta}/main/source/bin/idealize_jd2.linuxgccrelease
  -database ${path_to_Rosetta}/main/database
  -in::file::fullatom
  -s 1LVM.pdb
  -no_optH false
  -flip_HNQ
  ```
- Relax : The idealized structure of TEVp was relaxed (100 iterations) using the default constrained relax script, and position constraints were added to backbone heavy atoms based on the crystal structure. During this relax procedure, Rosetta resfiles were used to incorporate single (or double) mutations.   
  Ref (tutorial): https://new.rosettacommons.org/demos/latest/tutorials/Relax_Tutorial/Relax  
  Ref (option description): https://new.rosettacommons.org/docs/latest/full-options-list#1-relax  
  
  Commands:
  
  relax.sh
  ```
  export mutant='mutation_Y412C'
  ${path_to_Rosetta}/main/source/bin/relax.linuxgccrelease @relax.flag
  ```
  relax.flag      
  ```
  -database ${path_to_Rosetta}/main/database
  #-relax::sequence_file always_constrained_relax.script
  -constrain_relax_to_start_coords # to disfavor output that is structually dissimilar to the input
  -relax::coord_cst_width 0.25 -relax::coord_cst_stdev 0.25 # Width on coordinate constraints from constrain_relax_* options 
  -relax:coord_cst_stdev 0.25  # Stdev on coordinate constraints from constrain_relax_* options
  -s 1LVM.pdb
  -in::file::fullatom
  -no_optH false # Do not optimize hydrogen placement at the time of a PDB load
  -flip_HNQ # Consider flipping HIS, ASN, and GLN during hydrogen placement optimization (must turn off -no_optimizeH)
  -nstruct 100 # 100 iterations of packer and minimizer
  -packing:resfile ${mutant}.resfile
  -relax:respect_resfile 
  ```
  
  always_constrained_relax.script:
  ```
  repeat 5
  ramp_repack_min 0.02 0.01 1.0
  ramp_repack_min 0.250 0.01 1.0
  ramp_repack_min 0.550 0.01 1.0
  ramp_repack_min 1 0.00001 1.0
  accept_to_best
  endrepeat
  ```
  
  example ${mutant}.resfile:
  Ref: https://www.rosettacommons.org/docs/latest/rosetta_basics/file_types/resfiles
  ```
  # These commands will be applied to all residue positions that lack a specified behavior in the body:
  AUTO # add the behavior 'AUTO'
  NATAA # allow only the native amino acid; repack without design; NATive Amino Acid
  start #
  #... the body would continue here.
  412 A PIKAA C # allow only the specified amino acids; In this case, allow only cystein at residue 412 on chain A
  ```
## Interface scoring: 
The interfacial energy was computed for all relaxed structures of each variant using the rosetta_scripts application with the InterfaceAnalyzerMover. This mover calculates the total interaction energy between all residues in chain A (nTEV) with residues in chain B (cTEV). 

Commands:
```
${path_to_Rosetta}/main/source/bin/rosetta_scripts.linuxgccrelease
-database ${path_to_Rosetta}/main/database 
-parser:protocol interface_score.script
-file:s ${mutant}.pdb
```
interface_score.script
```
<ROSETTASCRIPTS>
<TASKOPERATIONS>
</TASKOPERATIONS>
<SCOREFXNS>
</SCOREFXNS>
<FILTERS>
</FILTERS>
<MOVERS>
<InterfaceAnalyzerMover name="score_int" pack_separated="false" pack_input="false"
packstat="false" interface_sc="true" ligandchain="B"/>
</MOVERS>
<PROTOCOLS>
<Add mover_name="score_int"/>
</PROTOCOLS>
</ROSETTASCRIPTS>
```
# External extension
- runpsipred requirement in Ubuntu 22.04
  ```
  $ sudo apt-get install csh tcsh
  ```
## Trial and Error in XML script
- XML script with relative path
  ```
  ERROR: Unable to open RosettaScripts XML file: "~/minibinder/scripts_and_main_pdbs/supplemental_files/cao_2021_protocol/paper_coord_relax.xml".
  ERROR:: Exit from: src/protocols/rosetta_scripts/RosettaScriptsParser.cc line: 597
  Error: [ ERROR ] ERROR: Exception caught by JobDistributor while trying to get pose from job '3mjg_PDGFR_0001'
  Error: [ ERROR ] Treating failure as bad input; canceling similar jobs

  [ ERROR ]: Caught exception:


  File: src/protocols/rosetta_scripts/RosettaScriptsParser.cc:597
  [ ERROR ] UtilityExitException
  ERROR: Unable to open RosettaScripts XML file: "~/minibinder/scripts_and_main_pdbs/supplemental_files/cao_2021_protocol/paper_coord_relax.xml".
  ```
- Wrong data type on tag attributes.
  ```
  [FILE]: src/protocols/rosetta_scripts/RosettaScriptsParser.cc
  [LINE]: 1207
  [START_MESSAGE]
  Input rosetta scripts XML file "/home/jihun/minibinder/run_example/cao_2021_protocol/jihun_interface_design.xml" failed to validate agai
  nst the rosetta scripts schema. Use the option -parser::output_schema <output filename> to output the schema to a file to see all valid 
  options.
  Your XML has failed validation.  The error message below will tell you where in your XML file the error occurred.  Here's how to fix it:

  1) If the validation fails on something obvious, like an illegal attribute due to a spelling error (perhaps you used scorefnction instea
  d of scorefunction), then you need to fix your XML file.
  2) If you haven't run the XML rewriter script and this might be pre-2017 Rosetta XML, run the rewriter script (tools/xsd_xrw/rewrite_ros
  etta_script.py) on your input XML first.  The attribute values not being in quotes (scorefunction=talaris2014 instead of scorefunction="
  talaris2014") is a good indicator that this is your problem.
  3) If you are a developer and neither 1 nor 2 worked - email the developer's mailing list or try Slack.
  4) If you are an academic or commercial user - try the Rosetta Forums https://www.rosettacommons.org/forum


  Error messages were:
  Error: attributes construct error
  ```
- ERROR: Failed to run the psipred command, which was "/opt/PsiPred/4.02/runpsipred_single DVEELLEEAV_J8UHX0CO.fasta > /dev/null". Something went wrong. Make sure you specified the full path to the psipred command in your XML file. Return code=32512  
  Solution : to specify the full dirctory of output on Filter `SSPrediction`
- Error : Value of inactive option accessed: -indexed_structure_store:fragment_store
  `-indexed_structure_store:fragment_store` is required to be specified, but it is not provided.
- PsiPredInterface installation error
  - Error message  : no csh, no tsch in the environment  
    ```
    [FILE]: src/core/io/external/PsiPredInterface.cc
    [LINE]: 342
    [START_MESSAGE]
    [ ERROR ] UtilityExitException
    ERROR: Failed to run the psipred command, which was "cd /home/jihun/minibinder/TAP1/jihun_interface_design_production/00000/ && /opt/PsiPred/4.02/runpsipred_single DVEELLEEAV_I0FTHRCD.fasta > /dev/null". Something went wrong. Make sure you specified the full path to the psipred command in your XML file. Return code=32512
    ```
    ```
    $ /opt/PsiPred/4.02/runpsipred_single DVEELLEEAV_J8UHX0CO.fasta
    -bash: /opt/PsiPred/4.02/runpsipred_single: /bin/tcsh: bad interpreter: No such file or directory
    ```

    solution: to install csh and tcsh  
    ```
    $ sudo apt-get install csh tcsh
    ```
  - Error message  : 
    ```
    # /opt/PsiPred/4.02/runpsipred_single [fasta_file].fasta
    Generating mtx file from sequence DVEELLEEAV_N9RPRDOW.fasta ...
    ./bin/seq2mtx: Command not found.
    FATAL: Error whilst running makemat - script terminated!
    ```
    
    Solution : to change the path on the file `$PsiPred/runpsipred_single`  
    
    before the change of `$PsiPred/runpsipred_single`
    ```
    # Where the PSIPRED V4 programs have been installed
    set execdir = ./bin

    # Where the PSIPRED V4 data files have been installed
    set datadir = ./data
    ```
    after the change `runpsipred_single`
    ```
    # Where the PSIPRED V4 programs have been installed
    set execdir = /opt/PsiPred/4.02/bin

    # Where the PSIPRED V4 data files have been installed
    set datadir = /opt/PsiPred/4.02/data
    ```
- 
# Ab Initio protein folding
Ref: https://labnotes.readthedocs.io/en/latest/doc/fragment_picking.html   
Robetta old server: http://old.robetta.org/   
```
$ grep SCORE score.fsc | awk {'print $2 "\t" $27'} | sort -nk 1 > score_rms.dat
$ vi score_rms.dat
  > remove header

For visualization in Ubuntu,
$sudo apt install gunplot
$sudo apt install plotutils
$ gnuplot
gnuplot> plot 'score_rms.dat'
```
## Error
- St12out_of_range  
  Solution : check whether the input files are corrects (3-mer and 9-mer)
- 

# RIFdock installation (Ubuntu 20.04)
Ref: https://github.com/rifdock/rifdock/blob/master/help/ubuntu_rifdock_compilation_extra.pdf
```
sudo vi /etc/apt/sources.list.d/xenial.list
sudo apt-get update
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4EB27DB2A3B88B8B
```

```
CXXFLAGS="-isystem /home/jihun/rosetta/rosetta_2022.42/rosetta.source.release-332/boost_1_65_0"
CMAKE_ROSETTA_PATH=/home/jihun/rosetta/rosetta_src_2018.09.60072_bundle/main
CMAKE_FINAL_ROSETTA_PATH=/home/jihun/rosetta/rosetta_src_2018.09.60072_bundle/main/source/cmake/build_cxx11_omp 
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/home/jihun/rosetta/rosetta_2022.42/boost_1_65_0/stage/lib
```

# RFdiffusion
Ref: 
```
pip install omegaconf
pip install hydra-core --upgrade
pip install pyrsistent
```
