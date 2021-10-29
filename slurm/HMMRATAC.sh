##############################
# Run HMMRATAC without slurm (without parallelization)
# input : $PWD/data/sample.bam, $PWD/data/sample.bami (filtered and sorted)
# output : $PWD/HMMRATAC/prefix_{something}
##############################

# load modules
module load samtools/1.13

for file_name in $(ls data/*.bam); do #select all bam in subdirectory
	#echo $file_name ;
	file_name_with_directory=${file_name%.*m} #remove '.bam' on file_name
	echo $file_name_with_directory ;

	file_name=${file_name_with_directory#data/}
	echo $file_name;
	
	# Make genome information (chromosome sizes) from the BAM file to get a genome.info file:
	samtools view -H ${file_name_with_directory}.bam | perl -ne 'if(/^@SQ.*?SN:(\w+)\s+LN:(\d+)/){print $1,"\t",$2,"\n"}' > ${file_name_with_directory}.info

	# Run HMMRATAC on the sorted BAM ATACseq.sorted.bam, the BAM index file ATACseq.sorted.bam.bai, and the genome information file genome.info:
	java -jar /opt/HMMRATAC/1.2.10/HMMRATAC_V1.2.10_exe.jar -b ${file_name_with_directory}.bam -i ${file_name_with_directory}.bai -g ${file_name_with_directory}.info -e /opt/The_ENCODE_Blacklist/20210922/lists/hg38-blacklist.v2.bed -o ./HMMRATAC/${file_name}
done

# unload modules
module unload samtools
