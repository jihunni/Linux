#!/bin/bash

# to activate python environment
#source /home/${USER}/.bashrc
#source /opt/anaconda3/2021.05/etc/profile.d/conda.sh
#source activate vina 
alias python='/opt/anaconda3/2021.05/envs/vina/bin/python'


echo "SLUM_ARRAY_TASK_ID : ${SLURM_ARRAY_TASK_ID}"
echo $CONDA_PREFIX
which pip
python check_conda.py
python split_sdf.py ${SLURM_ARRAY_TASK_ID}
python slack_message.py "Split sdf : ${SLURM_ARRAY_TASK_ID} is done."
