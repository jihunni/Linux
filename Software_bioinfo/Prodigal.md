# Prodigal
  ```
  $ prodigal -f gff -i /home/data/ref_genome/Escherichia_coli_GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna -a Escherichia_coli.faa -o output
  ```
  > -i:  Specify FASTA/Genbank input file (default reads from stdin). `gz` format is not acceptable.  
  > -f:  Select output format (gbk, gff, or sco).  Default is gbk.  
  > -a : Write protein translations to the selected file.  
  > -o : Specify output file (default writes to stdout).   
 
 Escherichia_coli.faa
 ```
 >NC_000913.3_2 # 337 # 2799 # 1 # ID=1_2;partial=00;start_type=ATG;rbs_motif=GGAG/GAGG;rbs_spacer=5-10bp;gc_cont=0.531
  MRVLKFGGTSVANAERFLRVADILESNARQGQVATVLSAPAKITNHLVAMIEKTISGQDA
  LPNISDAERIFAELLTGLAAAQPGFPLAQLKTFVDQEFAQIKHVLHGISLLGQCPDSINA
  ALICRGEKMSIAIMAGVLEARGHNVTVIDPVEKLLAVGHYLESTVDIAESTRRIAASRIP
  ADHMVLMAGFTAGNEKGELVVLGRNGSDYSAAVLAACLRADCCEIWTDVDGVYTCDPRQV
  PDARLLKSMSYQEAMELSYFGAKVLHPRTITPIAQFQIPCLIKNTGNPQAPGTLIGASRD
  EDELPVKGISNLNNMAMFSVSGPGMKGMVGMAARVFAAMSRARISVVLITQSSSEYSISF
  CVPQSDCVRAERAMQEEFYLELKEGLLEPLAVTERLAIISVVGDGMRTLRGISAKFFAAL
  ARANINIVAIAQGSSERSISVVVNNDDATTGVRVTHQMLFNTDQVIEVFVIGVGGVGGAL
  LEQLKRQQSWLKNKHIDLRVCGVANSKALLTNVHGLNLENWQEELAQAKEPFNLGRLIRL
  VKEYHLLNPVIVDCTSSQAVADQYADFLREGFHVVTPNKKANTSSMDYYHQLRYAAEKSR
  RKFLYDTNVGAGLPVIENLQNLLNAGDELMKFSGILSGSLSYIFGKLDEGMSFSEATTLA
  REMGYTEPDPRDDLSGMDVARKLLILARETGRELELADIEIEPVLPAEFNAEGDVAAFMA
  NLSQLDDLFAARVAKARDEGKVLRYVGNIDEDGVCRVKIAEVDGNDPLFKVKNGENALAF
  YSHYYQPLPLVLRGYGAGNDVTAAGVFADLLRTLSWKLGV
 ```
 
 output
 ```
 #gff-version  3
  # Sequence Data: seqnum=1;seqlen=4641652;seqhdr="NC_000913.3 Escherichia coli str. K-12 substr. MG1655, complete genom
  e"
  # Model Data: version=Prodigal.v2.6.3;run_type=Single;model="Ab initio";gc_cont=50.79;transl_table=11;uses_sd=1
  NC_000913.3     Prodigal_v2.6.3 CDS     3       98      1.2     +       0       ID=1_1;partial=10;start_type=Edge;rbs_
  motif=None;rbs_spacer=None;gc_cont=0.427;conf=56.57;score=1.15;cscore=-1.57;sscore=2.72;rscore=0.00;uscore=0.00;tscore
  =3.22;
  NC_000913.3     Prodigal_v2.6.3 CDS     337     2799    336.9   +       0       ID=1_2;partial=00;start_type=ATG;rbs_m
  otif=GGAG/GAGG;rbs_spacer=5-10bp;gc_cont=0.531;conf=99.99;score=336.87;cscore=320.95;sscore=15.93;rscore=11.24;uscore=
  1.40;tscore=3.94;
 ```
