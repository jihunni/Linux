# Install (RedHat Linux)
Ref :   
- https://blast.ncbi.nlm.nih.gov/doc/blast-help/downloadblastdata.html#blast-executables  
- https://www.ncbi.nlm.nih.gov/books/NBK569861/#intro_Installation.RedHat_Linux  
# To download Blast database
Ref : https://www.ncbi.nlm.nih.gov/books/NBK569850/  
```
$ cd [directory_to_download]
$ ${blast}/bin/update_blastdb.pl --showall 
$ {blast}/bin/update_blastdb.pl --decompress [database]
e.g. $ update_blastdb.pl --decompress nr
```

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
Note that fasta file and index file sholud be located in same direction.

# Run
general
```
blastn -h # manual
blastn –db [DB_title] –query nt.fsa -perc_identity [0~100] -outfmt 6 -out results.out  
blastp –db [DB_title] –query nt.fsa -outfmt 6 -num_threads [num_threads] -out results.out  

```

running code
```
blastn -db mibig_2.0.fasta -query GCF_000005845.2_ASM584v2_genomic.fna -perc_identity 1  -outfmt 6 -out GCF_000005845.2_ASM584v2_genomic.out
$ blastp -db ~/data/blastDB_mibig2.0_prot/mibig_prot_seqs.fasta -query ~/data/prodigal/Escherichia_coli.faa -outfmt 7 -num_threads 12 -out ~/data/prodigal/Escherichia_coli.blast_7
```

Note that generally filtering in blast is not recommended. Filtering in post-processing is prefered.
