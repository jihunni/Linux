# Amber
Ref: https://ambermd.org/index.php
## Installation of AmberTool22 
- Conda (w/o GPU or multi-parallelization)
- Binary ()
## ANTECHAMBER & GAFF : they became a part of AmberTool22
Ref: http://ambermd.org/antechamber/antechamber.html  
Ref: http://ambermd.org/antechamber/ac.html  
Tutorial : http://ambermd.org/tutorials/basic/tutorial4b/  

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

