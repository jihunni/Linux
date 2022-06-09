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




To generate a box for simulation
```
gmx editconf -f file.gro -o box.gro -c -d 1.0 -bt cubic 
```
> -d : distance from cubic box

```
gmx solvate -cp box.gro -cs spc216.gro -o water_box.gro -p file.top
```
Assemble tpr file
```
gmx grompp -f inos.mdp -c water_box.gro -p file.top -o ions.tpr
```

```
gmx genioin -s ions.tpr -o water_ions.gro -p file.top -pname NA -nname CL -neutral 
```
