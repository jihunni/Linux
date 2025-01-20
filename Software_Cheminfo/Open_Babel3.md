# Open Babel 3 Install
Documentation : https://openbabel.org/docs/dev/Installation/install.html    
Source : https://github.com/openbabel/openbabel/releases  
## compiling from source file
Requirement : cmake, wxWidgets toolkit [link](https://github.com/jihunni/Linux/blob/master/Software_Cheminfo/wxWidgets.md)
```
$ tar zxf openbabel-2.3.1.tar.gz   # (this creates openbabel-2.3.1)
$ mkdir build
$ cmake ../openbabel-2.3.1  -DBUILD_GUI=ON #GUI
$ make -j24    # parallel build across 24 processors
```

## Conda
Ref : https://github.com/openbabel/conda-openbabel/issues/7
```
conda create openbabel -c conda-forge -n openbabel
```
## MacOS
```
$ brew install open-babel
$ brew install swig # for python-openbabel binding
$ brew edit open-babel # check the installation directory
$ vi ~/.bashrc
  export OPENBABEL_DIR="/opt/homebrew/Cellar/open-babel/3.1.1_2/"

# openbabel binding to python interpretator
$ python -m pip install --global-option=build_ext --global-option="-I$OPENBABEL_DIR/include/openbabel3" --global-option="-L$OPENBABEL_DIR/lib" openbabel
```
- Installation location : `/opt/homebrew/Cellar/open-babel/3.1.1_2/include/openbabel3/openbabel`
- Default binding python interpretator : `/opt/homebrew/Cellar/python@3.12/3.12.3/bin/python3`

# Trial and Error
- Failed to kekulize aromatic bonds in OBMol::PerceiveBondOrders   
  Ref : https://sourceforge.net/p/openbabel/mailman/openbabel-discuss/thread/A9E7F432-E248-4AE4-A289-AA8BA93A8B85@ebi.ac.uk/  
-  
