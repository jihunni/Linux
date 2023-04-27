# GROMACS
Offical manual : https://manual.gromacs.org/current/index.html  
Official tutorail : https://tutorials.gromacs.org/docs/md-intro-tutorial.html
# Biological problems
- protein behavior
- binding site
- free energy calculation
- statistics and quantification
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
	- Ubuntu LLVM Package
		Official documentation:https://llvm.org/docs/GettingStarted.html#checkout   
		Automatic installation: https://ralpioxxcs.github.io/post/etc/llvm_install/   
- installation w/ GPU
	```
	apt install gcc
	apt install cmake
	apt-get install build-essential
	apt-get install libfftw3-dev
  
	tar xfz gromacs-2023.tar.gz
	cd gromacs-2023
	mkdir build
	cd build
	cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON # without GPU
	cmake .. -DGMX_GPU=CUDA -DGMX_OPENMP=ON -DGMX_BUILD_OWN_FFTW=ON -CUDA_TOOLKIT_ROOT_DIT=/usr/local/cuda -DCMAKE_INSTALL_PREFIX=/opt/gromacs/2022.2/ -> not work
	OR
	cmake .. -DGMX_GPU=CUDA -DGMX_OPENMP=ON -DGMX_BUILD_OWN_FFTW=ON -DCMAKE_INSTALL_PREFIX=/opt/gromacs/2022.2/
	make
	make check
	sudo make install
	source /usr/local/gromacs/bin/GMXRC
	```
## Install in Centos7
Ref: https://sites.google.com/site/rangsiman1993/comp-chem/program-install/install-gromacs-4
- installing fftw-3.3.6
	```
	wget ftp://ftp.fftw.org/pub/fftw/fftw-3.3.6-pl2.tar.gz
	tar xzf fftw-3.3.6-pl2.tar.gz
	chown root:root -R fftw-3.3.6-pl2
	cd fftw-3.3.6-pl2
	## creating single- and double-precision versions ###
	./configure --enable-threads --enable-float --prefix=/usr/local/fftw-3.3.6-pl2
	make
	make install
	make distclean
	./configure --enable-threads --prefix=/usr/local/fftw-3.3.6-pl2
	make
	make install
	```
- install `Gromacs`
	```
	wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-4.5.3.tar.gz
	tar xzf gromacs-4.5.3.tar.gz
	chown root:root -R gromacs-4.5.3
	cd gromacs-4.5.3
	## Compiling Gromacs
	./configure --prefix=/usr/local/bin --enable-mpi LDFLAGS=-L/usr/local/fftw-3.3.6-pl2/lib \
	CPPFLAGS=-I/usr/local/fftw-3.3.6-pl2/include
	make
	make &> log
	make mdrun
	make install
	make install-mdrun
	make links
	```
## Install in MacOS
Ref: https://bioinformaticsreview.com/20220206/how-to-install-gromacs-on-apple-m1-macos/
	```
	% cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=OFF -DCMAKE_C_COMPILER=gcc -DREGRESSIONTEST_PATH=/Users/jihun/Downloads/software/regressiontests-2022.2
	% sudo make check
	```
## Force Field
- name setting : /opt/gromacs/2022.4/share/gromacs/top/charmm36-jul2022.ff/forcefield.doc
- CHARMM FF for gromacs
	Ref: http://mackerell.umaryland.edu/charmm_ff.shtml#gromacs

