# Gaussian
# Gaussian input
## water
To visualize H2O orbitals using `ChemCraft`,
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
