[command] --help
[command] --option

```
$ sinfo 
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
debug*       up   infinite      1   idle life1

$ sinfo -N -l
```


```
$ sacct
       JobID    JobName  Partition    Account  AllocCPUS      State ExitCode
------------ ---------- ---------- ---------- ---------- ---------- --------

```
smap
squeue -u jihun

sbatch
surn


salloc
sattach

sbcast
scancel
scontrol
strigger
strigger
sview

sstat



submit.sh
```
#!/bin/bash
#
#SBATCH --job-name=test
#SBATCH --acount=jihun
#SBATCH --output=res.txt
#
#SBATCH --ntasks=1
#SBATCH --time=60:00
#SBATCH --mem-per-cpu=200
#SBATCH -o slurm-%j #slurm std output

NAME
DATADIR

module purge # to clean up environment (delete all loaded environment)
module load [module_name]

srun hostname
srun sleep 60
```
only in slrum
%j : job_name
$SLURM_JOB_ID
```
Shell$ sbatch submit.sh
sbatch: Submitted batch job [jobID]
```
video : 
- https://www.youtube.com/watch?v=8N8gb4BSu_4
