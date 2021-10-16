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
> option :  
> - %A_%a.out", "%A" is replaced by the job ID and 
> - "%a" is replaced by the array index.
> "%j" is replaced by the job ID
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

srun hostnamehttps://stackoverflow.com/questions/51139711/hpc-cluster-select-the-number-of-cpus-and-threads-in-slurm-sbatch
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
Ref : https://help.rc.ufl.edu/doc/Sample_SLURM_Scripts  
Ref : https://repository.kisti.re.kr/bitstream/10580/6542/1/2014-147%20Slurm%20%EA%B4%80%EB%A6%AC%EC%9E%90%20%EC%9D%B4%EC%9A%A9%EC%9E%90%20%EA%B0%80%EC%9D%B4%EB%93%9C.pdf  
Ref (ntask vs cpu-per-task) : https://stackoverflow.com/questions/51139711/hpc-cluster-select-the-number-of-cpus-and-threads-in-slurm-sbatch  

Basic, Single-Threaded Job
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
#SBATCH --cpus-per-task=8
#SBATCH --time=01:30:00 
              # maximum time for each subtask
#SBATCH --output=slurm_result.txt
#SBATCH -o %x.o%j
#SBATCH -e %x.e%j

# stdout : basic info
echo "SLURM running info"
echo "Start Time        = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"

module purge
module load MEME_Suite/5.4.1

~/data/motif/fimo.sh
```

```
$ sbatch fimo_slurm.sh 
Submitted batch job 6

$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
                 7     debug fimo_one    jihun  R       0:03      1 life1
```

slurm stdout contains the output from `slurm.sh`. slurm stderr contains the output from the inner program.  
slurm-7.o
```
2021. 10. 15. (금) 21:23:53 KST
Date              = 2021. 10. 15. (금) 21:23:53 KST
Hostname          = life1
Working Directory = /home/jihun/data/motif

Number of Nodes Allocated      = 1
Number of Tasks Allocated      = 1
Number of Cores/Task Allocated = 
finish
2021. 10. 15. (금) 21:47:06 KST
```

less fimo_oneExample.e7.e 
```
Using motif +V_MYOD_01 of width 12.
Using motif -V_MYOD_01 of width 12.
Warning: Reached max stored scores (100000).
Motif matches with p-value >= 5.3e-05 have been dropped to reclaim memory.
Warning: Reached max stored scores (100000).
Motif matches with p-value >= 2.6e-05 have been dropped to reclaim memory.
Warning: Reached max stored scores (100000).
Motif matches with p-value >= 1.2e-05 have been dropped to reclaim memory.
Warning: Reached max stored scores (100000).
Motif matches with p-value >= 5.6e-06 have been dropped to reclaim memory.
Computing q-values.
# Computing q-values.
#   Estimating pi_0 from a uniformly sampled set of 10000 p-values.
#   Estimating pi_0.
# Minimal pi_zero = 0.996754
#   Estimated pi_0=0.999296
```


# Administration
```
# less /var/log/slurmd.log
[2021-10-15T21:23:53.181] _run_prolog: run job script took usec=4
[2021-10-15T21:23:53.182] _run_prolog: prolog with lock for job 7 ran for 0 seconds
[2021-10-15T21:23:53.182] Launching batch job 7 for UID 1003
[2021-10-15T21:23:53.208] [7.batch] task/cgroup: /slurm/uid_1003/job_7: alloc=0MB mem.limit=514401MB memsw.limit=514401MB
[2021-10-15T21:23:53.214] [7.batch] task/cgroup: /slurm/uid_1003/job_7/step_batch: alloc=0MB mem.limit=514401MB memsw.limit=514401MB
```
```
# scontrol show node
NodeName=life1 Arch=x86_64 CoresPerSocket=8 
   CPUAlloc=8 CPUTot=16 CPULoad=0.98
   AvailableFeatures=(null)
   ActiveFeatures=(null)
   Gres=(null)
   NodeAddr=life1 NodeHostName=life1 Version=19.05.8
   OS=Linux 3.10.0-1160.el7.x86_64 #1 SMP Mon Oct 19 16:18:59 UTC 2020 
   R#SBATCH ealMemory=514401 AllocMem=0 FreeMem=173801 Sockets=2 Boards=1
   State=MIXED ThreadsPerCore=1 TmpDisk=0 Weight=1 Owner=N/A MCS_label=N/A
   Partitions=debug 
   BootTime=2021-06-16T16:23:36 SlurmdStartTime=2021-06-16T16:23:53
   CfgTRES=cpu=16,mem=514401M,billing=16
   AllocTRES=cpu=8
   CapWatts=n/a
   CurrentWatts=0 AveWatts=0
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s

# squeue -o"%.7i %.9P %.8j %.8u %.2t %.10M %.6D %C"
  JOBID PARTITION     NAME     USER ST       TIME  NODES CPUS
      8     debug fimo_one    jihun  R      21:38      1 8

# sinfo --Node --long
Fri Oct 15 22:22:24 2021
NODELIST   NODES PARTITION       STATE CPUS    S:C:T MEMORY TMP_DISK WEIGHT AVAIL_FE REASON              
life1          1    debug*       mixed   16    2:8:1 514401        0      1   (null) none                

```
