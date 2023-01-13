#!/bin/bash

##############################
# Run split_sdf (To split a sdf file containing multiple chemicals into sdf files containing a single chemical)
# input : a directory with sdf files containing multiple molecules.
# output : sdf files containing a single molecule.
# Jihun Jeung / jihun@gm.gist.ac.kr, jeung4705@gmail.com
##############################
#
#SBATCH --job-name=vina_nars1
#
#SBATCH --account=jihun
#SBATCH --mail-user=jihun@gm.gist.ac.kr
#SBATCH --mail-type=ALL
#
#SBATCH --ntasks=1
#SBATCH --array=0-999
#SBATCH --cpus-per-task=1
#SBATCH --mem 10G
#SBATCH --time=24:00:00
#SBATCH --output=/home/jihun/drug_screening/run_vina_slurm_out/slurm_result_%j.txt
#SBATCH -o /home/jihun/drug_screening/run_vina_slurm_out/%x_%A.o%j
#SBATCH -e /home/jihun/drug_screening/run_vina_slurm_out/%x_%A.e%j

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
module load autodock_vina/1.1.2
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
export RECEPTOR="ENSG00000134440"
export RECEPTOR_directory="/home/jihun/data/PubChem/receptor_alphafold2"

## to check and prepare the existence of receptor pdbqt files
if [[ -f "${RECEPTOR_directory}/${RECEPTOR}.pdbqt" ]]
    then
    echo "receptor.pdbqt exists"
else
    prepare_receptor -A "hydrogens" -r ${RECEPTOR_directory}/${RECEPTOR}.pdb -o ${RECEPTOR_directory}/${RECEPTOR}.pdbqt
    echo "receptor.pdbqt is created."
fi

## run vina	
./run_vina.sh

echo $SLURM_ARRAY_TASK_ID
echo "Finish Time       = $(date)"
