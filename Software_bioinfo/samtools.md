# samtools
Ref : http://quinlanlab.org/tutorials/samtools/samtools.html
- to convert sam to bam
  ```
  samtools view -S -b sample.sam > sample.bam
  ```
- to convert sam into fastq file  
  Ref : https://www.metagenomics.wiki/tools/samtools/converting-bam-to-fastq  
  Ref : http://www.htslib.org/doc/samtools-fasta.html  
  
  general
  ```
  samtools fastq -n -@ [num_threads] -1 [output_fastq_1] -2 [output_fastq_2] -0 [output_fastq_null] -s [output_fastq_null]  [input_sam]
  ```
  
  running code
  ```
  samtools fastq -@ 14 -1 ${input_file}_1.fastq.gz -2 ${input_file}_2.fastq.gz -0 ${input_file}_null.fastq.gz -s ${input_file}_null.fastq.gz -n ${input_file}.sam
  ```
  
  ```
  # to convert pre-aligned sam file into pair-end fastq file

  # load module
  module load samtools

  for input_file in $(ls ${PWD}/data/*.bam)
  do
    #input_file='/home/jihun/data/ENCODE/12_ENCSR548QCP/skewer/NCLB246GTQ-trimmed_filter.sam'
    input_file=${input_file%.*m} #remove '.bam' on file_name
    echo $input_file	

    samtools fastq -@ 14 -1 ${input_file}_1.fastq.gz -2 ${input_file}_2.fastq.gz -0 ${input_file}_null.fastq.gz -s ${input_file}_null.fastq.gz -n ${input_file}.sam
    echo 'done'
  done
  ```
- filter
  Ref : http://www.htslib.org/doc/samtools-view.html  
  ```
  samtools view -f 2 -q 10 -b -@ 20 -o output_file.bam
  ```
  > -f 2 : (flag)	each segment properly aligned according to the aligner    
  > -q INT : Skip alignments with MAPQ smaller than INT  
  > -b : Output in the BAM format.
  > -@ : the number of threads
  > -o : Output to FILE [stdout].
- sort
  ```
  samtools sort sample.bam -o sample.sorted.bam
  ```
- 
