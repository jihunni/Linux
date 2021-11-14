# awk
Ref : https://recipes4dev.tistory.com/171

- add a specific string 'chr' to 1st column  
  merge_fimo_result.sorted.bed  
  ```
  $ tail merge_fimo_result.sorted.bed
  Y	56887805	56887817	.	59.8	-	fimo	nucleotide_motif	.	Name=V_IPF1_05_Y-;Alias=ipf1;ID=V_IPF1_05-ipf1-443-Y;pvalue=1.04e-06;qvalue=0.176;sequence=AATCATTAAAAA;
  Y	56887826	56887841	.	53.8	-	fimo	nucleotide_motif	.	Name=V_TBX5CSX_Q5_Y-;Alias=Tbx5:csx;ID=V_TBX5CSX_Q5-Tbx5:csx-678-Y;pvalue=4.12e-06;qvalue=0.261;sequence=TCATCTCACACCAGT;
  Y	56887828	56887838	.	56.4	+	fimo	nucleotide_motif	.	Name=V_ZNF99_06_Y+;Alias=ZNF99;ID=V_ZNF99_06-ZNF99-554-Y;pvalue=2.27e-06;qvalue=0.26;sequence=TGGTGTGAGA;
  Y	56887854	56887872	.	56.6	+	fimo	nucleotide_motif	.	Name=V_POU3F1_Q6_Y+;Alias=POU3F1;ID=V_POU3F1_Q6-POU3F1-640-Y;pvalue=2.16e-06;qvalue=0.185;sequence=TTTTGATTTGCATTTCTC;
  Y	56887856	56887869	.	55.7	+	fimo	nucleotide_motif	.	Name=V_POU2F2_08_Y+;Alias=Oct-2;ID=V_POU2F2_08-Oct-2-904-Y;pvalue=2.67e-06;qvalue=0.178;sequence=TTGATTTGCATTT;
  Y	56887857	56887868	.	61.3	+	fimo	nucleotide_motif	.	Name=V_OCT1_Q5_01_Y+;Alias=Oct-1;ID=V_OCT1_Q5_01-Oct-1-506-Y;pvalue=7.4e-07;qvalue=0.0641;sequence=TGATTTGCATT;
  Y	56887857	56887869	.	59.2	+	fimo	nucleotide_motif	.	Name=V_POU2F1_Q6_Y+;Alias=POU2F1;ID=V_POU2F1_Q6-POU2F1-957-Y;pvalue=1.21e-06;qvalue=0.0822;sequence=TGATTTGCATTT;
  Y	56887857	56887871	.	64.3	-	fimo	nucleotide_motif	.	Name=V_OCT2_Q6_Y-;Alias=oct-2;ID=V_OCT2_Q6-oct-2-534-Y;pvalue=3.68e-07;qvalue=0.0429;sequence=AGAAATGCAAATCA;
  Y	56887858	56887869	.	55.2	-	fimo	nucleotide_motif	.	Name=V_OCAB_Q6_Y-;Alias=OCA-B;ID=V_OCAB_Q6-OCA-B-629-Y;pvalue=3e-06;qvalue=0.331;sequence=AAATGCAAATC;
  Y	56887870	56887882	.	48.7	-	fimo	nucleotide_motif	.	Name=V_ZNF567_01_Y-;Alias=znf567;ID=V_ZNF567_01-znf567-690-Y;pvalue=1.36e-05;qvalue=1;sequence=CTGGCCATCAGA;
  ```
  
  running code
  ```
  $ awk -F ';' '{ FS="\t "} {print "chr"$1 $2 $3 $4 $5 $6 $7 $8 $9 $10 $11}' merge_fimo_result.bed > merge_fimo_result_chr.bed
  chr1	10000	10012	.	48.6	-	fimo	nucleotide_motif	.	Name=V_ZNF23_02_1-Alias=ZNF23ID=V_ZNF23_02-ZNF23-4540-1pvalue=1.38e-05qvalue=1sequence=GGGTTAGGGTTA
  chr1	10000	10015	.	84.1	-	fimo	nucleotide_motif	.	Name=V_TRF1_01_1-;Alias=TRF1;ID=V_TRF1_01-TRF1-19-1;pvalue=3.86e-09;qvalue=0.0124;sequence=TTAGGGTTAGGGTTA;
  chr1	10006	10018	.	48.6	-	fimo	nucleotide_motif	.	Name=V_ZNF23_02_1-;Alias=ZNF23;ID=V_ZNF23_02-ZNF23-4541-1;pvalue=1.38e-05;qvalue=1;sequence=GGGTTAGGGTTA;
  chr1	10006	10021	.	84.1	-	fimo	nucleotide_motif	.	Name=V_TRF1_01_1-;Alias=TRF1;ID=V_TRF1_01-TRF1-20-1;pvalue=3.86e-09;qvalue=0.0124;sequence=TTAGGGTTAGGGTTA;
  chr1	10012	10024	.	48.6	-	fimo	nucleotide_motif	.	Name=V_ZNF23_02_1-;Alias=ZNF23;ID=V_ZNF23_02-ZNF23-4542-1;pvalue=1.38e-05;qvalue=1;sequence=GGGTTAGGGTTA;
  chr1	10012	10027	.	84.1	-	fimo	nucleotide_motif	.	Name=V_TRF1_01_1-;Alias=TRF1;ID=V_TRF1_01-TRF1-21-1;pvalue=3.86e-09;qvalue=0.0124;sequence=TTAGGGTTAGGGTTA;
  chr1	10018	10030	.	48.6	-	fimo	nucleotide_motif	.	Name=V_ZNF23_02_1-;Alias=ZNF23;ID=V_ZNF23_02-ZNF23-4543-1;pvalue=1.38e-05;qvalue=1;sequence=GGGTTAGGGTTA;
  chr1	10018	10033	.	84.1	-	fimo	nucleotide_motif	.	Name=V_TRF1_01_1-;Alias=TRF1;ID=V_TRF1_01-TRF1-22-1;pvalue=3.86e-09;qvalue=0.0124;sequence=TTAGGGTTAGGGTTA;
  chr1	10024	10036	.	48.6	-	fimo	nucleotide_motif	.	Name=V_ZNF23_02_1-;Alias=ZNF23;ID=V_ZNF23_02-ZNF23-4544-1;pvalue=1.38e-05;qvalue=1;sequence=GGGTTAGGGTTA;
  chr1	10024	10039	.	84.1	-	fimo	nucleotide_motif	.	Name=V_TRF1_01_1-;Alias=TRF1;ID=V_TRF1_01-TRF1-23-1;pvalue=3.86e-09;qvalue=0.0124;sequence=TTAGGGTTAGGGTTA;
  ```
