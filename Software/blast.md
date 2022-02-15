# Install (RedHat Linux)
Ref : https://www.ncbi.nlm.nih.gov/books/NBK569861/#intro_Installation.RedHat_Linux
# Building a BLAST database
Ref : https://www.ncbi.nlm.nih.gov/books/NBK569841/
general
```
makeblastdb -in [fasta_file] -title [Title] -dbtype nucl/prot -perc_identity [0~100] -out [Output_prefix]
```
> nucl : nucleotide  
> prot : protein  

running code
```
makeblastdb -in /home/data/MIBig_2.0/mibig_prot_seqs_2.0.fasta -title "MIBig_2.0" -dbtype nucl -perc_identity 95 -out mibig_2.0.fasta
```
# Run
```
blastn -h # manual
blastn –db nt –query nt.fsa –out results.out  
```
