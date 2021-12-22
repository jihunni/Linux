# MACS2 : CHIP-seq peak calling
  - peak calling  
    Ref : https://github.com/hbctraining/Intro-to-ChIPseq/blob/master/lessons/05_peak_calling_macs.md
    ![image](https://user-images.githubusercontent.com/48517782/147037299-397fe275-a639-46fe-867f-c7d3a9f6c91c.png)  
    
    Effective genome size : 
    Ref : https://deeptools.readthedocs.io/en/develop/content/feature/effectiveGenomeSize.html  
    GRCh38	2913022398  
    
    running code for peak calling
    ```
    # load library
    module load anaconda3
    conda activate MACS2

    # execute macs2
    macs2 callpeak -t data/0b069d38-db2f-4d3d-99aa-0533e7e77b19_atacseq_gdc_realn.bam\
      -c /home/jihun/data/ENCODE/data_filter/submits/ENCODE_all_summits.sorted.bed \
      -f BAM \
      -g 2913022398\
      -n 0b069d38-db2f-4d3d-99aa-0533e7e77b19 \
      --outdir macs2_output
    ```
    
    MACS2 parameters:  
    **Input file options**

    * `-t`: The IP data file (this is the only REQUIRED parameter for MACS)
    * `-c`: The control or mock data file
    * `-f`: format of input file; Default is "AUTO" which will allow MACS to decide the format automatically.
    * `-g`: mappable genome size which is defined as the genome size which can be sequenced; some precompiled values provided.

    **Output arguments**

    * `--outdir`: MACS2 will save all output files into speficied folder for this option
    * `-n`: The prefix string for output files
    * `-B/--bdg`: store the fragment pileup, control lambda, -log10pvalue and -log10qvalue scores in bedGraph files

    **Shifting model arguments**

    * `-s`: size of sequencing tags. Default, MACS will use the first 10 sequences from your input treatment file to determine it
    * `--bw`: The bandwidth which is used to scan the genome ONLY for model building. Can be set to the expected sonication fragment size.
    * `--mfold`: upper and lower limit for model building

    **Peak calling arguments**

    * `-q`: q-value (minimum FDR) cutoff
    * `-p`: p-value cutoff (instead of q-value cutoff)
    * `--nolambda`: do not consider the local bias/lambda at peak candidate regions
    * `--broad`: broad peak calling
