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
surn --pty bash #to access head node
exit # to exit the head node

salloc
sattach

sbcast
scancel [Job_ID]
scontrol show job [Job_ID]
strigger
strigger
sview

sstat



submit.sh
```
#!/bin/bash
#
#SBATCH --job-name=test
#SBATCH -J test

#SBATCH -p cas_v100_2 # 작업 수행할 partition을 지정
#SBATCH --partition=cas_v100_2

#SBATCH --acount=jihun

#

#SBATCH -N 2 # 총 필요한 컴퓨팅 노드 수
#SBATCH -n 2 #  작업 수행에 필요한 총 프로세스 수

#SBATCH --ntasks=1 # 총 필요한 프로세스 수

#SBATCH --time=01:30:00
#SBATCH -t 01:30:00

#SBATCH --mem-per-cpu=200

#SBATCH --output=res.txt
#SBATCH -o slurm-%j # stdout filename(.o)
#SBATCH -e %x.e%j #stderr filename(.e)
#SBATCH --gres=gpu:2 #GPU를 사용하기 위한 옵션

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

# How to use slurm?
```
$ sbatch fimo_slurm.sh 
Submitted batch job 6
```

```
#!/bin/bash
#
#SBATCH --job-name=fimo_oneExample
#
#SBATCH --account=jihun
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=jihun@gm.gist.ac.kr
#
#SBATCH --ntasks=1
#SBATCH --time=01:30:00
#SBATCH --output=slurm_result.txt
#SBATCH -o slurm-%j.o
#SBATCH -e %x.e%j.e
pwd; hostname; date

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"

module purge
module load MEME_Suite/5.4.1

~/data/motif/

date
```
