# Install (RedHat Linux)
Ref : https://www.ncbi.nlm.nih.gov/books/NBK569861/#intro_Installation.RedHat_Linux
# Building a BLAST database
Ref : https://www.ncbi.nlm.nih.gov/books/NBK569841/
general
```
makeblastdb -in [fasta_file] -title [Title] -dbtype nucl/prot  -out [Output_prefix]
```
> nucl : nucleotide  
> prot : protein  

running code
```
makeblastdb -in /home/data/MIBig_2.0/mibig_prot_seqs_2.0.fasta -title "MIBig_2.0" -dbtype nucl  -out mibig_2.0.fasta
```
# Run
general
```
blastn -h # manual
blastn –db nt –query nt.fsa -perc_identity [0~100] –out results.out  
```

running code
```
blastn -db mibig_2.0.fasta -query GCF_000005845.2_ASM584v2_genomic.fna -perc_identity 1  -out GCF_000005845.2_ASM584v2_genomic.out
```
