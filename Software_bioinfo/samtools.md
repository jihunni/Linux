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
- flag stat
  ```
  $ samtools flagstat -@ 30  0b069d38-db2f-4d3d-99aa-0533e7e77b19_atacseq_gdc_realn.bam
  168163105 + 0 in total (QC-passed reads + QC-failed reads)
  160368412 + 0 primary
  0 + 0 secondary
  7794693 + 0 supplementary
  30427677 + 0 duplicates
  30427677 + 0 primary duplicates
  168013928 + 0 mapped (99.91% : N/A)
  160219235 + 0 primary mapped (99.91% : N/A)
  160368412 + 0 paired in sequencing
  80184206 + 0 read1
  80184206 + 0 read2
  156223290 + 0 properly paired (97.42% : N/A)
  160087388 + 0 with itself and mate mapped
  131847 + 0 singletons (0.08% : N/A)
  3075804 + 0 with mate mapped to a different chr
  1183736 + 0 with mate mapped to a different chr (mapQ>=5)

  ````
- 
