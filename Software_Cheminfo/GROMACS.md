# Install (Ubuntu)
Ref : https://manual.gromacs.org/current/download.html  
Install guide : https://manual.gromacs.org/current/install-guide/index.html  
video : https://www.youtube.com/watch?v=kCKYkNygc9I  
- apt-get install
  ```
  apt install gcc
  apt install cmake
  apt-get install build-essential
  apt-get install libfftw3-dev
  apt-get install gromacs
  ```
- installation w/ GPU
	```
	mkdir build
	cd build
	cmake .. -DGMX_GPU=CUDA -DGMX_OPENMP=ON -DGMX_BUILD_OWN_FFTW=ON -CUDA_TOOLKIT_ROOT_DIT=/usr/local/cuda -DCMAKE_INSTALL_PREFIX=/opt/gromacs/2022.2/
	```
# Install in MacOS
Ref: https://bioinformaticsreview.com/20220206/how-to-install-gromacs-on-apple-m1-macos/
	```
	% cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=OFF -DCMAKE_C_COMPILER=gcc -DREGRESSIONTEST_PATH=/Users/jihun/Downloads/software/regressiontests-2022.2
	% sudo make check
	```

# basics
```
gmx help (module)
gmx (module) -h
```
# Lysozyme Tutorial
Ref: http://www.mdtutorials.com/gmx/lysozyme/index.html
![image](https://user-images.githubusercontent.com/48517782/172881380-7c7b5c8e-adb2-446b-a686-7adc91012dcb.png)

## Generate Topology
To strip out the crystal waters (Note that such a procedure is not universally appropriate)
```
grep -v HOH 1aki.pdb > 1AKI_clean.pdb
```
Always check your .pdb file for entries listed under the comment MISSING, as these entries indicate either atoms or whole residues that are not present in the crystal structure. Terminal regions may be absent, and may not present a problem for dynamics. Incomplete internal sequences or any amino acid residues that have missing atoms will cause pdb2gmx to fail. These missing atoms/residues must be modeled in using other software packages. Also note that pdb2gmx is not magic. It cannot generate topologies for arbitrary molecules, just the residues defined by the force field (in the *.rtp files - generally proteins, nucleic acids, and a very finite amount of cofactors, like NAD(H) and ATP).


The purpose of pdb2gmx is to generate three files:
- The topology for the molecule (topol.top by default) : all the information necessary to define the molecule within a simulation. This information includes nonbonded parameters (atom types and charges) as well as bonded parameters (bonds, angles, and dihedrals).
- A position restraint file.
- A post-processed structure file.


an input pdb file should contain all atoms
```
gmx pdb2gmx -f 1AKI_clean.pdb -o 1AKI_processed.gro -water spce
```
> -f : input file
> -ignh :  Ignore H atoms in the PDB file; especially useful for NMR structures. Otherwise, if H atoms are present, they must be in the named exactly how the force fields in GROMACS expect them to be. Different conventions exist, so dealing with H atoms can occasionally be a headache! If you need to preserve the initial H coordinates, but renaming is required, then the Linux sed command is your friend.
> -ter: Interactively assign charge states for N- and C-termini.
> -inter: Interactively assign charge states for Glu, Asp, Lys, Arg, and His; choose which Cys are involved in disulfide bonds.

To select the Force Field (The force field will contain the information that will be written to the topology. This is a very important choice! You should always read thoroughly about each force field and decide which is most applicable to your situation.)
```
Select the Force Field:
From '/usr/local/gromacs/share/gromacs/top':
 1: AMBER03 protein, nucleic AMBER94 (Duan et al., J. Comp. Chem. 24, 1999-2012, 2003)
 2: AMBER94 force field (Cornell et al., JACS 117, 5179-5197, 1995)
 3: AMBER96 protein, nucleic AMBER94 (Kollman et al., Acc. Chem. Res. 29, 461-469, 1996)
 4: AMBER99 protein, nucleic AMBER94 (Wang et al., J. Comp. Chem. 21, 1049-1074, 2000)
 5: AMBER99SB protein, nucleic AMBER94 (Hornak et al., Proteins 65, 712-725, 2006)
 6: AMBER99SB-ILDN protein, nucleic AMBER94 (Lindorff-Larsen et al., Proteins 78, 1950-58, 2010)
 7: AMBERGS force field (Garcia & Sanbonmatsu, PNAS 99, 2782-2787, 2002)
 8: CHARMM27 all-atom force field (CHARM22 plus CMAP for proteins)
 9: GROMOS96 43a1 force field
10: GROMOS96 43a2 force field (improved alkane dihedrals)
11: GROMOS96 45a3 force field (Schuler JCC 2001 22 1205)
12: GROMOS96 53a5 force field (JCC 2004 vol 25 pag 1656)
13: GROMOS96 53a6 force field (JCC 2004 vol 25 pag 1656)
14: GROMOS96 54a7 force field (Eur. Biophys. J. (2011), 40,, 843-856, DOI: 10.1007/s00249-011-0700-9)
15: OPLS-AA/L all-atom force field (2001 aminoacid dihedrals)
```
Output :
- 1AKI_processed.gro is a GROMACS-formatted structure file that contains all the atoms defined within the force field (i.e., H atoms have been added to the amino acids in the protein).
- The topol.top file is the system topology
  
  The interpretation of this information is as follows:
  nr: Atom number
  type: Atom type
  resnr: Amino acid residue number
  residue: The amino acid residue name
  Note that this residue was "LYS" in the PDB file; the use of .rtp entry "LYSH" indicates that the residue is protonated (the predominant state at neutral pH).
  atom: Atom name
  cgnr: Charge group number
  Charge groups define units of integer charge; they aid in speeding up calculations
  charge: Self-explanatory
  The "qtot" descriptor is a running total of the charge on the molecule
  mass: Also self-explanatory
  typeB, chargeB, massB: Used for free energy perturbation (not discussed here)

- The posre.itp file contains information used to restrain the positions of heavy atoms (more on this later).



To generate a box for simulation (`box.gro`)
```
gmx editconf -f file.gro -o box.gro -c -d 1.0 -bt cubic 
```
> -d : distance from cubic box

```
gmx solvate -cp box.gro -cs configuration_of_solvent_from_library.gro -o water_box.gro -p file.top
```
Assemble tpr file
```
gmx grompp -f inos.mdp -c water_box.gro -p file.top -o ions.tpr
```

To add ion
`ions.mdp` file
```
; ions.mdp - used as input into grompp to generate ions.tpr
; Parameters describing what to do, when to stop and what to save
integrator  = steep         ; Algorithm (steep = steepest descent minimization)
emtol       = 1000.0        ; Stop minimization when the maximum force < 1000.0 kJ/mol/nm
emstep      = 0.01          ; Minimization step size
nsteps      = 50000         ; Maximum number of (minimization) steps to perform

; Parameters describing how to find the neighbors of each atom and how to calculate the interactions
nstlist         = 1         ; Frequency to update the neighbor list and long range forces
cutoff-scheme	= Verlet    ; Buffered neighbor searching 
ns_type         = grid      ; Method to determine neighbor list (simple, grid)
coulombtype     = cutoff    ; Treatment of long range electrostatic interactions
rcoulomb        = 1.0       ; Short-range electrostatic cut-off
rvdw            = 1.0       ; Short-range Van der Waals cut-off
pbc             = xyz       ; Periodic Boundary Conditions in all 3 dimensions
```

```
gmx genioin -s ions.tpr -o water_ions.gro -p file.top -pname NA -nname CL -neutral 
```


Energy minimization (EM) : EM ensured that we have a reasonable starting structure, in terms of geometry and solvent orientation.
`nunu.mdp` file
```
; minim.mdp - used as input into grompp to generate em.tpr
; Parameters describing what to do, when to stop and what to save
integrator  = steep         ; Algorithm (steep = steepest descent minimization)
emtol       = 1000.0        ; Stop minimization when the maximum force < 1000.0 kJ/mol/nm
emstep      = 0.01          ; Minimization step size
nsteps      = 50000         ; Maximum number of (minimization) steps to perform

; Parameters describing how to find the neighbors of each atom and how to calculate the interactions
nstlist         = 1         ; Frequency to update the neighbor list and long range forces
cutoff-scheme   = Verlet    ; Buffered neighbor searching
ns_type         = grid      ; Method to determine neighbor list (simple, grid)
coulombtype     = PME       ; Treatment of long range electrostatic interactions
rcoulomb        = 1.0       ; Short-range electrostatic cut-off
rvdw            = 1.0       ; Short-range Van der Waals cut-off
pbc             = xyz       ; Periodic Boundary Conditions in all 3 dimensions
```
```
$ gmx grompp -f minim.mdp -c water_ions.gro -p topol.top -o em.tpr
$ gmx mdrun -v -deffnm em
$ gmx energy -f em.edr -o potential.xvg
```

Output:   
- em.log: ASCII-text log file of the EM process
- em.edr: Binary energy file
- em.trr: Binary full-precision trajectory
- em.gro: Energy-minimized structure

# Practice
```
# To remove water molecules in PDB file
$ grep -v HOH 1aki.pdb > 1AKI_clean.pdb

# To prepare gro file
$ gmx pdb2gmx -f AF-Q96I59-F1-model_v4.pdb -o AF-Q96I59-F1-model_v4.gro -water tip4p

To create box
$ gmx editconf -f AF-Q96I59-F1-model_v4.gro -o AF-Q96I59-F1-model_v4_newbox.gro -c -d 1.0 -bt cubic

To add solvate
$ gmx solvate -cp AF-Q96I59-F1-model_v4_newbox.gro -cs tip4p.gro -o AF-Q96I59-F1-model_v4_solv.gro -p topol.top

To assemble tpr file
$ gmx grompp -f ions.mdp -c AF-Q96I59-F1-model_v4_solv.gro -p topol.top -o ions.tpr

To generate ion
$ gmx genion -s ions.tpr -o AF-Q96I59-F1-model_v4_ions.gro -p topol.top -pname NA -nname CL -neutral

For gromacs preprocessor (Energy Minimization)
$ gmx grompp -f minim.mdp -c AF-Q96I59-F1-model_v4_ions.gro -p topol.top -o em.tpr
$ gmx mdrun -v -deffnm em


step 25: One or more water molecules can not be settled.
Check for bad contacts and/or reduce the timestep if appropriate.

# Equilibration of solvent and ions around the protein
$ gmx grompp -f nvt.mdp -c em_50000.gro -r em_50000.gro -p topol.top -o nvt.tpr
$ gmx mdrun -deffnm nvt
```
```
Dynamic load balancing report:
 DLB got disabled because it was unsuitable to use.
 Average load imbalance: 3.5%.
 The balanceable part of the MD step is 82%, load imbalance is computed from this.
 Part of the total run time spent waiting due to load imbalance: 2.9%.
 Average PME mesh/force load: 0.692
 Part of the total run time spent waiting due to PP/PME imbalance: 3.9 %


               Core t (s)   Wall t (s)        (%)
       Time:   129218.860     4614.959     2800.0
                         1h16:54
                 (ns/day)    (hour/ns)
Performance:        1.872       12.819
```
```
$ gmx energy -f nvt.edr -o temperature.xvg
$ gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
$ gmx mdrun -deffnm npt
$ gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr
```
