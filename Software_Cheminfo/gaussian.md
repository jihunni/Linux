# Gaussian
# Gaussian input preparation using Pymol and Avogadro 2
- Extract active site from native enzyme using `pymol`
  - Fetch a native enzyme and identify catalytic residues. 
  - Select the catalytic residues
  - Create the new molecule containing only the catalytic residues.
  - Export the molecule as a mol2 file.
- Prepare `Gaussian` input file using Avogardro 2
  - Load a mol2 file from Pymol
  - (optional) Change a pre-existing native ligand into a target ligand
    - Select the pre-existing ligand
    - Create a layer containing the pre-existing ligand : `Select` - `Create a new layer from selection`
    - Import the new target ligand and overlap it to the pre-existing ligand using `Layer` function
    - When the new target ligand is located on proper site correctly, then remove the native pre-existing ligand.
  - Add hydrogen : `build` - `hydrogens` - `add hydrogens`
    - Consider the hypothetical reaction mechanism.
  - Export a molecule in Gaussian input format : `Input` - `Gaussian`
    
# Run Gaussian
- gaussian input collection : [link](https://www.cup.uni-muenchen.de/ch/compchem/testindex.html)
- Orbital visualizaiton
  To visualize H2O orbitals using `ChemCraft`, note that "#P GFINPUT POP(FULL)" should be specified in an input file, so that the orbitals and basis set information are printed in the output file.
  h20.gjf
  ```
  %Chk=/home/jeung/Documents/gaussian/heavy.chk
  %mem=32GB
  #P GFINPUT b3lyp/6-311++G(d,p) scf=direct pop=full prop=fit
  !# opt freq b3lyp/6-311++G(d,p) Pop=reg FormCheck integral=ultrafine scf=maxcyc=1024
  
  water energy
  
  0   1
  O  -0.464   0.177   0.0	 
  H  -0.464   1.137   0.0	 
  H   0.441  -0.143   0.0
  
  1 2 3
  2 1
  3 1
  
  
  ```

  For additional basis set,
  ```
  # opt freq Gen Pseudo=Read

  (xyz)

  H C N O S
  B3LYP/6-31G(d)
  
  *****
  Fe 0
  LanL2DZ
  *****
  ```
  - In `ChemCraft`, [youtube](https://www.youtube.com/watch?v=plGKF0DBz9w&ab_channel=nicolasN)
## Trial and error
- No convergence (Ref : https://www.researchgate.net/post/How-can-I-resolve-the-convergence-failure-error-in-Gaussian-09) 
  - Edit the bad initial geometry
  - Use QM/MM method (ONIOM method)
  - increasing the number of scf cycles; scf=maxcycle = 1000
  - using quadratically convergent method; scf = qc
  - refining your starting structure (initial geometry)
  - trying the optimization at HF level, then using optimized structure as initial guess for B3LYP...
- 
# Gaussian output
## Visualization
- Avogardro 2   
  To convert `.chk` file into `.fchk` that is compatible to Avogardro 2,
  ```
  formchk [options] chkpt-file [formatted-file]
  e.g. formchk propell.chk propell.fchk
  ```
  where `chkpt-file` is the name of the binary checkpoint file to be formatted and `formatted-file` is the name for the resultant output file. If the name of the formatted file is omitted, it defaults to the base name of the checkpoint file with `.fchk`.
