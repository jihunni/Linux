export ROSETTA="/opt/rosetta/rosetta_src_2021.16.61629_bundle/main/source/"
target_name="5u1d_432_0001_0001"
INPUT_DIRECTORY="${target_name}_input"
OUTPUT_DIRECTORY=${target_name}_output
command_file_name="abinitio_parallel_command_prep.list"
NUM_CORE=16

# Running condition setting
        # estimated running time with ~100 amino acids : 2 min / model
        # recommended running number : 1000 model / design = 4 hours
NUM_SCRIPT_BATCH=400
((NUM_SCRIPT_BATCH--)) # batch_number starts from 0 to batch-1

# Running code starts from here
StartTime=$(date +%s)
WORK_DIR=$PWD
rm $command_file_name
mkdir $OUTPUT_DIRECTORY

echo -e "To extract chain A from the input pdb file"
cat ${INPUT_DIRECTORY}/${target_name}.pdb | grep '^ATOM' | grep -v OXT | awk ' $5 == "A" { print $0 }' > ${INPUT_DIRECTORY}/${target_name}_chainA.pdb
chmod 755 $WORK_DIR/${INPUT_DIRECTORY}/${target_name}_chainA.pdb

echo -e "abinitio_parallel_command_prep.list is generated" 
for iter in $(seq 0 $NUM_SCRIPT_BATCH)
do
        script="cd ${target_name}_output; mkdir ${target_name}_${iter}; cd ${target_name}_${iter}; $ROSETTA/bin/AbinitioRelax.default.linuxgccrelease -abinitio:relax -nstruct 25 -out:pdb -use_filters true -abinitio::increase_cycles 10 -abinitio::rg_reweight 0.5 -abinitio::rsd_wt_helix 0.5 -abinitio::rsd_wt_loop 0.5 -relax::fast -in:file:fasta $WORK_DIR/${INPUT_DIRECTORY}/${target_name}_chainA.fasta -in:file:frag3 $WORK_DIR/$INPUT_DIRECTORY/aat000_03_05.200_v1_3 -in:file:frag9 $WORK_DIR/${INPUT_DIRECTORY}/aat000_09_05.200_v1_3 -in:file:native ${WORK_DIR}/${INPUT_DIRECTORY}/${target_name}_chainA.pdb -psipred_ss2 $WORK_DIR/${INPUT_DIRECTORY}/t000_.psipred_ss2 > log.log 2>&1 "
        # Note that -out:prefix does not work.

        printf "$script\n" >> $command_file_name
done


echo -e "To run Ab Initio protein folding parallelly"
parallel -j $NUM_CORE --bar {} < $command_file_name

EndTime=$(date +%s)
echo "It takes $(($EndTime - $StartTime)) seconds to complete this task."
