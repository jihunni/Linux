# Overview
## command manual
[command] --help
[command] --option

## computer status
```
$ sinfo 
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
debug*       up   infinite      1   idle life1

$ sinfo -N -l

$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             194_0     debug slurm_ar    jihun  R      25:03      1 life1
             194_1     debug slurm_ar    jihun  R      25:03      1 life1
             194_2     debug slurm_ar    jihun  R      25:03      1 life1
```


```
$ sacct
       JobID    JobName  Partition    Account  AllocCPUS      State ExitCode
------------ ---------- ---------- ---------- ---------- ---------- --------

```
smap  
squeue -u jihun  

scancel   
Ref: https://slurm.schedmd.com/job_array.html
```
# Cancel array ID 1 to 3 from job array 20
$ scancel 20_[1-3]

# Cancel array ID 4 and 5 from job array 20
$ scancel 20_4 20_5

# Cancel all elements from job array 20
$ scancel 20

# Cancel the current job or job array element (if job array)
if [[-z $SLURM_ARRAY_JOB_ID]]; then
  scancel $SLURM_JOB_ID
else
  scancel ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}
fi
```

check PID
```
$ scontrol listpids
PID      JOBID    STEPID LOCALID GLOBALID
166396   580      batch  0       0       
166461   580      batch  -       -       
166433   582      batch  0       0       
166510   582      batch  -       -       
166477   584      batch  0       0       
166536   584      batch  -       -       
166519   586      batch  0       0       
166583   586      batch  -       -       
81036    599      batch  0       0       
81047    599      batch  -       -       
7098     592      batch  0       0       
7109     592      batch  -       -       
26688    593      batch  0       0       
26699    593      batch  -       -       
```

## run slurm
sbatch
> option :  
> - %A_%a.out", "%A" is replaced by the job ID and 
> - "%a" is replaced by the array index.
> "%j" is replaced by the job ID
surn --pty bash #to access head node
exit # to exit the head node


## the others:
salloc
sattach
sbcast
scancel [Job_ID]
scontrol show job [Job_ID]
strigger
strigger
sview
sstat

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
INPUT_DIRECTORY=~/data/input_${SLURM_ARRAY_TASK_ID}/
OUTPUT_DIRECTORY=~/data/output_${SLURM_ARRAY_TASK_ID}/

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
#!/bin/bash

#load module
module load MEME_Suite/5.4.1

echo "SLUM_ARRAY_TASK_ID : ${SLURM_ARRAY_TASK_ID}"

# execute FIMO
main () {
## set the directory
if (( ${SLURM_ARRAY_TASK_ID} < 10 )); then
        MOTIF_FILE=~/python/tfmotif_split/TRANSFAC_tfmatrix_human_MEME_00${SLURM_ARRAY_TASK_ID}.txt
        OUTPUT_DIRECTORY=~/data/motif/fimo_00${SLURM_ARRAY_TASK_ID}/
elif (( ${SLURM_ARRAY_TASK_ID} < 100 )); then
        MOTIF_FILE=~/python/tfmotif_split/TRANSFAC_tfmatrix_human_MEME_0${SLURM_ARRAY_TASK_ID}.txt
        OUTPUT_DIRECTORY=~/data/motif/fimo_0${SLURM_ARRAY_TASK_ID}/
else
        MOTIF_FILE=~/python/tfmotif_split/TRANSFAC_tfmatrix_human_MEME_${SLURM_ARRAY_TASK_ID}.txt
        OUTPUT_DIRECTORY=~/data/motif/fimo_${SLURM_ARRAY_TASK_ID}/
fi
SEQUENCE_FILE=/home/data/ref_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa

## run fimo
fimo --qv-thresh --oc ${OUTPUT_DIRECTORY} ${MOTIF_FILE} ${SEQUENCE_FILE}
}

time main

# unload module
module unload MEME_Suite/5.4.1
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
#SBATCH --mail-user=[email_address]
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=REQUEUE
#SBATCH --mail-type=ALL
#
#SBATCH -N [# Node to compute]
#SBATCH -n [# Total number of process]
#SBATCH --ntasks= [# total number of prcess] (in case of array, per each one sub-script)
>> Total process usage (in case of array, per each one sub-script) = 12
>> The number of process in a node = 12 / 3 = 4
#
#SBATCH --mem-per-cpu=[2000]
#SBATCH --mem-per-cpu=[2G]
#SBATCH -a / --array=[0-1000]
#
#SBATCH --time=[hh:mm:ss] / "UNLIMITED"
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

