# Software
## cheminformatics
- smina
- ADFR software suite
  Ref : https://ccsb.scripps.edu/adfr/downloads/
  Documentation : https://autodock-vina.readthedocs.io/_/downloads/en/latest/pdf/
  directory : /opt/ADFR_suite/1.0
  ```
  $ module load ADFR_suite
  ```
- 
# Anaconda3 Environment
- vina
  Ref : https://autodock-vina.readthedocs.io/_/downloads/en/latest/pdf/ 
  ```
  module load anaconda3
  conda create -c conda-forge -n vina rdkit
  conda activate vina
  conda install -c conda-forge numpy openbabel scipy rdkit
  pip install meeko
  ```
- 
