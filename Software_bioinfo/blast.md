# Install (RedHat Linux)
Ref :   
- https://blast.ncbi.nlm.nih.gov/doc/blast-help/downloadblastdata.html#blast-executables  
- https://www.ncbi.nlm.nih.gov/books/NBK569861/#intro_Installation.RedHat_Linux  
# To download Blast database
Ref : https://www.ncbi.nlm.nih.gov/books/NBK569850/  
```
# apt-get install perl-doc
$ cd [directory_to_download]
$ ${blast}/bin/update_blastdb.pl --showall 
$ {blast}/bin/update_blastdb.pl --decompress [database] (--num_threads [num_threads])
e.g. $ update_blastdb.pl --decompress nr
e.g. $ perl /opt/blast/2.13.0/bin/update_blastdb.pl --decompress refseq_protein --num_threads 20
```
Note that the output files from `update_bastdb` is the format of database. Therefore, building process is not required.

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
- blastn and blastp
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
- psiblast
  ```
  # the script to run in GPU1 workstation
  DATABASE="/home/data/blastDB/refseq_protein/refseq_protein"
  JOB_ID="input_structure/5u1d_1126_0001_chainA"

  module load blast

  psiblast -num_iterations 5 \
  -num_alignments 100000 \
  -num_descriptions 100000 \
  -max_hsps 100000 \
  -inclusion_ethresh 0.000001 \
  -evalue 0.000001 \
  -db $DATABASE \
  -query $JOB_ID.fasta \
  -show_gis  -outfmt 6 \
  -num_threads 1 \
  -out $JOB_ID.psi \
  -out_pssm $JOB_ID.asn1 \
  -out_ascii_pssm $JOB_ID.mat
  ```
 

  Note that generally filtering in blast is not recommended. Filtering in post-processing is prefered.
