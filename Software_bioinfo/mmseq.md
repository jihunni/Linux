# MMseq
- guide : https://mmseqs.com/latest/userguide.pdf
- 
# easy-cluster
- options :
  - `--min-seq-id` : a minimum sequence identity (--min-seq-id [0,1]) with option --alignment-mode 3 defined
as the number of identical aligned residues divided by the number of aligned columns including
internal gap columns, or, by default, defined by a highly correlated measure, the equivalent
similarity score of the local alignment (including gap penalties) divided by the maximum of the
lengths of the two locally aligned sequence segments. The score per residue equivalent to a
certain sequence identity is obtained by a linear regression using thousands of local alignments
as training set.
  - `-c` : a minimum coverage (option -c [0,1], which is defined by the number of aligned residue
pairs divided by either the maximum of the length of query/centre and target/non-centre
sequences alnRes/max(qLen,tLen) (default mode, --cov-mode 0), or by the length of
the target/non-centre sequence alnRes/tLen (--cov-mode 1), or by the length of the
query/centre alnRes/qLen (--cov-mode 2). Read more about how coverage is computed in
section How to set the right alignment coverage to cluster
  - `--cov-mode` :
      ![Screenshot from 2024-12-05 15-18-16](https://github.com/user-attachments/assets/0159b389-6efa-4415-8753-f2566beeacac)

```
#!/bin/bash
#SBATCH -p cpu
#SBATCH -J mmseqs_iiab
#SBATCH --time=02:00:00
#SBATCH -c 8
#SBATCH --mem=12g
#SBATCH -o digs.log
#SBATCH -e digs.log

fasta_input_path='/home/jeung/project/heme/distillation/pred_data_len_100_800.fa'
cluster_output_prefix='/home/jeung/project/heme/distillation/mmseq_cluster/pred_data_len_100_800'
tmp='/net/scratch/jeung/tmp/'
nproc=12
/software/mmseqs2/bin/mmseqs easy-cluster $fasta_input_path ${cluster_output_prefix} $tmp --min-seq-id 0.4 -c 0.8 --cov-mode 0 --threads $nproc
```
