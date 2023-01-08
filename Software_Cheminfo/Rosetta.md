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
  Sol : Do not move the directory of Rosetta. Recompile.  

# Rosetta
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
  ```
  ${path_to_Rosetta}/main/source/bin/relax.linuxgccrelease
  -database ${path_to_Rosetta}/main/database
  -relax::sequence_file always_constrained_relax.script
  -constrain_relax_to_start_coords
  -relax::coord_cst_width 0.25 -relax::coord_cst_stdev 0.25
  -s 1LVM.pdb
  -in::file::fullatom
  -no_optH false
  -flip_HNQ
  -nstruct 100
  -packing:resfile ${mutant}.resfile
  -relax:respect_resfile 
  ```
