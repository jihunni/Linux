# Gaussian
# Gaussian input preparation using Avogadro 2

# Gaussian input
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
