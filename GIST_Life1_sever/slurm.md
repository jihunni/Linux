# Overview
## command manual
[command] --help
[command] --option

## computing status
```
$ sinfo 
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
debug*       up   infinite      1   idle life1

$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             194_0     debug slurm_ar    jihun  R      25:03      1 life1
             194_1     debug slurm_ar    jihun  R      25:03      1 life1
             194_2     debug slurm_ar    jihun  R      25:03      1 life1
```
 

## run slurm
```
sbatch submit.sh
```

# running example : Basic, Single-Threaded Job
Ref : https://help.rc.ufl.edu/doc/Sample_SLURM_Scripts  
Ref : https://repository.kisti.re.kr/bitstream/10580/6542/1/2014-147%20Slurm%20%EA%B4%80%EB%A6%AC%EC%9E%90%20%EC%9D%B4%EC%9A%A9%EC%9E%90%20%EA%B0%80%EC%9D%B4%EB%93%9C.pdf  
Ref (ntask vs cpu-per-task) : https://stackoverflow.com/questions/51139711/hpc-cluster-select-the-number-of-cpus-and-threads-in-slurm-sbatch  
video : 
- https://www.youtube.com/watch?v=8N8gb4BSu_4

## general_execution.sh
```
#!/bin/bash

# set the directory
INPUT_DIRECTORY=~/home/jihun/data/input_${SLURM_ARRAY_TASK_ID}/
OUTPUT_DIRECTORY=~/home/data/output_${SLURM_ARRAY_TASK_ID}/
SHARED_DATA=/home/data/...

# execute the program
main () {
command ${INPUT_DIRECTORY} ${OUTPUT_DIRECTORY}
}

# To measure the time for running the program
time main

echo "finish"
```

## example_execution.sh
```
echo "SLUM_ARRAY_TASK_ID : ${SLURM_ARRAY_TASK_ID}"

# execute FIMO
## set the directory
MOTIF_FILE=~/python/tfmotif_split/TRANSFAC_tfmatrix_human_MEME_${SLURM_ARRAY_TASK_ID}.txt
OUTPUT_DIRECTORY=~/data/motif/fimo_${SLURM_ARRAY_TASK_ID}/
SEQUENCE_FILE=/home/data/ref_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa

## run fimo
fimo --qv-thresh --oc ${OUTPUT_DIRECTORY} ${MOTIF_FILE} ${SEQUENCE_FILE}

# declare the termination of a program
echo "finish"
```

## general_submit.sh
submit.sh
```
#!/bin/bash
either of one
#SBATCH --job-name=[job_name]
#SBATCH -J [job_name]
작업 수행할 partition을 지정 (either of one)
#SBATCH -p debug 
#SBATCH --partition=debug
#
#SBATCH --acount=[userID]
#
#SBATCH -N [# Node to compute]
#SBATCH -n [# Total number of process]
#SBATCH --ntasks= [# total number of prcess] (in case of array, per each one sub-script)
>> Total process usage (in case of array, per each one sub-script) = 12
>> The number of process in a node = 12 / 3 = 4
#
#SBATCH --mem-per-cpu=[2000]
#SBATCH --mem-per-cpu=[2G]
#
#SBATCH --time=[hh:mm:ss]
#SBATCH -t [hh:tt:ss]
#
#SBATCH --output=[output_filename]
#SBATCH -o slurm-%j # stdout filename(.o)
#SBATCH -e %x.e%j #stderr filename(.e)
#SBATCH --gres=gpu:2 #GPU를 사용하기 위한 옵션

# stdout : basic info
echo "SLURM running info"
echo "Start Time        = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"

# load module
module purge # to clean up environment (delete all loaded environment)
module load [module_name]

# run a single thread program
~/data/motif/slurm_array/fimo.sh
sleep 1 # pause to be kind to the scheduler

# run parallel program
srun sleep 60


echo "Finish Time       = $(date)"
```
only in slrum
%j : job_name

$SLURM_JOB_ID
```
Shell$ sbatch submit.sh
sbatch: Submitted batch job [jobID]
```

## example
```
#!/bin/bash
#
#SBATCH --job-name=slurm_array_example
#
#SBATCH --account=jihun
#
#SBATCH --ntasks=1
#SBATCH --array=0-2
#SBATCH --cpus-per-task=1
#SBATCH --mem 1G
#SBATCH --time=01:00:00
#SBATCH --output=slurm_result_%j.txt
#SBATCH -o %x_%A.o%j
#SBATCH -e %x_%A.e%j

# stdout : basic info
echo "SLURM running info"
echo "Start Time        = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"

# load module
module purge
module load MEME_Suite/5.4.1

# run a program
~/data/motif/slurm_array/fimo.sh
sleep 1 # pause to be kind to the scheduler

echo "Finish Time       = $(date)"
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

less fimo_oneExample.e7
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
