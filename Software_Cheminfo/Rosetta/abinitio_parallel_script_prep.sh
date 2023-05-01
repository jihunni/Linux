command_file_name="abinitio_parallel_script.list"

export ROSETTA="/opt/rosetta/rosetta_src_2021.16.61629_bundle/main/source/"
export WORK_DIR=$PWD

NUM_SCRIPT_BATCH=20
((NUM_SCRIPT_BATCH--)) # batch_number starts from 0 to batch-1

for iter in $(seq 0 $NUM_SCRIPT_BATCH)
do
    script="$ROSETTA/bin/AbinitioRelax.default.linuxgccrelease @abinitio.flags -out:prefix 5u1d_1126_0001_${iter}_"
    printf "$script\n" #> command_file_name

done