##############################
# Run HMMRATAC
# input : $PWD/data/sample.bam, $PWD/data/sample.bami (filtered and sorted)
# output : $PWD/HMMRATAC/prefix_{something}
##############################
#
#SBATCH --job-name=slurm_array_example
#
#SBATCH --account=jihun
#
#SBATCH --mail-user=jihun@gm.gist.ac.kr
#SBATCH --mail-type=BEGIN,FAIL,END
#
#SBATCH --ntasks=1
#SBATCH --array=0-2
#SBATCH --cpus-per-task=1
#SBATCH --mem 4G
#SBATCH --time=24:00:00
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
module load anaconda3/2021.05

# to activate python environment
source /opt/anaconda3/2021.05/etc/profile.d/conda.sh
source activate /opt/anaconda3/2021.05/envs/vina
export PATH=/opt/anaconda3/2021.05/envs/vina/bin:$PATH # for Pip directory

# export environment variable

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


## update
ref: https://stackoverflow.com/questions/28413418/adding-time-to-a-running-slurm-job  
Use the scontrol command to modify a job  
```
scontrol update jobid=<job_id> TimeLimit=<new_timelimit>
```

# Administration
slurm configuration : /etc/slurm/


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
## slurm DB
DB configuration : /etc/slurm/slurmdbd.conf
```
AuthType=auth/munge
AuthInfo=/var/run/munge/munge.socket.2

DbdAddr=localhost
DbdHost=localhost
SlurmUser=slurm
DebugLevel=4
LogFile=/var/log/slurm/slurmdbd.log
PidFile=/var/run/slurmdbd.pid

# Database info
StorageType=accounting_storage/mysql
StorageHost=localhost
StoragePass=1234
StorageUser=slurm
StorageLoc=slurm_acct_db
```

