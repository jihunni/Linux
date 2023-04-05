# Install (on Ubuntu)
Ref (Youtube): https://www.youtube.com/watch?v=UEaFmUMEL9c&ab_channel=SariSabban
Ref: https://www.pyrosetta.org/downloads#h.6vttn15ac69d  
```
$ tar -vjxf [pyrosetta.tar.bz2]
$ mv [pyrosetta] [directory_name] # change the directory name before compiling
Virtual environment
$ python3 PyRosetta/setup/setup.py install
```
```
$ tar -vjxf PyRosetta4.Release.python310.ubuntu.release-333.tar.bz2
$ mv PyRosetta4.Release.python310.ubuntu.release-333 py310.333
$ conda activate pyrosetta.py310.333
```
To test
vi test.py
```
from pyrosetta import *
init()
```
