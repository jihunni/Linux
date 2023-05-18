# FRODOCK
Ref: https://chaconlab.org/modeling/frodock/frodock-intro  
## Pre-requisite
- Get Intel® oneAPI Math Kernel Library (oneMKL)
  Ref: https://www.intel.com/content/www/us/en/developer/tools/oneapi/onemkl-download.html?operatingsystem=linux&distributions=online
  ```
  $ wget https://registrationcenter-download.intel.com/akdlm/IRC_NAS/cd17b7fe-500e-4305-a89b-bd5b42bfd9f8/l_onemkl_p_2023.1.0.46342.sh
  $ sudo sh ./l_onemkl_p_2023.1.0.46342.sh
  $ source /opt/intel/oneapi/setvars.sh
  ```

## Trial and Error
- case
  Error
  ```
  /opt/frodock/3.1.2/bin//frodock: error while loading shared libraries: libmkl_intel_lp64.so: cannot open shared object file: No such file or directory
  ```
  Solution
  ```
  $ sudo apt-get install libmkl-intel-lp64
  ```
- case
  Error
  ```
  /opt/frodock/3.1.2/bin//frodock: error while loading shared libraries: libmkl_intel_thread.so: cannot open shared object file: No such file or directory
  ```
  Solution
  ```
  $ sudo apt-get install  libmkl-intel-thread
  ```
