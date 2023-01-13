#!/bin/bash

##############################
# Run split_sdf (To split a sdf file containing multiple chemicals into sdf files containing a single chemical)
# input : a directory with sdf files containing multiple molecules.
# output : sdf files containing a single molecule.
# Jihun Jeung / jihun@gm.gist.ac.kr, jeung4705@gmail.com
##############################
#
#SBATCH --job-name=parsing_sdf
#
#SBATCH --account=jihun
#SBATCH --mail-user=jihun@gm.gist.ac.kr
#SBATCH --mail-type=ALL
#
#
#SBATCH --ntasks=1
#SBATCH --array=0-239
#SBATCH --cpus-per-task=1
#SBATCH --mem 10G
#SBATCH --time="UNLIMITED"
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


#load module
module purge
module load anaconda3/2021.05
module load ADFR_suite 

# to activate python environment
#source /home/${USER}/.bashrc
source /opt/anaconda3/2021.05/etc/profile.d/conda.sh
source activate /opt/anaconda3/2021.05/envs/vina
#conda activate vina 

# export environment variable
# alias python='/opt/anaconda3/2021.05/envs/vina/bin/python'
export PATH=/opt/anaconda3/2021.05/envs/vina/bin:$PATH

# run the program
./split_sdf_assign_taskID.sh

echo $SLURM_ARRAY_TASK_ID
echo "Finish Time       = $(date)"
