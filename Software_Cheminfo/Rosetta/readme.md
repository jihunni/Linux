# Ab Initio protein folding
```
./abinitio_parallel_command_prep.sh  > abinitio_parallel_command_prep.list
parallel -j 20 --bar {} < abinitio_parallel_command_prep.list
```
