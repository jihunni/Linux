# Amber
Ref: https://ambermd.org/index.php
## Installation of AmberTool22 
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
parm = pmd.load_file('name-of-your.prmtop', 'name-of-your.inpcrd')
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