```
# mysql
MariaDB [(none)]> use slurm_acct_db;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
MariaDB [slurm_acct_db]> show tables;
+-------------------------+
| Tables_in_slurm_acct_db |
+-------------------------+
| acct_coord_table        |
| acct_table              |
| clus_res_table          |
| cluster_table           |
| convert_version_table   |
| federation_table        |
| qos_table               |
| res_table               |
| table_defs_table        |
| tres_table              |
| txn_table               |
| user_table              |
+-------------------------+

MariaDB [slurm_acct_db]> SHOW TABLE STATUS IN slurm_acct_db;
+-----------------------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+-------------------+----------+----------------+---------+
| Name                  | Engine | Version | Row_format | Rows | Avg_row_length | Data_length | Max_data_length | Index_length | Data_free | Auto_increment | Create_time         | Update_time | Check_time | Collation         | Checksum | Create_options | Comment |
+-----------------------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+-------------------+----------+----------------+---------+
| acct_coord_table      | InnoDB |      10 | Compact    |    0 |              0 |       16384 |               0 |        16384 |   9437184 |           NULL | 2021-05-25 13:49:18 | NULL        | NULL       | latin1_swedish_ci |     NULL |                |         |
| acct_table            | InnoDB |      10 | Compact    |    1 |          16384 |       16384 |               0 |            0 |   9437184 |           NULL | 2021-05-25 13:49:18 | NULL        | NULL       | latin1_swedish_ci |     NULL |                |         |
| clus_res_table        | InnoDB |      10 | Compact    |    0 |              0 |       16384 |               0 |        16384 |   9437184 |           NULL | 2021-05-25 13:49:18 | NULL        | NULL       | latin1_swedish_ci |     NULL |                |         |
| cluster_table         | InnoDB |      10 | Compact    |    0 |              0 |       16384 |               0 |            0 |   9437184 |           NULL | 2021-05-25 13:49:18 | NULL        | NULL       | latin1_swedish_ci |     NULL |                |         |
| convert_version_table | InnoDB |      10 | Compact    |    1 |          16384 |       16384 |               0 |            0 |   9437184 |           NULL | 2021-05-25 13:49:18 | NULL        | NULL       | latin1_swedish_ci |     NULL |                |         |
| federation_table      | InnoDB |      10 | Compact    |    0 |              0 |       16384 |               0 |            0 |   9437184 |           NULL | 2021-05-25 13:49:18 | NULL        | NULL       | latin1_swedish_ci |     NULL |                |         |
| qos_table             | InnoDB |      10 | Compact    |    1 |          16384 |       16384 |               0 |        16384 |   9437184 |              3 | 2021-05-25 13:49:18 | NULL        | NULL       | latin1_swedish_ci |     NULL |                |         |
| res_table             | InnoDB |      10 | Compact    |    0 |              0 |       16384 |               0 |        16384 |   9437184 |              1 | 2021-05-25 13:49:18 | NULL        | NULL       | latin1_swedish_ci |     NULL |                |         |
| table_defs_table      | InnoDB |      10 | Compact    |   11 |           1489 |       16384 |               0 |            0 |   9437184 |           NULL | 2021-05-25 13:49:18 | NULL        | NULL       | latin1_swedish_ci |     NULL |                |         |
| tres_table            | InnoDB |      10 | Compact    |    9 |           1820 |       16384 |               0 |        16384 |   9437184 |           1001 | 2021-05-25 13:49:18 | NULL        | NULL       | latin1_swedish_ci |     NULL |                |         |
| txn_table             | InnoDB |      10 | Compact    |    0 |              0 |       16384 |               0 |            0 |   9437184 |              1 | 2021-05-25 13:49:18 | NULL        | NULL       | latin1_swedish_ci |     NULL |                |         |
| user_table            | InnoDB |      10 | Compact    |    1 |          16384 |       16384 |               0 |            0 |   9437184 |           NULL | 2021-05-25 13:49:18 | NULL        | NULL       | latin1_swedish_ci |     NULL |                |         |
+-----------------------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+-------------------+----------+----------------+---------+
12 rows in set (0.00 sec)


MariaDB [slurm_acct_db]> SELECT * FROM acct_coord_table;
Empty set (0.00 sec)

MariaDB [slurm_acct_db]> SELECT * FROM acct_table;
+---------------+------------+---------+------+----------------------+--------------+
| creation_time | mod_time   | deleted | name | description          | organization |
+---------------+------------+---------+------+----------------------+--------------+
|    1621918158 | 1621918158 |       0 | root | default root account | root         |
+---------------+------------+---------+------+----------------------+--------------+
1 row in set (0.00 sec)

MariaDB [slurm_acct_db]> SELECT * FROM clus_res_table;
Empty set (0.00 sec)

MariaDB [slurm_acct_db]> SELECT * FROM cluster_table;
Empty set (0.00 sec)

MariaDB [slurm_acct_db]> SELECT * FROM convert_version_table;
+------------+---------+
| mod_time   | version |
+------------+---------+
| 1621918158 |       7 |
+------------+---------+
1 row in set (0.00 sec)

MariaDB [slurm_acct_db]> SELECT * FROM federation_table;
Empty set (0.00 sec)

MariaDB [slurm_acct_db]> SELECT * FROM qos_table;
+---------------+------------+---------+----+--------+--------------------+-------+------------+-------------+-------------------+--------------------+--------------------+-----------------+--------------------+--------------------------+-------------+-------------+-------------+-------------+------------------+----------------------+----------------------+-------------+---------------------------+----------+-----------------+-----------------+----------+---------------+-------------------+----------+---------+--------------+---------------------+----------+--------------+-------------+
| creation_time | mod_time   | deleted | id | name   | description        | flags | grace_time | max_jobs_pa | max_jobs_per_user | max_jobs_accrue_pa | max_jobs_accrue_pu | min_prio_thresh | max_submit_jobs_pa | max_submit_jobs_per_user | max_tres_pa | max_tres_pj | max_tres_pn | max_tres_pu | max_tres_mins_pj | max_tres_run_mins_pa | max_tres_run_mins_pu | min_tres_pj | max_wall_duration_per_job | grp_jobs | grp_jobs_accrue | grp_submit_jobs | grp_tres | grp_tres_mins | grp_tres_run_mins | grp_wall | preempt | preempt_mode | preempt_exempt_time | priority | usage_factor | usage_thres |
+---------------+------------+---------+----+--------+--------------------+-------+------------+-------------+-------------------+--------------------+--------------------+-----------------+--------------------+--------------------------+-------------+-------------+-------------+-------------+------------------+----------------------+----------------------+-------------+---------------------------+----------+-----------------+-----------------+----------+---------------+-------------------+----------+---------+--------------+---------------------+----------+--------------+-------------+
|    1621918158 | 1621918158 |       0 |  1 | normal | Normal QOS default |     0 |       NULL |        NULL |              NULL |               NULL |               NULL |            NULL |               NULL |                     NULL |             |             |             |             |                  |                      |                      |             |                      NULL |     NULL |            NULL |            NULL |          |               |                   |     NULL |         |            0 |                NULL |        0 |            1 |        NULL |
+---------------+------------+---------+----+--------+--------------------+-------+------------+-------------+-------------------+--------------------+--------------------+-----------------+--------------------+--------------------------+-------------+-------------+-------------+-------------+------------------+----------------------+----------------------+-------------+---------------------------+----------+-----------------+-----------------+----------+---------------+-------------------+----------+---------+--------------+---------------------+----------+--------------+-------------+
1 row in set (0.00 sec)

MariaDB [slurm_acct_db]> SELECT * FROM res_table;
Empty set (0.00 sec)

MariaDB [slurm_acct_db]> SELECT * FROM table_defs_table;
+---------------+------------+-----------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| creation_time | mod_time   | table_name            | definition                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
+---------------+------------+-----------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|    1621918158 | 1621918158 | acct_coord_table      | alter table acct_coord_table modify `creation_time` bigint unsigned not null, modify `mod_time` bigint unsigned default 0 not null, modify `deleted` tinyint default 0, modify `acct` tinytext not null, modify `user` tinytext not null, drop primary key, add primary key (acct(42), user(42)), drop key user, add key user (user(42));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|    1621918158 | 1621918158 | acct_table            | alter table acct_table modify `creation_time` bigint unsigned not null, modify `mod_time` bigint unsigned default 0 not null, modify `deleted` tinyint default 0, modify `name` tinytext not null, modify `description` text not null, modify `organization` text not null, drop primary key, add primary key (name(42));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|    1621918158 | 1621918158 | cluster_table         | alter table cluster_table modify `creation_time` bigint unsigned not null, modify `mod_time` bigint unsigned default 0 not null, modify `deleted` tinyint default 0, modify `name` tinytext not null, modify `control_host` tinytext not null default '', modify `control_port` int unsigned not null default 0, modify `last_port` int unsigned not null default 0, modify `rpc_version` smallint unsigned not null default 0, modify `classification` smallint unsigned default 0, modify `dimensions` smallint unsigned default 1, modify `plugin_id_select` smallint unsigned default 0, modify `flags` int unsigned default 0, modify `federation` tinytext not null, modify `features` text not null default '', modify `fed_id` int unsigned default 0 not null, modify `fed_state` smallint unsigned not null, drop primary key, add primary key (name(42));                                                                                                                                                                                             |
|    1621918158 | 1621918158 | clus_res_table        | alter table clus_res_table modify `creation_time` bigint unsigned not null, modify `mod_time` bigint unsigned default 0 not null, modify `deleted` tinyint default 0, modify `cluster` tinytext not null, modify `res_id` int not null, modify `percent_allowed` int unsigned default 0, drop primary key, add primary key (res_id, cluster(42)), drop index udex, add unique index udex (res_id, cluster(42));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|    1621918158 | 1621918158 | convert_version_table | alter table convert_version_table modify `mod_time` bigint unsigned default 0 not null, modify `version` int default 0, drop primary key, add primary key (version);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|    1621918158 | 1621918158 | federation_table      | alter table federation_table modify `creation_time` int unsigned not null, modify `mod_time` int unsigned default 0 not null, modify `deleted` tinyint default 0, modify `name` tinytext not null, modify `flags` int unsigned default 0, drop primary key, add primary key (name(42));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|    1621918158 | 1621918158 | qos_table             | alter table qos_table modify `creation_time` bigint unsigned not null, modify `mod_time` bigint unsigned default 0 not null, modify `deleted` tinyint default 0, modify `id` int not null auto_increment, modify `name` tinytext not null, modify `description` text, modify `flags` int unsigned default 0, modify `grace_time` int unsigned default NULL, modify `max_jobs_pa` int default NULL, modify `max_jobs_per_user` int default NULL, modify `max_jobs_accrue_pa` int default NULL, modify `max_jobs_accrue_pu` int default NULL, modify `min_prio_thresh` int default NULL, modify `max_submit_jobs_pa` int default NULL, modify `max_submit_jobs_per_user` int default NULL, modify `max_tres_pa` text not null default '', modify `max_tres_pj` text not null default '', modify `max_tres_pn` text not null default '', modify `max_tres_pu` text not null default '', modify `max_tres_mins_pj` text not null default '', modify `max_tres_run_mins_pa` text not null default '', modify `max_tres_run_mins_pu` text not null default '', modify `min_tres_pj` text not null default '', modify `max_wall_duration_per_job` int default NULL, modify `grp_jobs` int default NULL, modify `grp_jobs_accrue` int default NULL, modify `grp_submit_jobs` int default NULL, modify `grp_tres` text not null default '', modify `grp_tres_mins` text not null default '', modify `grp_tres_run_mins` text not null default '', modify `grp_wall` int default NULL, modify `preempt` text not null default '', modify `preempt_mode` int default 0, modify `preempt_exempt_time` int unsigned default NULL, modify `priority` int unsigned default 0, modify `usage_factor` double default 1.0 not null, modify `usage_thres` double default NULL, drop primary key, add primary key (id), drop index udex, add unique index udex (name(42)); |
|    1621918158 | 1621918158 | res_table             | alter table res_table modify `creation_time` bigint unsigned not null, modify `mod_time` bigint unsigned default 0 not null, modify `deleted` tinyint default 0, modify `id` int not null auto_increment, modify `name` tinytext not null, modify `description` text default null, modify `manager` tinytext not null, modify `server` tinytext not null, modify `count` int unsigned default 0, modify `type` int unsigned default 0, modify `flags` int unsigned default 0, drop primary key, add primary key (id), drop index udex, add unique index udex (name(42), server(42), type);                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|    1621918158 | 1621918158 | tres_table            | alter table tres_table modify `creation_time` bigint unsigned not null, modify `deleted` tinyint default 0 not null, modify `id` int not null auto_increment, modify `type` tinytext not null, modify `name` tinytext not null default '', drop primary key, add primary key (id), drop index udex, add unique index udex (type(42), name(42));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|    1621918158 | 1621918158 | txn_table             | alter table txn_table modify `id` int not null auto_increment, modify `timestamp` bigint unsigned default 0 not null, modify `action` smallint not null, modify `name` text not null, modify `actor` tinytext not null, modify `cluster` tinytext not null default '', modify `info` blob, drop primary key, add primary key (id);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|    1621918158 | 1621918158 | user_table            | alter table user_table modify `creation_time` bigint unsigned not null, modify `mod_time` bigint unsigned default 0 not null, modify `deleted` tinyint default 0, modify `name` tinytext not null, modify `admin_level` smallint default 1 not null, drop primary key, add primary key (name(42));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
+---------------+------------+-----------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
11 rows in set (0.00 sec)



MariaDB [slurm_acct_db]> SELECT * FROM txn_table;
Empty set (0.00 sec)


MariaDB [slurm_acct_db]> SELECT * FROM tres_table;
+---------------+---------+------+----------------+------+
| creation_time | deleted | id   | type           | name |
+---------------+---------+------+----------------+------+
|    1621918158 |       0 |    1 | cpu            |      |
|    1621918158 |       0 |    2 | mem            |      |
|    1621918158 |       0 |    3 | energy         |      |
|    1621918158 |       0 |    4 | node           |      |
|    1621918158 |       0 |    5 | billing        |      |
|    1621918158 |       0 |    6 | fs             | disk |
|    1621918158 |       0 |    7 | vmem           |      |
|    1621918158 |       0 |    8 | pages          |      |
|    1621918158 |       1 | 1000 | dynamic_offset |      |
+---------------+---------+------+----------------+------+
9 rows in set (0.00 sec)

MariaDB [slurm_acct_db]> SELECT * FROM user_table;
---------------+------------+---------+------+-------------+
| creation_time | mod_time   | deleted | name | admin_level |
+---------------+------------+---------+------+-------------+
|    1621918158 | 1621918158 |       0 | root |           3 |
+---------------+------------+---------+------+-------------+
1 row in set (0.01 sec)

```

## Trouble shooting

check status
```
scontrol show node life1
```

node 중 drain 상태가 뜨는 경우 idle 상태로 전환시키기
```
scontrol update nodename=node10 state=resume
```
or
```
scontrol update nodename=node10 state=idle
```
Ref: http://egloos.zum.com/phdjin/v/2245474
