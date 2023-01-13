0. split_sdf structure  
split_sdf_slurm.sh  
	split_sdf_assign_taskID.sh  
		python check_conda.py  
		python split_sdf.py ${SLURM_ARRAY_TASK_ID}  

0. run_vina structure  
run_vina_slurm.sh  
	run_vina.sh  
		python check_conda.py  
		python gpf_to_config.py  
		python input_to_PostgreSQL.py  
		python slack_message.py  
  
