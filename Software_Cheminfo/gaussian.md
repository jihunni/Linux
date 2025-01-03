# Gaussian
- Ref
  - https://math.nist.gov/mcsd/savg/tutorial/ex.html
  - https://www.cup.uni-muenchen.de/ch/compchem/topics.html
  - errir message handling : https://docs.alliancecan.ca/wiki/Gaussian_error_messages  
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
- keyword
  - Geometry optimization and frequency calculation : `Opt Freq`
    - `freq=noraman`
  - pseudopotential : `genECP`
  - Convergence : `SCF=XQC`
  - solvent : `SCRF=(CPCM,solvent=water)`
  - Take a previous checkpoint file : `Geom=Checkpoint Guess=Read`
  - Orbital visualizaiton : `GFINPUT POP(FULL)`
    To visualize H2O orbitals using `ChemCraft`, note that "#P GFINPUT POP(FULL)" should be specified in an input file, so that the orbitals and basis set information are printed in the output file.
- Synteax
  - Output options :
    - `#P`  will provide somewhat more detailed output
    - `#`    will provide normal output
    - `#T`  will provide somewhat less output
  - Use `!` for comment line
  - Total charge and spin multiplicity should be written accurately
  - Always add a few number of blank line at the end of job script.     
- Example
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
  # Opt Freq genECP

  ! xyz coordination [skipped]

  H C N O S
  B3LYP/6-31G(d)
  *****
  ! pseudopotential
  Fe 0
  SDD
  *****

  ! Basis set
  Fe 0  
  LanL2DZ
  
  ```
  - In `ChemCraft`, [youtube](https://www.youtube.com/watch?v=plGKF0DBz9w&ab_channel=nicolasN)
## Geometry optimization (`Opt`)
- Basic reference : https://www.cup.uni-muenchen.de/ch/compchem/geom/basic.html
- The optimization algorithm will vary the structure of the system until changes in the gradient and the structure on two successive iterations are smaller than prefixed values (convergence criteria). For each step of the geometry optimization, Gaussian will write to the output file a) the current structure of the system, b) the energy for this structure, c) the derivative of the energy with respect to the geometric variables (the gradients), and d) a summary of the convergence criteria.
- Optimization option
  - coordination system selection
    - `opt` or `opt=Redundant` will optimize the geometry in redundant internal coordinates (chosen automatically)
    - `opt=Cartesian` will optimize the geometry in Cartesian coordinates
    - `opt=Z-Matrix` will optimize the geometry in internal coordinates (as provided in the input file)

  - Convergence criteria selection
    - Using `opt` keyword
      - `opt` without any additional information sets the RMS force criterion to 3*10-4
      - `opt=tight` will set the RMS force criterion to 1*10-5 and scale the other three criteria accordingly
      - `opt=verytight` will set the RMS force criterion to 1*10-6 and scale the other three criteria accordingly
    - Using the IOP keyword (Internal Option)
      - iop(1/7=x) will set the RMS force criterion to x*10-6 and scale the other three criteria accordingly. Thus, using iop(1/7=10) one can obtain the same final result as with `opt=tight`.
  - Set the maximum number of optimization cycles : `opt=(maxcycles=n)` 
    - Choosing tighter convergence criteria will, of course, give improved results, but will also need more computer time. The default settings are appropriate for small systems. Especially for large structures, however, convergence of the last two criteria can be very slow and it is sometimes advisable to stop optimizations before all four criteria are fulfilled. The maximum number of optimization cycles depends on the size of the system and is automatically adjusted by Gaussian. If a particular setting of optimization cycles is desired, however, this can be specified using `opt=(maxcycles=n)`. The default optimization algorithm included in Gaussian is the "Berny algorithm" developed by Bernhard Schlegel. This algorithm uses the forces acting on the atoms of a given structure together with the second derivative matrix (called the Hessian matrix) to predict energetically more favorable structures and thus optimize the molecular structure towards the next local minimum on the potential energy surface. As explicit calculation of the second derivative matrix is quite costly, the Berny algorithm constructs an approximate Hessian at the beginning of the optimization procedure through application of a simple valence force field, and then uses the energies and first derivatives calculated along the optimization pathway to update this approximate Hessian matrix. The success of the optimization procedure therefore depends to some degree on how well the approximate Hessian represents the true situation at a given point. For many "normal" systems, the approximate Hessians work quite well, but in a few cases a better Hessian has to be used. Often it is sufficient to calculate the Hessian matrix explicitly once at the beginning of the calculation and then use the standard updating scheme of the Berny algorithm. This is specified using the `opt=calcfc` keyword. In some very rare cases, the Hessian changes considerably between optimization steps and must then be recomputed after each optimization step using the `opt=calcall` keyword.
  - Optimization algorithm selection
    - Berny algorithm : This algorithm uses the forces acting on the atoms of a given structure together with the second derivative matrix (called the Hessian matrix) to predict energetically more favorable structures and thus optimize the molecular structure towards the next local minimum on the potential energy surface. As explicit calculation of the second derivative matrix is quite costly, the Berny algorithm constructs an approximate Hessian at the beginning of the optimization procedure through application of a simple valence force field, and then uses the energies and first derivatives calculated along the optimization pathway to update this approximate Hessian matrix. The success of the optimization procedure therefore depends to some degree on how well the approximate Hessian represents the true situation at a given point.
    -  For many "normal" systems, the approximate Hessians work quite well, but in a few cases a better Hessian has to be used. Often it is sufficient to calculate the Hessian matrix explicitly once at the beginning of the calculation and then use the standard updating scheme of the Berny algorithm. This is specified using the `opt=calcfc` keyword.
    -  In some very rare cases, the Hessian changes considerably between optimization steps and must then be recomputed after each optimization step using the `opt=calcall` keyword.
  -  To set the multiple options, these options must be given in parenthesis : `opt=(Z-Matrix,calcfc,tight,maxcycles=25)`

## Scanning Potential Energy Surface
Ref : http://www.jamberoo.org/gaussian/ts/scanning-pes.html


## Trial and error
- No convergence   
  Ref : https://www.researchgate.net/post/How-can-I-resolve-the-convergence-failure-error-in-Gaussian-09   
  Ref : https://wongzit.github.io/method-to-solve-the-scf-not-converged/   
  - Edit the bad initial geometry
  - Use QM/MM method (ONIOM method)
  - increasing the number of scf cycles; scf=maxcycle = 1000
  - using quadratically convergent method; scf = qc
  - refining your starting structure (initial geometry)
  - trying the optimization at HF level, then using optimized structure as initial guess for B3LYP...
- error in internal coordinate
  Ref : https://www.researchgate.net/post/How_to_solve_the_error_in_internal_coordinate_in_Gaussian_09
  - Use cartesian coordinate, instead of internal coordinate, by specifying `opt=cartesian`
# Gaussian output
- Unit : atomic units (au, *Hatree*)
  - 1 Hartree = 627.15 kcal/mol
  - 1 Hartree = 2625.5 kJ/mol
  - 1 Hartree = 27.2116 eV
  - 1 Hartree = 4.3597482*10-18 J/particle
## Visualization
- Avogardro 2   
  To convert `.chk` file into `.fchk` that is compatible to Avogardro 2,
  ```
  formchk [options] chkpt-file [formatted-file]
  e.g. formchk propell.chk propell.fchk
  ```
  where `chkpt-file` is the name of the binary checkpoint file to be formatted and `formatted-file` is the name for the resultant output file. If the name of the formatted file is omitted, it defaults to the base name of the checkpoint file with `.fchk`.
