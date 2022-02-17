# HMMER
## hmmscan
general code
```
$ module load HMMER
$ hmmscan --cpu [parallel_NumCPU] --domE [E-value threshold] -o [output] [hmmDB] [SeqFile] 
```

running code
```
$ module load HMMER
$ hmmscan -h 
$ hmmscan --cpu 30 -o output --tblout output.tblout  /home/data/Pfam35.0/Pfam-A.hmm /home/jihun/data/prodigal/Escherichia_coli.faa
```
