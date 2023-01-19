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
