# TPMCalculator
- paper: https://academic.oup.com/bioinformatics/article/35/11/1960/5150437
- github: https://github.com/ncbi/TPMCalculator
- conda: https://anaconda.org/bioconda/tpmcalculator
  
# Installation
  ```
  conda install -c bioconda tpmcalculator
  ```

# Run
  ```
  ./bin/TPMCalculator -g GTF_file [-d BAM_files_directory|-b BAM_file]
  
  
  ./bin/TPMCalculator options:

    -v    Print info
    -h    Display this usage information.
    -g    GTF file
    -d    Directory with the BAM files
    -b    BAM file
    -k    Gene key to use from GTF file. Default: gene_id
    -t    Transcript key to use from GTF file. Default: transcript_id
    -c    Smaller size allowed for an intron created for genes. Default: 16. We recommend to use the reads length
    -p    Use only properly paired reads. Default: No. Recommended for paired-end reads.
    -q    Minimum MAPQ value to filter out reads. Default: 0. This value depends on the aligner MAPQ value.
    -o    Minimum overlap between a reads and a feature. Default: 8.
    -e    Extended output. This will include transcript level TPM values. Default: No.
    -a    Print out all features with read counts equal to zero. Default: No.
  ```
  
    
## example
 ```
 $ TPMCalculator -g /home/data/ref_genome/Homo_sapiens.GRCh38.108/Homo_sapiens.GRCh38.108.gtf -b  sample_Aligned.sortedByCoord.out.bam -p
 ```
 output: 
 -  sample_Aligned.sortedByCoord.out_genes.uni
 -  sample_Aligned.sortedByCoord.out_genes.ent
 -  sample_Aligned.sortedByCoord.out_genes.out