# run script
```
#!/bin/bash
#
# FRODOCK 3.0 TEST (December 8th, 2019)
# ----------------------------------
# The basic procedure is illustrated with an antigen-antibody docking case. 
# The "receptor" (antibody, 1MLC_r_u.pdb) and the "ligand" (antigen, 1MLC_r_u.pdb) 
# The "reference" bound ligand molecule (antigen, 1MLC_r_b.pdb) is also 
# provided.
# 
# The complete test takes around 11 minutes for gcc/intel binaries using 
# the 4 cores of an Intel(R) Core(TM) i7 CPU 950 running at 3.07GHz. The 
# sequential version takes around 40/30 minutes in the same machine.
#
# More tests are detailed in the FRODOCK tutorial web page:
# http://chaconlab.org/methods/docking/frodock/frododock-tuto#Tuto_Complex
#
# Please, cite FRODOCK if it is useful for your reasearch:
#
# *Server: E. Ramírez-Aportela, J.R. López-Blanco & P. Chacón (2016). 
#          FRODOCK 2.0: Fast Protein-Protein docking server. Bioinformatics.
# *Method: J.I. Garzón, J.R. López-Blanco, C. Pons, J. Kovacs, R. Abagyan, 
#          J. Fernández-Recio, P. Chacón (2009). FRODOCK: a new approach 
#          for fast rotational protein-protein docking. Bioinformatics, 
#          25, 2544-2551.
#
# Questions and suggestions are welcome, please contact at chaconlab.org.
# 
#
# FILES PROVIDED
# --------------
#
# 1WEJ_r_u.pdb --> Receptor [PDB] 
# 1WEJ_l_u.pdb --> Ligand [PDB] (randomly rotated) 
# consts.txt   --> Constraints file [plain text]
# 1WEJ_l_b.pdb --> Ligand PDB in the bound pose (for comparison purposes)
# 1WEJ_r_b.pdb --> Receptor PDB in the bound pose (for comparison purposes)
# 1WEJ_l_u_fitted.pdb --> Ligand PDB in the unbound pose fitted to bound pose (for comparison purposes) 

#
# INSTRUCTIONS
# ------------
# 1) Select the binaries version you want to test with "mpi" and "comp"
#    variables:
#
#    a) With or without MPI parallelization:
#	  mpi=""     --> Without OpenMPI (sequential)
#	  mpi="_mpi" --> With OpenMPI (parallel)
#
#    b) Compiled with Intel or GNU compilers:
#	  comp="" --> Intel (icpc)
#	  comp="_gcc" --> GNU (gcc)
#
# 2) Choose the appropriate MPI run command ("mympi") for your system.
#    By default, the "mpirun" command is taken from PATH.
#    Note this "mpirun" command must match compiler choice and your 
#    system configuration. Typical "mpirun" locations are:
#       mympi="/usr/bin/mpirun.openmpi"
#       mympi="/usr/local/bin/mpirun" # My "mpirun" command for Intel
#       mympi="/etc/alternatives/mpirun" # My "mpirun" command for GNU
#       mympi="/usr/local/openmpi/bin/mpirun"
#       mympi="/opt/intel/composer_xe_2013.1.117/mpirt/bin/intel64/mpirun"
#
# 3) Set the number of processing cores you want in case you have 
#    selected MPI parallelization. For example, for 4 cores, use:
#       np="4"
#
mpi=""   # MPI: "" without MPI or "_mpi" with MPI
comp="_gcc"  # COMPILER: "_gcc" for GNU or "" for Intel
np=4 # Number of processors (only for MPI test)
mympi="mpirun" # The "mpirun" command is taken from PATH environment var.

# PLEASE, DO NOT TOUCH ANYTHING BELOW THIS LINE...
# ------------------------------------------------------------------------

# Note that frodock seems to use only one thread

# I/O setting
input_dir_for_iteration="/home/jihun/minibinder/TAP1/final_filter/"
output_dir="/home/jihun/minibinder/TAP1/frodock/"

# Frodock running setting
max_num_clusters=100
num_output_pdb=100

#pre=""
pre="/opt/frodock/3.1.2/bin/"
suff=$mpi$comp
suff2=$comp

# running configuration
if [ "$mpi" = "_mpi" ]
then
 run="$mympi -np $np"
 echo RUNNING MPI TESTS
else
 run=""
 echo RUNNING NON-MPI TESTS
fi

function run_code {
	mkdir ${file_name}
	cd ${file_name}
	
	echo -e "To extract chain A from the input pdb file"
    cat ${input_dir_for_iteration}/${file_name}.pdb | grep '^ATOM' | grep -v OXT | awk ' $5 == "A" { print $0 }' > ${file_name}_chainA.pdb
    chmod 755 ${file_name}_chainA.pdb

    echo -e "To extract chain B from the input pdb file"
    cat ${input_dir_for_iteration}/${file_name}.pdb | grep '^ATOM' | grep -v OXT | awk ' $5 == "B" { print $0 }' > ${file_name}_chainB.pdb
    chmod 755 ${file_name}_chainB.pdb
    
    receptor=${file_name}_chainB  # Receptor ID without .pdb extension
    ligand=${file_name}_chainA    # Ligand ID without .pdb extension
    ligand_ref=${file_name}_chainA  # Ligand ID without .pdb extension
    
    

    echo STAGE-1 Creation of receptor vdw potential map
    echo -e $run $pre'frodockgrid'$suff $receptor.pdb -o $receptor'_W'.mrc
    $run $pre'frodockgrid'$suff $receptor.pdb -o $receptor'_W'.mrc

    echo STAGE-2 Creation of the receptor electrostatic potential map
    echo -e $run $pre'frodockgrid'$suff $receptor.pdb -o $receptor'_E'.mrc -m 1 -t A
    $run $pre'frodockgrid'$suff $receptor.pdb -o $receptor'_E'.mrc -m 1 -t A

    echo STAGE-3 Creation of the receptor desolvation potential map
    echo -e  $run $pre'frodockgrid'$suff $receptor.pdb -o $receptor'_DS'.mrc -m 3
    $run $pre'frodockgrid'$suff $receptor.pdb -o $receptor'_DS'.mrc -m 3

    echo STAGE-4 Creation of the ligand desolvation potential map
    echo -e $run $pre'frodockgrid'$suff $ligand.pdb -o $ligand'_DS'.mrc -m 3
    $run $pre'frodockgrid'$suff $ligand.pdb -o $ligand'_DS'.mrc -m 3

    echo STAGE-5 Performing the docking
    echo -e $run $pre'frodock'$suff $receptor'_ASA'.pdb $ligand'_ASA'.pdb -w $receptor'_W'.mrc -e $receptor'_E'.mrc --th 10 -d $receptor'_DS'.mrc,$ligand'_DS'.mrc -t A -o dock.dat  -s ../bin/soap.bin
    $run $pre'frodock'$suff $receptor'_ASA'.pdb $ligand'_ASA'.pdb -w $receptor'_W'.mrc -e $receptor'_E'.mrc --th 10 -d $receptor'_DS'.mrc,$ligand'_DS'.mrc -t A -o dock.dat  -s $pre/soap.bin 

    echo STAGE-6 Clustering and visualization of predictions
    echo -e   $pre'frodockcluster'$suff2 dock.dat $ligand.pdb --nc $max_num_clusters -o clust_dock.dat
    $pre'frodockcluster'$suff2 dock.dat $ligand.pdb --nc $max_num_clusters -o clust_dock.dat

    #echo STAGE-7 Visualize the first 20 solutions
    #echo -e $pre'frodockview'$suff2 clust_dock.dat -r 1-20 
    #$pre'frodockview'$suff2 clust_dock.dat -r 1-20

    echo STAGE-8 Coordinate generation of the 10 best predicted solutions
    echo -e $pre'frodockview'$suff2 clust_dock.dat -r 1-$num_output_pdb -p $ligand.pdb -f $ligand_ref.pdb
    $pre'frodockview'$suff2 clust_dock.dat -r 1-$num_output_pdb -p $ligand.pdb -f $ligand_ref.pdb
    $pre'frodockview'$suff2 clust_dock.dat -r 1-$num_output_pdb -p $ligand.pdb -f $ligand_ref.pdb > ${file_name}_frodock_result.txt
    awk -F ' ' '{print $10 "\t"  $8}' ${file_name}_frodock_result.txt > ${file_name}_frodock_result_score_only.txt

    #echo "The 8th solutions (1WEJ_l_u_8.pdb) should match the native pose: 1WEJ_l_b.pdb"
    #echo "Please, display the results in your favorite molecular viewer, e.g."
    #echo " > chimera 1WEJ_r_u.pdb 1WEJ_l_u_8.pdb 1WEJ_l_b.pdb "
    #echo -e "STAGE-9 Apply some simple distance constraints to improve the ranking of the best solution."
    #echo -e "For example, lets suppose you know a single distance constraint:"
    #echo -e "  1) the GLY 102 (chain B) of receptor and the ARG 37 of the ligand are within 10 Angstroms one another"
    #echo -e "The file consts.txt encodes this information, you should use a format like this:"
    #cat consts.txt

    #echo -e "Once a constraint file is generated you can apply the constraints:"
    
    #echo -e $pre'frodockonstraints'$suff2 clust_dock.dat $receptor.pdb $ligand.pdb consts.txt -o clust_dock_filt.dat
    #$pre'frodockonstraints'$suff2 clust_dock.dat $receptor.pdb $ligand.pdb consts.txt -o clust_dock_filt.dat
    
    #echo STAGE-10 Coordinate generation of the two best filtered solutions
    #if test ! -e filt.pdb
    #then 
    #  cp $ligand.pdb filt.pdb
    #fi
    #echo -e "As you can see only 8 different solutions are compatible with the constraints" 
    #echo -e $pre'frodockview'$suff2 clust_dock_filt.dat -p filt.pdb -f $ligand_ref.pdb 
    #$pre'frodockview'$suff2 clust_dock_filt.dat -p filt.pdb -f $ligand_ref.pdb 

    #echo -e "In this case, the previous best ranked solution (8th) is now the 3rd (filt_3.pdb), and in the 6th position the solulion is even better"
    #echo " to see it> chimera 1WEJ_r_u.pdb filt_3.pdb filt_6.pdb 1WEJ_l_b.pdb "
    #echo 
    echo -e "TEST FINISHED"
    echo 
    
    cd .. 
}

for file_name in $(ls $input_dir_for_iteration/*.pdb); do
	file_name="${file_name##*/}" # to get fileName with extension (to remove path)
    file_name="${file_name%.*}" # to remove file extenstion
    echo ${file_name} ;

    cd $output_dir

    run_code &

    cd ..
done
```
