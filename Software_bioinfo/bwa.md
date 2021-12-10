# bwa
Ref: http://bio-bwa.sourceforge.net/bwa.shtml  
- index
  general code
  ```
 	bwa index [-p prefix] [-a algoType] <in.db.fasta>
  ```

  running code
  ```
  /opt/bwa-mem/0.7.17/bwa index -a bwtsw  Homo_sapiens.GRCh38.dna.primary_assembly.fa
  ```
- alignment
  general code
  ```
  bwa mem -t [thread_number] -T [score] ref.fa read1.fq read2.fq > sam
  ```
  
  running code
  ```
  #load module

  # load parapmeters
  ref_genome='/home/data/ref_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa'
  NUM_CORE=15

  # run the code
  for file_name in $(ls ${PWD}/data/*pair1.fastq)
  do
    file_name=${file_name%-trimmed*pair1.fastq}
    echo $file_name

    # alignment
    # warning! put --rg-id option on to last. It seems collapsed the other option.
    /opt/bwa-mem/0.7.17/bwa mem -t $NUM_CORE -T 0 $ref_genome ${file_name}-trimmed-pair1.fastq ${file_name}-trimmed-pair2.fastq > ${file_name}.sam
    echo 'alignment is done'

    # isolate uniquely mapped reads (with conversion to bam)
    samtools view -f 2 -q 10 -b -@ $NUM_CORE -o ${file_name}_unique.bam ${file_name}.sam
    samtools sort -@ $NUM_CORE ${file_name}_unique.bam -o ${file_name}_align_unique.sorted.bam
    samtools index -@ $NUM_CORE ${file_name}_unique.sorted.bam ${file_name}_unique.sorted.bam.bai

    echo 'samtools sort and isolation are done.'
  done
  ```
