# Bowtie2
# Build index
Ref: https://bowtie-bio.sourceforge.net/bowtie2/manual.shtml#the-bowtie2-build-indexer  

general
```
bowtie2-build [options]* <reference_in> <bt2_base>
```

example
```
$ bowtie2-build ../Homo_sapiens.GRCh38.dna_sm.toplevel.fa Homo_sapiens.GRCh38.dna_sm.toplevel --threads 8
```

# paired end read alignment
ref: https://bowtie-bio.sourceforge.net/bowtie2/manual.shtml#aligning-pairs  
general
```
bowtie2 [options]* -x <bt2-idx> {-1 <m1> -2 <m2> | -U <r> | --interleaved <i> | --sra-acc <acc> | b <bam>} -S [<sam>]
```
example
```
INPUT_DIRECTORY='/home/jihun/data/RNAseq/'
module load bowtie2/2.4.4

for iter in {1,2,3,4,5}
do
	bowtie2 -x /home/data/ref_genome/Homo_sapiens.GRCh38.108/bowtie2_index/Homo_sapiens.GRCh38.dna_sm.toplevel -1 ${INPUT_DIRECTORY}/sample_${iter}_1.fq.gz -2 ${INPUT_DIRECTORY}/sample_${iter}_2.fq.gz -S NARS2_1 --threads 12 --time
done
```

```
[jihun@life3 TCGA-COAD_ATAC]$ ./bowtie_align_process_test.sh
$PWD/data/0b069d38-db2f-4d3d-99aa-0533e7e77b19_atacseq_gdc_realn
13368625 reads; of these:
  13368625 (100.00%) were paired; of these:
    10247471 (76.65%) aligned concordantly 0 times
    3121154 (23.35%) aligned concordantly exactly 1 time
    0 (0.00%) aligned concordantly >1 times
    ----
    10247471 pairs aligned concordantly 0 times; of these:
      2127576 (20.76%) aligned discordantly 1 time
    ----
    8119895 pairs aligned 0 times concordantly or discordantly; of these:
      16239790 mates make up the pairs; of these:
        15214720 (93.69%) aligned 0 times
        581566 (3.58%) aligned exactly 1 time
        443504 (2.73%) aligned >1 times
43.10% overall alignment rate
pre-alignment done
Finish Time       = 2021. 12. 02. (목) 23:50:27 KST

```
