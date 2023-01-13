#!/bin/bash
###########################
# To split a single job of the long slurm array into multiple jobs containing 1000 array.
# Author : Jihun Jeung, jihun@gm.gist.ac.kr
##########################
array_start=1
array_end=1001

array_length=$(($array_end - $array_start + 1))
array_length_per_single_job=1000
num_jobs=$(($array_length/$array_length_per_single_job)) # integer division

if [ $array_length == $(($array_length_per_single_job * $num_jobs )) ]; then
	# if there is no multiplication remainder
	for ((i=0 ; i <$num_jobs ; i++)); do
		export start_value_in_job=$(($array_start+1000*i))
		export end_value_in_job=$(($array_start+1000*(i+1)-1))	
		echo "start_value_in_job : $start_value_in_job"
		echo "end_value_in_job : $end_value_in_job"
		sbatch -vvv --array=${start_value_in_job}-${end_value_in_job} run_vina_slurm.sh
		echo "finished"
	done
elif [ $((  $array_length > $(( $array_length_per_single_job * $num_jobs )) )) ]; then
	# if there exists multiplication remainder
	remainder=$(( $array_length - $(($array_length_per_single_job*$num_jobs)) ))
	for ((i=0 ; i< $num_jobs ; i++)); do
		export start_value_in_job=$(($array_start+1000*i))
		export end_value_in_job=$(($array_start+1000*(i+1)-1))
		echo "start_value_in_job : $start_value_in_job"
		echo "end_value_in_job : $end_value_in_job"
		sbatch -vvv  --array=${start_value_in_job}-${end_value_in_job} run_vina_slurm.sh
		echo "finished"
	done
	# for multiplication remainder
	export start_value_in_job=$(($array_start+1000*i))
	export end_value_in_job=$(($start_value_in_job+$remainder-1))
	echo "start_value_in_job : $start_value_in_job"
	echo "end_value_in_job : $end_value_in_job"
	sbatch -vvv --array=${start_value_in_job}-${end_value_in_job} run_vina_slurm.sh
	echo "finished"
else
	echo "error"
fi
