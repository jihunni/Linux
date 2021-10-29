#!/bin/bash

##############################
# Run HMMRATAC with slurm (parallelize the multiple single core program)
# input : $PWD/data/sample.bam, $PWD/data/sample.bami (filtered and sorted)
# output : $PWD/HMMRATAC/prefix_{something}
##############################
#
#SBATCH --job-name=HMMRATAC
#
#SBATCH --account=jihun
#SBATCH --mail-user=jihun@gm.gist.ac.kr
#SBATCH --mail-type=BEGIN,FAIL,END
#
#
#SBATCH --ntasks=1
#SBATCH --array=0-40
#SBATCH --cpus-per-task=1
#SBATCH --mem 30GG
#SBATCH --time=48:00:00
#SBATCH --output=slurm_result_%j.txt
#SBATCH -o %x_%A.o%j
#SBATCH -e %x_%A.e%j

# stdout : basic info
echo "SLURM running info"
echo "Start Time        = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"

# load modules
module purge
module load samtools/1.13

file_name_list=$(ls data/*.bam)

#similarly, for loop
IN=$file_name_list
arrIN=(${IN// / })
file_name=${arrIN[$SLURM_ARRAY_TASK_ID]}

	#echo $file_name ;
	file_name_with_directory=${file_name%.*m} #remove '.bam' on file_name
	echo $file_name_with_directory ;

	file_name=${file_name_with_directory#data/}
	echo $file_name;
	
	# Make genome information (chromosome sizes) from the BAM file to get a genome.info file:
	samtools view -H ${file_name_with_directory}.bam | perl -ne 'if(/^@SQ.*?SN:(\w+)\s+LN:(\d+)/){print $1,"\t",$2,"\n"}' > ${file_name_with_directory}.info

	# Run HMMRATAC on the sorted BAM ATACseq.sorted.bam, the BAM index file ATACseq.sorted.bam.bai, and the genome information file genome.info:
	java -jar /opt/HMMRATAC/1.2.10/HMMRATAC_V1.2.10_exe.jar -b ${file_name_with_directory}.bam -i ${file_name_with_directory}.bai -g ${file_name_with_directory}.info -e /opt/The_ENCODE_Blacklist/20210922/lists/hg38-blacklist.v2.bed -o ./HMMRATAC_slurm/${file_name}

sleep 1 # pause to be kind to the scheduler

echo $SLURM_ARRAY_TASK_ID
echo "Finish Time       = $(date)"
