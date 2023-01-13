#! /bin/bash
# a program to run vina where run ${num_proc_in_array} times of vina
# PARAMETERS : SLURM_ARRAY_TASK_ID, num_proc_in_array
# Dependency : gpf_to_config.py, input_to_PostgreSQL.py
# e.g. array 0 --> process 1-100
# e.g. array 1 --> process 101 - 200
# to check the python env
echo "SLUM_ARRAY_TASK_ID : ${SLURM_ARRAY_TASK_ID}"
echo $CONDA_PREFIX
which pip
python check_conda.py

num_proc_in_array=100
export start_value_in_array=$(($num_proc_in_array * ${SLURM_ARRAY_TASK_ID} + 1)) #ex. i=0,  1
export end_value_in_array=$(($num_proc_in_array * ${SLURM_ARRAY_TASK_ID} + $num_proc_in_array )) # ex. i=0, 100 
echo "start_value_in_array : $start_value_in_array"
echo "end_value_in_array : $end_value_in_array"

for ((i=1 ; i < $(( $num_proc_in_array+1 )) ; i++)); do    
    # run vian
    #RECEPTOR="ENSG00000137513"
    #RECEPTOR_directory="/home/jihun/data/PubChem/receptor_alphafold2"
    LIGAND=$(( ${SLURM_ARRAY_TASK_ID} * ${num_proc_in_array} + $i ))
    LIGAND_directory="/home/jihun/data/PubChem/3dSDF_single/"
    Vina_directory="/home/jihun/data/PubChem/vina_output/"${RECEPTOR}

    # to check whether output directory exists, or not
    if [[ -d "${Vina_directory}" ]]
    then
        echo "output directory does already exist. Nothing happen"
    else
        echo "output directory does not exist and create a new directory"
        mkdir ${Vina_directory}
    fi
    echo "receptor : ${RECEPTOR_directory}/${RECEPTOR}.pdbqt"
    echo "ligand ID : ${LIGAND}"

    # to check the existence of vina output
    if [[ -f "${Vina_directory}/vina_${RECEPTOR}_${LIGAND}.pdbqt" ]] 
    then
	echo "Skip: vina is already done before."
    else
    	# To prepare receptor, ligand, configuration
    	#prepare_receptor -A "hydrogens" -r ${RECEPTOR_directory}/${RECEPTOR}.pdb -o ${RECEPTOR_directory}/${RECEPTOR}.pdbqt
    	mk_prepare_ligand.py -i ${LIGAND_directory}/${LIGAND}.sdf -o ${LIGAND_directory}/${LIGAND}.pdbqt
    	/opt/autodock_vina/AutoDock-Vina-develop/example/autodock_scripts/prepare_gpf.py -l ${LIGAND_directory}/${LIGAND}.pdbqt -r ${RECEPTOR_directory}/${RECEPTOR}.pdbqt -y -o ${Vina_directory}/vina_${RECEPTOR}_${LIGAND}.gpf
    	python gpf_to_config.py ${Vina_directory}/vina_${RECEPTOR}_${LIGAND}.gpf ${Vina_directory}/vina_${RECEPTOR}_${LIGAND}.config
    # To run vina
    	/opt/autodock_vina/1.1.2/bin/vina --receptor ${RECEPTOR_directory}/${RECEPTOR}.pdbqt --ligand ${LIGAND_directory}/${LIGAND}.pdbqt --config ${Vina_directory}/vina_${RECEPTOR}_${LIGAND}.config --exhaustiveness=32 --cpu 1 --out ${Vina_directory}/vina_${RECEPTOR}_${LIGAND}.pdbqt > ${Vina_directory}/vina_${RECEPTOR}_${LIGAND}.log
    	# To save the vina output into PostgreSQL db
	python input_to_PostgreSQL.py -i ${Vina_directory}/vina_${RECEPTOR}_${LIGAND}.pdbqt -r ${RECEPTOR} -l ${LIGAND}
    fi
    
done
echo "finished"
python slack_message.py "slurm array : ${SLURM_ARRAY_TASK_ID} is done."
