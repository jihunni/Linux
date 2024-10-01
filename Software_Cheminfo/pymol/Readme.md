# Install
- conda
  ```
  conda install -c conda-forge -c schrodinger pymol-bundle
  ```
- pymol remote
  ```
  pip install pymol-remote
  ```

# Pymol function
- renumber
  Ref: https://pymolwiki.org/index.php/Renumber   
  ```
  # renumber polymer, first 27 residues of Q8N2U3_HUMAN missing.
  renumber chain A, 28
  ```
