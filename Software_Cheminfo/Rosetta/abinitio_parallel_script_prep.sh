command_file_name="abinitio_parallel_command_prep.list"

export ROSETTA="/opt/rosetta/rosetta_src_2021.16.61629_bundle/main/source/"
export WORK_DIR=$PWD

NUM_SCRIPT_BATCH=40
((NUM_SCRIPT_BATCH--)) # batch_number starts from 0 to batch-1

# estimated running time : 2 min / model
# recommended running number : 1000 model / design

rm abinitio_parallel_command_prep.list

for iter in $(seq 0 $NUM_SCRIPT_BATCH)
do
        script="cd output; mkdir 5u1d_1126_0001_${iter}; cd 5u1d_1126_0001_${iter};  $ROSETTA/bin/AbinitioRelax.default.linuxgccrelease @../../abinitio.flags -out:prefix 5u1d_1126_0001_${iter}_  -out:file:scorefile score.json -scorefile_format json > log.log 2>&1 "
        printf "$script\n" >> $command_file_name

done

echo "abinitio_parallel_command_prep.list is generated"
