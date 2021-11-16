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