## File format
- gro : 
	- "A model cannot have more than 99,999 atoms. Where the entry does not contain an ensemble of models, then the entry cannot have more than 99,999 atoms. Entries that go beyond this atom limit must be split into multiple entries, each containing no more than the limits specified above." (REF: https://mailman-1.sys.kth.se/pipermail/gromacs.org_gmx-users/2017-November/117061.html)
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

# Basics
```
gmx help (module)
gmx (module) -h
```
- Unit : https://manual.gromacs.org/documentation/2019/reference-manual/definitions.html
- Online Reference : https://manual.gromacs.org/archive/4.6.5/online.html  


# Tutorial
Ref: http://www.mdtutorials.com/gmx/lysozyme/index.html
![image](https://user-images.githubusercontent.com/48517782/172881380-7c7b5c8e-adb2-446b-a686-7adc91012dcb.png)

## Protein-Ligand complex preparation with Charm36 all-atomic FF on Gromacs
### Protien model preparation
loop reconstruction by PDBFixer > remove solvent & PO4 (from crystal) by Pymol > change from O1- to O by manual edition > change OXT to O (gromacs cannot recognize OXT) by manual edition

### Ligand model preparation
- Installation of `networkx 2.3` whose is compatible with `python 3.7`
	Ref: https://networkx.org/documentation/networkx-2.3/
	Ref: https://pypi.org/project/networkx/2.3/
	```
	$ conda activate md_py37
	$ conda install networkx==2.3
	$ conda install numpy
	```
- Prepare the input for CGENFF
	```
	$ obabel 6kqy-Leu2-model_h.pdb -O 6kqy-Leu2-model_h.mol2 -h # to convert pdb file into mol2 file
	$ pymol 6kqy-Leu2-model_h.mol2 # to sanity check
	$ perl sort_mol2_bonds.pl 6kqy-Leu2-model_h_edit.mol2 6kqy-Leu2-model_h_fixed.mol2 # to change bond order at @<TRIPOS>BOND section
	```
- Run CGenFF
- To convert into gmx format
	```
	$ python3 cgenff_charmm2gmx_py3_nx2.py Leu2.pdb 6kqy-Leu2-model_h.mol2 6kqy-Leu2-model_h.str charmm36-jul2022.ff
	```
	>> Tiral & Error
	>> Error : CGenff Error: specified residue name does not match between str and mol2 files
	>> Sol: to change search residue name (Ref: https://gromacs.bioexcel.eu/t/cgenff-error-specified-residue-name-does-not-match-between-str-and-mol2-files/1190)

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
gmx pdb2gmx -f 1AKI_clean.pdb -o model.gro -water spce (-ter)
gmx pdb2gmx -f 1AKI_clean.pdb -o model.gro -water tip3p (-ter)
gmx pdb2gmx -f ${PROTEIN}.pdb -o model.gro -water tip3p -ff charmm27 -ignh

```
> -f : input file  
> -ignh :  Ignore H atoms in the PDB file; especially useful for NMR structures. Otherwise, if H atoms are present, they must be in the named exactly how the force fields in GROMACS expect them to be. Different conventions exist, so dealing with H atoms can occasionally be a headache! If you need to preserve the initial H coordinates, but renaming is required, then the Linux sed command is your friend.  
> -ter: Interactively assign charge states for N- and C-termini.  
> -inter: Interactively assign charge states for Glu, Asp, Lys, Arg, and His; choose which Cys are involved in disulfide bonds.  
> - Water model to use: select, none, spc, spce, tip3p, tip4p, tip5p, tips3p
> - ter : for charm FF  
To select the Force Field (The force field will contain the information that will be written to the topology. This is a very important choice! You should always read thoroughly about each force field and decide which is most applicable to your situation.) Depends on the force field you're trying to use. For example, with Gromos force fields (which were parameterized for use with SPC), using SPC or SPC/E gives very good results in light of the original theory behind the force field and the parameterization.

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
- Trial and Error:
	- the input structure to pdb2gmx has hydrogen atoms whose naming differs from that given in the .rtp file of the force field.
		Ref: https://www.researchgate.net/post/How-can-I-rectify-the-following-GROMACS-error-Fatal-error-Atom-HB3-in-residue-SER-3-was-not-found-in-rtp-entry-SER-with-8-atoms-while-sorting-atoms   
	- `Protein-ligand complex.gro` with multiple ligands should have consistent indentation. Otherwise, only one ligand is properly recognized.
	- [Charm FF] Fatal error: atom C not found in buiding block 8FUC while combining tdb and rtp
	 	use `-ter` option and select `NH3+` and `COO-` for N-terminal and C-terminal residue for a protein
		(Ref1: https://gromacs.bioexcel.eu/t/help-on-how-to-solve-atom-n-not-found-in-building-block-1ade-while-combining-tdb-and-rtp/2298)(REF2: https://gromacs.bioexcel.eu/t/help-on-how-to-solve-atom-n-not-found-in-building-block-1ade-while-combining-tdb-and-rtp/2298)
	- 
To generate a box for simulation (`box.gro`)
```
gmx editconf -f model.gro -o box.gro -c -d 1.0 -bt cubic 
gmx editconf -f model.gro -o box.gro -c -d 1.5 -bt cubic  # for publication
gmx editconf -f model.gro -o box.gro -center 9.207  9.207  9.207-3 -d 1.5 -bt cubic
gmx editconf -f model.gro -o box.gro -c -bt cubic -box 5 5 5 
```
> -d : distance from cubic box
> -box (x,y,z) : the size of box in the unit of nm
> - the box size does not significantly affect the mobility of protein atoms on a relatively short trajectory, while the effect of the precipitant concentration on this trajectory is noticeable. (Ref: Kordonskaya, Y.V., Timofeev, V.I., Dyakova, Y.A. et al. Effect of the Simulation Box Size and Precipitant Concentration on the Behavior of Tetragonal Lysozyme Dimer. Crystallogr. Rep. 66, 525–528 (2021). https://doi.org/10.1134/S106377452103010X)  > - 5 nm = 50 angstrom  
> - for simulations you want to publish this number should be 1.2…1.5 nm so that the electrostatic interactions between copies of the protein across periodic boundaries are sufficiently screened.
> - `Know-how` (1) `-c` `-d 1.5` options suggests the automatic selection for a water box. Check the position of water box after the solvation process. If all of protein was not covered thoroughly, then modify the protein position in this step.
```
gmx solvate -cp box.gro -cs [configuration_of_solvent_from_library.gro] -o model_solv.gro -p topol.top
gmx solvate -cp box.gro -cs spc216.gro -o model_solv.gro -p topol.top
```
> - spc216.gro is a pre-equilibrated box of 216 SPC water molecules. It can be used as the source of water coordinates for any 3-point water model because they all only vary slightly. After minimization and equilibration using the desired water force field, you’ll recover the proper behavior of TIP3P, SPC/E, etc. tip4p.gro for four-points water models. tip5p for five-points water models. (ref: https://gromacs.bioexcel.eu/t/relation-between-water-spce-and-cs-spc216-gro/1106)
>  
Assemble tpr file
```
gmx grompp -f ions.mdp -c model_solv.gro -p topol.top -o ions.tpr
```

To add ion
`ions.mdp` file
```
; ions.mdp - used as input into grompp to generate ions.tpr
; Parameters describing what to do, when to stop and what to save
integrator  = steep         ; Algorithm (steep = steepest descent minimization)
emtol       = 1000.0        ; Stop minimization when the maximum force < 1000.0 kJ/mol/nm
emstep      = 0.01          ; Minimization step size [nm]
nsteps      = 50000         ; Maximum number of (minimization) steps to perform

; Parameters describing how to find the neighbors of each atom and how to calculate the interactions
nstlist         = 1         ; Frequency to update the neighbor list and long range forces
cutoff-scheme	= Verlet    ; Buffered neighbor searching 
ns_type         = grid      ; Method to determine neighbor list (simple, grid)
coulombtype     = cutoff    ; Treatment of long range electrostatic interactions
rcoulomb        = 1.0       ; Short-range electrostatic cut-off (nm) ; 1 nm = 10 Angstrom
rvdw            = 1.0       ; Short-range Van der Waals cut-off (nm) ; 1 nm = 10 Angstrom
pbc             = xyz       ; Periodic Boundary Conditions in all 3 dimensions
```

```
$ gmx genion -s ions.tpr -o model_solv_ions.gro -p topol.top -pname NA -nname CL -neutral 
>> Group    13 (            SOL)
> umber of (3-atomic) solvent molecules: 110719
	Processing topology
	Replacing 5 solute molecules in topology file (topol.top)  by 5 NA and 0 CL ions. 	

$ vi topol.top
	Change topology : remove 5 water molecule and add 5 NA inorder to match the number of atoms in topol and gro
```


## Energy minimization (EM) : EM ensured that we have a reasonable starting structure, in terms of geometry and solvent orientation. The purpose of energy minimization is not to find the global or local minimum, but to escape from the force in high gradient and avoid protein collapse.
`nunu.mdp` file
```
; minim.mdp - used as input into grompp to generate em.tpr
; Parameters describing what to do, when to stop and what to save
integrator  = steep         ; Algorithm (steep = steepest descent minimization)
emtol       = 1000.0        ; Stop minimization when the maximum force < 1000.0 kJ/mol/nm
emstep      = 0.01          ; Minimization step size [nm]
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
$ gmx grompp -f minim.mdp -c model_solv_ions.gro -p topol.top -o em.tpr
$ gmx mdrun -v -deffnm em -nb gpu -gpu_id 0
$ gmx energy -f em.edr -o potential.xvg
--> 10 0
$ xmgrace potential.xvg
```

Output:   
- em.log: ASCII-text log file of the EM process
- em.edr: Binary energy file
- em.trr: Binary full-precision trajectory
- em.gro: Energy-minimized structure

### Equilibration
- Restraining the ligand at equilibration
	Ref: https://mattermodeling.stackexchange.com/questions/8336/why-are-ligands-restrained-when-simulating-a-protein-ligand-complex-with-md
	- The cause to use restrains is due to a previous knowledge (i.e. experimental) of system behavior/characteristics that you want to include/retain/reproduce in your simulations. In the case of protein-ligand complex simulations, they encode specifically prior knowledge about the macromolecular system to be simulated and is built of several components. These include the following: 
		- Stereochemical information (e.g. bond distances, angles) about the constituent blocks (e.g. amino acids, nucleic acids) of macromolecules and the covalent links between them.
		- The internal consistency of macromolecules (e.g. non-crystallographic symmetry, if present).
		- Additional structural knowledge (similarity to known structures, current interatomic distances or secondary-structure elements etc.).
		- The process of generating a set of restraints, or ‘dictionary’, for a small molecule involves (i) taking a description of the molecule as an input, (ii) processing its description to derive atom energy types and connectivities, and finally (iii) using this information to generate an idealized set of coordinates to allow fitting of the ligand to electron density and a list of geometric restraints with associated weights to allow the fitted ligand to be refined.

	Ref: https://www.researchgate.net/post/should_i_restraint_protein_and_ligand_in_md_production
	- Normally, the restraints should be gradually released during the equilibration MD simulation; the final part of the equilibration MD simulation should be performed without any restraints and the simulation parameters should be identical to those subsequently applied in the production MD simulation.

	```
	$ gmx make_ndx -f leu2.gro -o index_leu2.ndx
		> Analysing residues not classified as Protein/DNA/RNA/Water and splitting into groups...
			0 System              :    23 atoms
			1 Other               :    23 atoms
			2 Leu2                :    23 atoms

		 nr : group      '!': not  'name' nr name   'splitch' nr    Enter: list groups
		 'a': atom       '&': and  'del' nr         'splitres' nr   'l': list residues
		 't': atom type  '|': or   'keep' nr        'splitat' nr    'h': help
		 'r': residue              'res' nr         'chain' char
		 "name": group             'case': case sensitive           'q': save and quit
		 'ri': residue index
		>> 0 & ! a H*  # to select only non-hydrogen atoms in a ligand
	
	$ gmx genrestr -f leu2.gro -n index_leu2.ndx -o posre_leu2.itp -fc 1000 1000 1000
		> Select group to position restrain
			Group     0 (         System) has    23 elements
			Group     1 (          Other) has    23 elements
			Group     2 (           Leu2) has    23 elements
			Group     3 (   System_&_!H*) has     9 elements
			Select a group: 
		>>	3

	$ vi topol.top
		; Ligand position restraints
		# ifdef POSES
		#include "posre_leu2.itp"
		#endif
	
	```
- Thermostats for protein-ligand complex
	```
	$ gmx make_ndx -f em.gro -o index.ndx
	>	Analysing residues not classified as Protein/DNA/RNA/Water and splitting into groups...
		0 System              : 349235 atoms
		1 Protein             : 17065 atoms
		2 Protein-H           :  8539 atoms
		3 C-alpha             :  1061 atoms
		4 Backbone            :  3183 atoms
		5 MainChain           :  4243 atoms
		6 MainChain+Cb        :  5241 atoms
		7 MainChain+H         :  5253 atoms
		8 SideChain           : 11812 atoms
		9 SideChain-H         :  4296 atoms
	 10 Prot-Masses         : 17065 atoms
	 11 non-Protein         : 332170 atoms
	 12 Other               :    23 atoms
	 13 Leu2                :    23 atoms
	 14 NA                  :     5 atoms
	 15 Water               : 332142 atoms
	 16 SOL                 : 332142 atoms
	 17 non-Water           : 17093 atoms
	 18 Ion                 :     5 atoms
	 19 Water_and_ions      : 332147 atoms

	 nr : group      '!': not  'name' nr name   'splitch' nr    Enter: list groups
	 'a': atom       '&': and  'del' nr         'splitres' nr   'l': list residues
	 't': atom type  '|': or   'keep' nr        'splitat' nr    'h': help
	 'r': residue              'res' nr         'chain' char
	 "name": group             'case': case sensitive           'q': save and quit
	 'ri': residue index
	>> 1 | 13
	> Copied index group 1 'Protein'
		Copied index group 13 'Leu2'
		Merged two groups with OR: 17065 23 -> 17088

		 20 Protein_Leu2        : 17088 atoms
	>> q
	
	
	```
- NVT equilibrium
	nvt.mdp
	```
	title                   = OPLS Lysozyme NVT equilibration 
	define                  = -DPOSRES  ; position restrain the protein
	; Run parameters
	integrator              = md        ; leap-frog integrator
	nsteps                  = 50000     ; 2 * 50000 = 100 ps
	dt                      = 0.002     ; 2 fs
	; Output control
	nstxout                 = 500       ; save coordinates every 1.0 ps
	nstvout                 = 500       ; save velocities every 1.0 ps
	nstenergy               = 500       ; save energies every 1.0 ps
	nstlog                  = 500       ; update log file every 1.0 ps
	; Bond parameters
	continuation            = no        ; first dynamics run
	constraint_algorithm    = lincs     ; holonomic constraints 
	constraints             = h-bonds   ; bonds involving H are constrained
	lincs_iter              = 1         ; accuracy of LINCS
	lincs_order             = 4         ; also related to accuracy
	; Nonbonded settings 
	cutoff-scheme           = Verlet    ; Buffered neighbor searching
	ns_type                 = grid      ; search neighboring grid cells
	nstlist                 = 10        ; 20 fs, largely irrelevant with Verlet
	rcoulomb                = 1.0       ; short-range electrostatic cutoff (in nm)
	rvdw                    = 1.0       ; short-range van der Waals cutoff (in nm)
	DispCorr                = EnerPres  ; account for cut-off vdW scheme
	; Electrostatics
	coulombtype             = PME       ; Particle Mesh Ewald for long-range electrostatics
	pme_order               = 4         ; cubic interpolation
	fourierspacing          = 0.16      ; grid spacing for FFT
	; Temperature coupling is on
	tcoupl                  = V-rescale             ; modified Berendsen thermostat
	tc-grps                 = Protein Non-Protein   ; two coupling groups - more accurate
	tau_t                   = 0.1     0.1           ; time constant, in ps
	ref_t                   = 300     300           ; reference temperature, one for each group, in K
	; Pressure coupling is off
	pcoupl                  = no        ; no pressure coupling in NVT
	; Periodic boundary conditions
	pbc                     = xyz       ; 3-D PBC
	; Velocity generation
	gen_vel                 = yes       ; assign velocities from Maxwell distribution
	gen_temp                = 300       ; temperature for Maxwell distribution
	gen_seed                = -1        ; generate a random seed
	```

	```
	$ gmx grompp -f nvt.mdp -c em_50000.gro -r em_50000.gro -p topol.top (-n index.ndx) -o nvt.tpr
	$ gmx mdrun -v -deffnm nvt -nb gpu -gpu_id 0
	$ gmx energy -f nvt.edr -o temperature.xvg
		--> 16 0
	$ xmgrace potential.xvg
	```
- NPT equilibrium
	npt.mdp
	```
	title                   = OPLS Lysozyme NPT equilibration 
	define                  = -DPOSRES  ; position restrain the protein
	; Run parameters
	integrator              = md        ; leap-frog integrator
	nsteps                  = 50000     ; 2 * 50000 = 100 ps
	dt                      = 0.002     ; 2 fs
	; Output control
	nstxout                 = 500       ; save coordinates every 1.0 ps
	nstvout                 = 500       ; save velocities every 1.0 ps
	nstenergy               = 500       ; save energies every 1.0 ps
	nstlog                  = 500       ; update log file every 1.0 ps
	; Bond parameters
	continuation            = yes       ; Restarting after NVT 
	constraint_algorithm    = lincs     ; holonomic constraints 
	constraints             = h-bonds   ; bonds involving H are constrained
	lincs_iter              = 1         ; accuracy of LINCS
	lincs_order             = 4         ; also related to accuracy
	; Nonbonded settings 
	cutoff-scheme           = Verlet    ; Buffered neighbor searching
	ns_type                 = grid      ; search neighboring grid cells
	nstlist                 = 10        ; 20 fs, largely irrelevant with Verlet scheme
	rcoulomb                = 1.0       ; short-range electrostatic cutoff (in nm)
	rvdw                    = 1.0       ; short-range van der Waals cutoff (in nm)
	DispCorr                = EnerPres  ; account for cut-off vdW scheme
	; Electrostatics
	coulombtype             = PME       ; Particle Mesh Ewald for long-range electrostatics
	pme_order               = 4         ; cubic interpolation
	fourierspacing          = 0.16      ; grid spacing for FFT
	; Temperature coupling is on
	tcoupl                  = V-rescale             ; modified Berendsen thermostat
	tc-grps                 = Protein Non-Protein   ; two coupling groups - more accurate
	tau_t                   = 0.1     0.1           ; time constant, in ps
	ref_t                   = 300     300           ; reference temperature, one for each group, in K
	; Pressure coupling is on
	pcoupl                  = Parrinello-Rahman     ; Pressure coupling on in NPT
	pcoupltype              = isotropic             ; uniform scaling of box vectors
	tau_p                   = 2.0                   ; time constant, in ps
	ref_p                   = 1.0                   ; reference pressure, in bar
	compressibility         = 4.5e-5                ; isothermal compressibility of water, bar^-1
	refcoord_scaling        = com
	; Periodic boundary conditions
	pbc                     = xyz       ; 3-D PBC
	; Velocity generation
	gen_vel                 = no        ; Velocity generation is off 
	```
	
	```
	$ gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top (-n index.ndx) -o npt.tpr
			> -t (time check point): the checkpoint file from the NVT equilibration, containing all the necessary state variables to continue our simulation.
			> -c (coordinate file): the final output of the NVT simulation 
	$ gmx mdrun -v -deffnm npt -nb gpu -gpu_id 0
	$ gmx energy -f npt.edr -o pressure.xvg
		--> 18 0
	$ xmgrace pressure.xvg
	```
## Production MD
md.mdp
```
title                   = NARS2
; Run parameters
integrator              = md        ; leap-frog integrator
nsteps                  = 500000    ; 2 * 500000 = 1000 ps (1 ns)
dt                      = 0.002     ; 2 fs
; Output control
nstxout                 = 0         ; suppress bulky .trr file by specifying 
nstvout                 = 0         ; 0 for output frequency of nstxout,
nstfout                 = 0         ; nstvout, and nstfout
nstenergy               = 5000      ; save energies every 10.0 ps
nstlog                  = 5000      ; update log file every 10.0 ps
nstxout-compressed      = 5000      ; save compressed coordinates every 10.0 ps
compressed-x-grps       = System    ; save the whole system
; Bond parameters
continuation            = yes       ; Restarting after NPT 
constraint_algorithm    = lincs     ; holonomic constraints 
constraints             = h-bonds   ; bonds involving H are constrained
lincs_iter              = 1         ; accuracy of LINCS
lincs_order             = 4         ; also related to accuracy
; Neighborsearching
cutoff-scheme           = Verlet    ; Buffered neighbor searching
ns_type                 = grid      ; search neighboring grid cells
nstlist                 = 10        ; 20 fs, largely irrelevant with Verlet scheme
rcoulomb                = 1.0       ; short-range electrostatic cutoff (in nm)
rvdw                    = 1.0       ; short-range van der Waals cutoff (in nm)
; Electrostatics
coulombtype             = PME       ; Particle Mesh Ewald for long-range electrostatics
pme_order               = 4         ; cubic interpolation
fourierspacing          = 0.16      ; grid spacing for FFT
; Temperature coupling is on
tcoupl                  = V-rescale             ; modified Berendsen thermostat
tc-grps                 = Protein Non-Protein   ; two coupling groups - more accurate
tau_t                   = 0.1     0.1           ; time constant, in ps
ref_t                   = 300     300           ; reference temperature, one for each group, in K
; Pressure coupling is on
pcoupl                  = Parrinello-Rahman     ; Pressure coupling on in NPT
pcoupltype              = isotropic             ; uniform scaling of box vectors
tau_p                   = 2.0                   ; time constant, in ps
ref_p                   = 1.0                   ; reference pressure, in bar
compressibility         = 4.5e-5                ; isothermal compressibility of water, bar^-1
; Periodic boundary conditions
pbc                     = xyz       ; 3-D PBC
; Dispersion correction
DispCorr                = EnerPres  ; account for cut-off vdW scheme
; Velocity generation
gen_vel                 = no        ; Velocity generation is off 
```
```
$ gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top (-n index.ndx) -o md_0_1.tpr
$ gmx mdrun -v -deffnm md_0_1 -nb gpu -gpu_id 0
	> Starts gmx mdrun with 1 GPU with id 0
```
- thread control  
	Ref: https://manual.gromacs.org/documentation/current/user-guide/mdrun-performance.html  
	- nt <int> (0): The total number of threads to use. The default, 0, will start as many threads as available cores. Whether the threads are thread-MPI ranks, and/or OpenMP threads within such ranks depends on other settings.
	```
	Reading file md_0_1.tpr, VERSION 2022.4 (single precision)
	Changing nstlist from 10 to 80, rlist from 1 to 1.147

	On host gpu1 2 GPUs selected for this run.
	Mapping of GPU IDs to the 4 GPU tasks in the 4 ranks on this node:
		PP:0,PP:0,PP:1,PP:1
	PP tasks will do (non-perturbed) short-ranged and most bonded interactions on the GPU
	PP task will update and constrain coordinates on the CPU
	Using 4 MPI threads
	Using 6 OpenMP threads per tMPI thread

	```
	```
	1 GPU selected for this run.  
	Mapping of GPU IDs to the 2 GPU tasks in the 1 rank on this node:  
		PP:0,PME:0  
	PP tasks will do (non-perturbed) short-ranged interactions on the GPU  
	PP task will update and constrain coordinates on the CPU  
	PME tasks will do all aspects on the GPU  
	Using 1 MPI thread  
	Using 24 OpenMP threads  
	```
	
- extension  
	Ref (tutorial): https://www.compchems.com/extend-or-continue-a-gromacs-simulation/#example  
	Ref (offical documentation / Managing long simulations): https://manual.gromacs.org/current/user-guide/managing-simulations.html  
	Ref (offical documentation / mdrun) : https://manual.gromacs.org/current/onlinehelp/gmx-mdrun.html?highlight=mdrun  
	Ref (official documentation / convert-tpr) : https://manual.gromacs.org/current/onlinehelp/gmx-convert-tpr.html  

	```
	# Let’s say you finished a 10 ns simulation from a tpr file (md_10.tpr) but then you realized you would like to simulate your system for an additional 10 ns.
	gmx_mpi convert-tpr -s md_10.tpr (-extend 10000 [unit in ps]) (-nsteps [final_steps]) (-until [a certain ending time in ps] ) -o md_20.tpr 
	
	# Now we can run the new tpr file (md_20.tpr) starting from the last checkpoint.
	gmx mdrun -v -deffnm md_20 -cpi md_10.cpt -noappend
	
	# You can finally proceed to concatenate the new trajectory to the previous one using the gmx trjcat module as shown here.
	gmx trjcat -f md_10.xtc md_20.part0002.xtc -o final.xtc
	```
	
# Result analysis
Ref (tutorial pdf1): http://www.drugdesign.gr/uploads/7/6/0/2/7602318/lecture_mdanalysis.pdf  
Ref (tutorial pdf2): https://hpc-forge.cineca.it/files/CoursesDev/public/2015/High_Performance_Molecular_Dynamics/Rome/February/Tutorial4_Analysis.pdf   
- to recenter the protein and rewrap the molecules within the unit cell  
	The first is trjconv, which is used as a post-processing tool to strip out coordinates, correct for periodicity, or manually alter the trajectory (time units, frame frequency, etc). For this exercise, we will use trjconv to account for any periodicity in the system. The protein will diffuse through the unit cell, and may appear "broken" or may "jump" across to the other side of the box. To account for such behaviors, issue the following:
	```
	gmx trjconv -s md_0_1.tpr -f md_0_1.xtc -o md_0_1_center.xtc -pbc mol -center
	```
Select 1 ("Protein") as the group to be centered and 0 ("System") for output. We will conduct all our analyses on this "corrected" trajectory. 
- rotational and translational fitting
	```
	gmx trjconv -s md_0_1.tpr -f md_0_1_center.xtc -o md_0_1_fit.xtc -fit rot+trans
	```
- to extract a specific frame (here, t=0 ns) of a trajectory
	```
	gmx trjconv -s md_0_1.tpr -f md_0_1_center.xtc -o start.pdb -dump 0
	```
- RMSD  
	Let's look at structural stability first. GROMACS has a built-in utility for RMSD calculations called rms. To use rms, issue this command:

	```
	gmx rms -s md_0_1.tpr -f md_0_1_noPBC.xtc -o rmsd.xvg -tu ns
	```
	Choose 4 ("Backbone") for both the least-squares fit and the group for RMSD calculation. The -tu flag will output the results in terms of ns, even though the trajectory was written in ps. This is done for clarity of the output (especially if you have a long simulation - 1e+05 ps does not look as nice as 100 ns). The output plot will show the RMSD relative to the structure present in the minimized, equilibrated system:

	If we wish to calculate RMSD relative to the crystal structure, we could issue the following:
	```
	gmx rms -s em.tpr -f md_0_1_noPBC.xtc -o rmsd_xtal.xvg -tu ns
	```
	Plotted together, results look something like:


	Both time series show the RMSD levels off to ~0.1 nm (1 Å), indicating that the structure is very stable. Subtle differences between the plots indicate that the structure at t = 0 ns is slightly different from this crystal structure. This is to be expected, since it has been energy-minimized, and because the position restraints are not 100% perfect, as discussed previously.

- RMSF  
	Ref: https://manual.gromacs.org/archive/4.6.5/online/g_rmsf.html  
	```
	gmx rmsf -s md_0_1.tpr -f md_0_1_noPBC.xtc -res yes -o rmsf.xvg
	```
- gyration  
	```
	gmx gyrate -s md_0_1.tpr -f md_0_1.xtc -o gyrate.xvg
	```
- SASA  
	Ref: https://www.compchems.com/how-to-compute-the-solvent-accessible-surface-areas-sasa-with-gromacs/#how-to-compute-sasa-for-a-protein-structure
	```
 	gmx sasa -s md_0_1.tpr -f md_0_1_noPBC.xtc -o sasa.xvg -tu ns
 	```
- distance
	e.g. distance between OXT in Leu2 and NH2 in 295
	```
	gmx distance -s md_0_200ns.tpr -f md_0_200ns_fit.xtc -select 'resname "Leu2" and name OXT plus resid 295 and name NH2' -oall
	```
- Hydrogen bond  
	Ref: https://www.compchems.com/how-to-study-hydrogen-bonds-using-gromacs/#how-to-compute-the-hydrogen-bonds-between-two-groups
	```
	gmx hbond -f md_0_1_noPBC.xtc -s md_0_1.tpr -num hbnum.xvg
	```
	

- `xvg` to python  
	Ref: https://www.compchems.com/how-to-extract-and-plot-thermodynamic-properties-from-a-gromacs-simulation/#example
	```
	```
- 	
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
$ gmx mdrun -deffnm md_0_1
```
```
GROMACS:      gmx mdrun, version 2021.4-Ubuntu-2021.4-2
Executable:   /usr/bin/gmx
Data prefix:  /usr
Working dir:  /home/jihun/molecular_dynamics/dars2
Command line:
  gmx mdrun -deffnm md_0_1

Compiled SIMD: SSE4.1, but for this host/run AVX_512 might be better (see
log).
Reading file md_0_1.tpr, VERSION 2021.4-Ubuntu-2021.4-2 (single precision)
Changing nstlist from 10 to 40, rlist from 1 to 1.098

Using 28 MPI threads
Using 1 OpenMP thread per tMPI thread

starting mdrun 'ASPARAGINE--TRNA LIGASE, CYTOPLASMIC in water'
500000 steps,   1000.0 ps.

Writing final coordinates.


Dynamic load balancing report:
 DLB was turned on during the run due to measured imbalance.
 Average load imbalance: 6.7%.
 The balanceable part of the MD step is 73%, load imbalance is computed from this.
 Part of the total run time spent waiting due to load imbalance: 4.9%.
 Steps where the load balancing was limited by -rdd, -rcon and/or -dds: X 0 % Y 0 % Z 0 %
 Average PME mesh/force load: 0.677
 Part of the total run time spent waiting due to PP/PME imbalance: 4.1 %


               Core t (s)   Wall t (s)        (%)
       Time:  1508233.468    53865.481     2800.0
                         14h57:45
                 (ns/day)    (hour/ns)
Performance:        1.604       14.963

GROMACS reminds you: "Your Shopping Techniques are Amazing" (Gogol Bordello)

```
	
```
Note that the trajectory of receptor-binder should be adjusted for visualization
$ printf "Protein\n0System\n" | gmx trjconv -f md_0_1.xtc -s md_0_1.gro -o md_0_1_nojump.xtc -center -pdb nojump
$ printf "Protein\nSystem\n" | gmx trjconv -f md_0_1.xtc -s md_0_1.tpr -o md_center.xtc -center -pbc mol -ur compact
```

```
xmgrace [file_name].xvg
```

# Analysis
- Solvent Accessible Surface Area (SASA)
Ref: https://www.compchems.com/how-to-compute-the-solvent-accessible-surface-areas-sasa-with-gromacs/#solvent-accessible-surface-area-sasa
-  The ligand stays intact till 80ns simulaiton but is found far away from protein after 80ns. Suggestions?  
	Ref: https://www.researchgate.net/post/I-am-performing-MD-simulation-after-docking-The-ligand-stays-intact-till-80ns-simulaiton-but-is-found-far-away-from-protein-after-80ns-Suggestions

# Materials
- https://computecanada.github.io/molmodsim-md-theory-lesson-novice/
- 
