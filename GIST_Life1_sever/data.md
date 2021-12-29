# directory : /home/data/
- ref_genome
  - Homo_sapiens.GRCh38.104.gtf
  - Homo_sapiens.GRCh38.dna.primary_assembly.fa
  
  Index by BWA-MEM2:
  - Homo_sapiens.GRCh38.dna.primary_assembly.fa.0123
  - Homo_sapiens.GRCh38.dna.primary_assembly.fa.amb
  - Homo_sapiens.GRCh38.dna.primary_assembly.fa.ann
  - Homo_sapiens.GRCh38.dna.primary_assembly.fa.bwt.2bit.64
  - Homo_sapiens.GRCh38.dna.primary_assembly.fa.bwt.8bit.32
  - Homo_sapiens.GRCh38.dna.primary_assembly.fa.pac  
  
  Index by Bowtie2
  - Homo_sapiens.GRCh38_bowtie2.1.bt2
  - Homo_sapiens.GRCh38_bowtie2.2.bt2
  - Homo_sapiens.GRCh38_bowtie2.3.bt2
  - Homo_sapiens.GRCh38_bowtie2.4.bt2
  - Homo_sapiens.GRCh38_bowtie2.rev.1.bt2
  - Homo_sapiens.GRCh38_bowtie2.rev.2.bt2
- GTEx | [homeplage](https://gtexportal.org/home/datasets)
  - GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_reads.gct
  - GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct
- TRANSFAC  
   Processed data (by Jihun Jeung, 2021.11.08) :  
  - fimo_transfac_hg38_human_6175.tsv  : TRANSFAC human 6,715 motif data mapped on hg38 by FIMO (MEME Suite)  [it is likely to have error. please check the file]
  - fimo_transfac_hg38_human_6175.sorted.bed : TRANSFAC human 6,715 motif data mapped on hg38 by FIMO (MEME Suite) without 'chr'
  - fimo_transfac_hg38_human_6175.sorted_chr.bed : : TRANSFAC human 6,715 motif data mapped on hg38 by FIMO (MEME Suite) with 'chr'
- HPA  
  HPA (Human Protein Atlas) | [download_page](https://www.proteinatlas.org/about/download)
  - 20.1  
    Human Protein Atlas version 20.1
    - normal_tissue.tsv
    - rna_cancer_sample.tsv
 
- UCSC_Xena
  - Pan-Cancer_PANCAN [download_page](https://xenabrowser.net/datapages/?cohort=TCGA%20Pan-Cancer%20(PANCAN)&removeHub=https%3A%2F%2Fxena.treehouse.gi.ucsc.edu%3A443)
    - tcga_RSEM_gene_tpm.tsv
   
      Processed data (by Jihun Jeung, 2021.10.23) :   
    - TCGA_PanCan_geneExpression_tissue_median_tpm_INFO.txt
    - TCGA_PanCan_geneExpression_tissue_median_tpm_INFO.rda
    - TCGA_PanCan_geneExpression_tissue_median_tpm.txt
    - TCGA_PanCan_geneExpression_tissue_median_tpm.rda
  - GDC TCGA COAD [download page](https://xenabrowser.net/datapages/?cohort=GDC%20TCGA%20Colon%20Cancer%20(COAD)&removeHub=https%3A%2F%2Fxena.treehouse.gi.ucsc.edu%3A443)
    - TCGA-COAD.GDC_phenotype.tsv.gz
    - TCGA-COAD.htseq_counts.tsv.gz
    - TCGA-COAD.survival.tsv
