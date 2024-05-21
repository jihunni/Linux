# Amber
Ref: https://ambermd.org/index.php
# Amber simulation
![image](https://github.com/jihunni/Linux/assets/48517782/f4a171d8-a5c0-43f7-81ca-e762143ba9a4)

## preparation
```
pdb4amber -i 7o1r.pdb -o 7o1r.amber.pdb --dry --reduce
```
# Installation of AmberTool22 
- Conda (w/o GPU or multi-parallelization)
- Binary ()

 

## ANTECHAMBER & GAFF : they became a part of AmberTool22
Ref: http://ambermd.org/antechamber/antechamber.html  
Ref: http://ambermd.org/antechamber/ac.html  
Tutorial : http://ambermd.org/tutorials/basic/tutorial4b/  
```
To add all hydrogen atoms to the pdb file
$ reduce sustiva.pdb > sustiva_h.pdb  

To create the "mol2" file, required to define a new unit in LEaP
$ antechamber -i sustiva_new.pdb -fi pdb -o sustiva.mol2 -fo mol2 -c bcc -s 2
```
- [Trial & Error]  
  Error message
    ```
    $ antechamber -i 6kqy-Leu1-model_h.pdb -fi pdb -o 6kqy-Leu1-model_h.mol2 -fo mol2 -c bcc -s 2

    Welcome to antechamber 22.0: molecular input file processor.

    Info: acdoctor mode is on: check and diagnose problems in the input file.
    Info: The atom type is set to gaff; the options available to the -at flag are
          gaff, gaff2, amber, bcc, and sybyl.

    -- Check Format for pdb File --
       Status: pass
    Info: Determining atomic numbers from atomic symbols which are case sensitive.
    -- Check Unusual Elements --
       Status: pass
    -- Check Open Valences --
       Status: pass
    -- Check Geometry --
          for those bonded   
          for those not bonded   
    Warning: Close ( 0.89) nonbonded atoms (ID: 1, Name: N) and (ID: 10, Name: H1).
    Warning: Close ( 0.89) nonbonded atoms (ID: 1, Name: N) and (ID: 11, Name: H2).
    Warning: Close ( 0.89) nonbonded atoms (ID: 1, Name: N) and (ID: 12, Name: H3).
    Warning: Close ( 0.97) nonbonded atoms (ID: 2, Name: CA) and (ID: 13, Name: HA).
    Warning: Close ( 0.97) nonbonded atoms (ID: 5, Name: CB) and (ID: 14, Name: HB2).
    Warning: Close ( 0.97) nonbonded atoms (ID: 5, Name: CB) and (ID: 15, Name: HB3).
    Warning: Close ( 0.97) nonbonded atoms (ID: 6, Name: CG) and (ID: 16, Name: HG).
    Warning: Close ( 0.97) nonbonded atoms (ID: 7, Name: CD1) and (ID: 17, Name: HD11).
    Warning: Close ( 0.97) nonbonded atoms (ID: 7, Name: CD1) and (ID: 18, Name: HD12).
    Warning: Close ( 0.97) nonbonded atoms (ID: 7, Name: CD1) and (ID: 19, Name: HD13).
    Warning: Close ( 0.97) nonbonded atoms (ID: 8, Name: CD2) and (ID: 20, Name: HD21).
    Warning: Close ( 0.97) nonbonded atoms (ID: 8, Name: CD2) and (ID: 21, Name: HD22).
    Warning: Close ( 0.97) nonbonded atoms (ID: 8, Name: CD2) and (ID: 22, Name: HD23).
    -- Check Weird Bonds --
       Status: pass
    -- Check Number of Units --
    /home/jihun/.conda/envs/AmberTools22/bin/wrapped_progs/antechamber: Fatal Error!
    This molecule may have more than one unit.
           antechamber can only handle one unit.  If the input is a single unit
           then the connectivity is wrong and the geometry may be bad.
           Please convert your molecule to a mol2 file via:
           antechamber -j 5 -at sybyl -dr no 
           And then check your molecule with a visualization program;
           manually add missing bonds or delete unwanted bonds as appropriate.
    ```
  
  Solution : remove all `CONECT` information in PDB
    Problem
    ```
    CRYST1  123.744  123.744  536.440  90.00  90.00 120.00 P 65 2 2      1
    HETATM    1  N   LEU A 1201       8.644 -57.872 -15.777  1.00 29.40           N  
    HETATM    2  CA  LEU A 1201       8.171 -57.269 -14.534  1.00 31.09           C  
    HETATM    3  C   LEU A 1201       8.674 -58.065 -13.320  1.00 28.21           C  
    HETATM    4  O   LEU A 1201       9.474 -58.995 -13.436  1.00 23.26           O  
    HETATM    5  CB  LEU A 1201       6.632 -57.182 -14.527  1.00 28.51           C  
    HETATM    6  CG  LEU A 1201       5.880 -56.894 -15.843  1.00 22.60           C  
    HETATM    7  CD1 LEU A 1201       4.337 -56.906 -15.684  1.00 10.61           C  
    HETATM    8  CD2 LEU A 1201       6.349 -55.587 -16.444  1.00 23.91           C  
    HETATM    9  OXT LEU A 1201       8.285 -57.797 -12.178  1.00 26.81           O  
    CONECT    1    2
    CONECT    2    1    3    5
    CONECT    3    2    4    9
    CONECT    4    3
    CONECT    5    2    6
    CONECT    6    5    7    8
    CONECT    7    6
    CONECT    8    6
    CONECT    9    3
    END
    ```
    Solution
    ```
    CRYST1  123.744  123.744  536.440  90.00  90.00 120.00 P 65 2 2      1
    HETATM    1  N   LEU A 1201       8.644 -57.872 -15.777  1.00 29.40           N  
    HETATM    2  CA  LEU A 1201       8.171 -57.269 -14.534  1.00 31.09           C  
    HETATM    3  C   LEU A 1201       8.674 -58.065 -13.320  1.00 28.21           C  
    HETATM    4  O   LEU A 1201       9.474 -58.995 -13.436  1.00 23.26           O  
    HETATM    5  CB  LEU A 1201       6.632 -57.182 -14.527  1.00 28.51           C  
    HETATM    6  CG  LEU A 1201       5.880 -56.894 -15.843  1.00 22.60           C  
    HETATM    7  CD1 LEU A 1201       4.337 -56.906 -15.684  1.00 10.61           C  
    HETATM    8  CD2 LEU A 1201       6.349 -55.587 -16.444  1.00 23.91           C  
    HETATM    9  OXT LEU A 1201       8.285 -57.797 -12.178  1.00 26.81           O  
    ```

```
To test if all the parameters we require are available
$ parmchk2 -i sustiva.mol2 -f mol2 -o sustiva.frcmod

$tleap -f oldff/leaprc.ff99SB
  > source leaprc.gaff
  > SUS = loadmol2 sustiva.mol2 
  > check SUS
  > loadamberparams sustiva.frcmod
  > saveoff SUS sus.lib 
  > saveamberparm SUS sustiva.prmtop sustiva.rst7
  > quit
```
## Using Amber force fields in GROMACS and CHARMM (ParmEd)
It might be also a part of AmberTool22  
Ref: https://ambermd.org/parmed_gromacs.html   
Ref: https://github.com/ParmEd/ParmEd  
Jason Swails' parmed program can make this an easy task. The first thing you need to do is create your prmtop and inpcrd files using tleap. After that, run amber.python with the following code:
```
import parmed as pmd
parm = pmd.load_file('name-of-your.prmtop', 'name-of-your.rst7') 
    OR parm = pmd.load_file('name-of-your.prmtop', 'name-of-your.inpcrd')
parm.save('gromacs.top', format='gromacs')
parm.save('gromacs.gro')
```
Similar ideas work for CHARMM:
```
import parmed as pmd
parm = pmd.load_file('name-of-your.prmtop', 'name-of-your.inpcrd')
parm.save('charmm.psf')
parm.save('charmm.crd')
```
For more information, visit the ParmEd github page.

# ACPYPE
Ref: https://github.com/alanwilter/acpype
- Acype server
  Ref: https://www.bio2byte.be/acpype/
- 

# mmtools
Ref: https://github.com/choderalab/mmtools

# ffAmber
Ref: http://ffamber.cnsm.csulb.edu/ffamber.php
- Warning! AMBER conventions have been maintained where possible. However, due to specific GROMACS functionality this was not always feasible. 
