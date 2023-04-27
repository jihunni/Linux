# File system structure
```
0. split_sdf structure  
slurm_array_control.sh
	└split_sdf_slurm.sh  
		└split_sdf_assign_taskID.sh  
			└python check_conda.py  
			└python split_sdf.py ${SLURM_ARRAY_TASK_ID}  

0. run_vina structure  
run_vina_slurm.sh  
	└run_vina.sh  
		└python check_conda.py  
		└python gpf_to_config.py  
		└python input_to_PostgreSQL.py  
		└python slack_message.py  
```


# AutoDock Vina
- AutoDock
  Ref : https://vina.scripps.edu/manual/#linux
- AutoDock Vina
  Ref : https://vina.scripps.edu/manual  
  - Python library vina
    ```
    $ conda create -n vina python=3
    $ conda activate vina
    $ conda config --env --add channels conda-forge
    $ conda install -c conda-forge numpy swig boost-cpp sphinx sphinx_rtd_theme
    $ pip install vina
    ```
  - vina
    Dependency : ADFRSuite, Meeko  
    Ref : 
    - source & Git code
      ```
      ```
      ```
      set version     1.1.2

      prepend-path    PATH    /opt/autodock_vina/1.1.2/bin
      prepend-path    PATH    /opt/autodock_vina/AutoDock-Vina-develop/example/autodock_scripts

      ```
    - To install ADFRsuite
      code is changed in `/opt/ADFR_suite/ADFRsuite_x86_64Linux_1.0/CCSBpckgs/AutoDockTools/GridParameters.py`   
      `self.receptor = Read(receptor_filename)[0]` is changed into `self.receptor = receptor_filename`
      ```
      def set_receptor4(self, receptor_filename, types=None):
        #this should set receptor_types
        ftype = os.path.splitext(receptor_filename)[-1]
        if ftype!=".pdbqt":
            print "receptor_filename must be in pdbqt format"
            return "invalid input"
        # print("receptor_filename: ", receptor_filename)
        # print("Read(receptor_filename)[0]: ", Read(receptor_filename)[0])
        self.receptor = receptor_filename
        receptor = self.receptor
        if types is None:
            types = " ".join(list(set(receptor.allAtoms.autodock_element)))
        self['receptor_types']['value'] = types
        basename = os.path.basename(receptor_filename)
        self.receptor_filename = basename
        self.receptor_stem = os.path.splitext(basename)[0]
        if receptor_filename!='':
            self['receptor']['value'] = basename
            self['gridfld']['value'] = self.receptor_stem + '.maps.fld'
            self['elecmap']['value'] = self.receptor_stem + '.e.map'
            self['dsolvmap']['value'] = self.receptor_stem + '.d.map' 
      ```
    
    - To install OpenBabel
      ref: https://open-babel.readthedocs.io/en/latest/Installation/install.html#install-binaries
      ```
      cmake ../ -DCMAKE_INSTALL_PREFIX=/opt/open_babel/3.1.1
      make -j10
      make install
      ```
    - 3rd party software
      ```
       # to install Meeko
       pip install -U numpy openbabel meeko
       conda install -c openbabel openbabel
      ```
    
- MGLTools
  Ref : https://ccsb.scripps.edu/mgltools/downloads/
- Open Babel
  Ref : https://open-babel.readthedocs.io/en/latest/Installation/install.html#install-binaries  
  Source : https://github.com/openbabel/openbabel/releases  
- smina (centos7)
  Ref : https://sourceforge.net/projects/smina/
  cmake  
  yum install eigen3-devel  
  yum install gcc gcc-c++ kernel-devel mak  
  
  ```
  apt install git libboost-all-dev libopenbabel-dev build-essential libeigen3-dev
  git clone https://git.code.sf.net/p/smina/code smina-code
  cd smina-code
  mkdir build
  cd build
  cmake ..
  make -j12
  ```
