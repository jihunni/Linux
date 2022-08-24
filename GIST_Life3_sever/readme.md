# Welcome to Life Server 3 Guide (TBD)
- [data](https://github.com/jihunni/Linux/blob/master/GIST_Life3_sever/data.md) : a list of available data in Life1 sever and their directory. A file with big volume, such as reference genome, sholud be shared for efficient disk usage.
- [slurm](https://github.com/jihunni/Linux/blob/master/GIST_Life1_sever/slurm.md) : an introduction to use a job scheduler `slurm`
- [software](https://github.com/jihunni/Linux/blob/master/GIST_Life3_sever/software.md) : a list of avaiable softwares in Life sever and their brief description.

# Life3 sever Policy
  - priority:
    1. system administration
    2. ML/DL
    3. slurm
    4. general program  
       **warning!** a general program that interrupts slurm would be killed by system mamger without any notification beforehand.

# ML/DL environment
```
# To access RDKit on python environment, run these codes on linux shell
(local)$ ssh -X xxx.xx.xx.73
(Life3)$ module load anaconda3
(Life3)$ conda activate pytorch
(Life3)$ jupyter-lab --no-browser

# To access Tensorboard,
(Life3)$ tensorboard --logdir=runs --port=assigned_port (e.g. 0000)
(local) allow firewall to tcp protocol 0000 (or different one)
(local)$ ssh -L 0000:localhost:0000 jihun@xxx.xx.xx.73
(local) http://localhost:xxxx/ 

# In jupyter notebook consol,
import rdkit
Contact : Jihun Jeung (jihun@gm.gist.ac.kr)
```
