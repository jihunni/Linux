# awk
Ref : https://recipes4dev.tistory.com/171
Ref : https://stackoverflow.com/questions/5374239/tab-separated-values-in-awk
Ref : https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=nativekim&logNo=220683899974

![image](https://user-images.githubusercontent.com/48517782/141683663-1dd3afc8-2631-4715-8b3a-99d1be3ec6f9.png)  

![image](https://user-images.githubusercontent.com/48517782/141683666-641e4467-5aa0-4a6c-8161-ef667e408c06.png)  

- general
  ``'
  awk [OPTION...] 'pattern { action1 ; action2 ; action ... ; }' [ARGUMENT...]
  awk -F [input_field_separator] 'BEGIN {first_action} {action1 ; actopn2; ,,, } END {final_action}' input_file
  OPTION
    -F        : 필드 구분 문자 지정.
    -f        : awk program 파일 경로 지정.
    -v        : awk program에서 사용될 특정 variable값 지정.
  awk program
    -f 옵션이 사용되지 않은 경우, awk가 실행할 awk program 코드 지정.
  ARGUMENT
    입력 파일 지정 또는 variable 값 지정.


  
  
  ```
- FIMO(Old) : add a specific string 'chr' to 1st column  
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
  $ awk '{print "chr"$0}' merge_fimo_result.bed > merge_fimo_result_chr.bed
  ```
  
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

  merge_fimo_result.sorted.bed
  ```
  1	10000	10012	.	48.6	-	fimo	nucleotide_motif	.	Name=V_ZNF23_02_1-;Alias=ZNF23;ID=V_ZNF23_02-ZNF23-4540-1;pvalue=1.38e-05;qvalue=1;sequence=GGGTTAGGGTTA;
  1	10000	10015	.	84.1	-	fimo	nucleotide_motif	.	Name=V_TRF1_01_1-;Alias=TRF1;ID=V_TRF1_01-TRF1-19-1;pvalue=3.86e-09;qvalue=0.0124;sequence=TTAGGGTTAGGGTTA;
  1	10006	10018	.	48.6	-	fimo	nucleotide_motif	.	Name=V_ZNF23_02_1-;Alias=ZNF23;ID=V_ZNF23_02-ZNF23-4541-1;pvalue=1.38e-05;qvalue=1;sequence=GGGTTAGGGTTA;
  1	10006	10021	.	84.1	-	fimo	nucleotide_motif	.	Name=V_TRF1_01_1-;Alias=TRF1;ID=V_TRF1_01-TRF1-20-1;pvalue=3.86e-09;qvalue=0.0124;sequence=TTAGGGTTAGGGTTA;
  1	10012	10024	.	48.6	-	fimo	nucleotide_motif	.	Name=V_ZNF23_02_1-;Alias=ZNF23;ID=V_ZNF23_02-ZNF23-4542-1;pvalue=1.38e-05;qvalue=1;sequence=GGGTTAGGGTTA;
  1	10012	10027	.	84.1	-	fimo	nucleotide_motif	.	Name=V_TRF1_01_1-;Alias=TRF1;ID=V_TRF1_01-TRF1-21-1;pvalue=3.86e-09;qvalue=0.0124;sequence=TTAGGGTTAGGGTTA;
  1	10018	10030	.	48.6	-	fimo	nucleotide_motif	.	Name=V_ZNF23_02_1-;Alias=ZNF23;ID=V_ZNF23_02-ZNF23-4543-1;pvalue=1.38e-05;qvalue=1;sequence=GGGTTAGGGTTA;
  1	10018	10033	.	84.1	-	fimo	nucleotide_motif	.	Name=V_TRF1_01_1-;Alias=TRF1;ID=V_TRF1_01-TRF1-22-1;pvalue=3.86e-09;qvalue=0.0124;sequence=TTAGGGTTAGGGTTA;
  1	10024	10036	.	48.6	-	fimo	nucleotide_motif	.	Name=V_ZNF23_02_1-;Alias=ZNF23;ID=V_ZNF23_02-ZNF23-4544-1;pvalue=1.38e-05;qvalue=1;sequence=GGGTTAGGGTTA;
  1	10024	10039	.	84.1	-	fimo	nucleotide_motif	.	Name=V_TRF1_01_1-;Alias=TRF1;ID=V_TRF1_01-TRF1-23-1;pvalue=3.86e-09;qvalue=0.0124;sequence=TTAGGGTTAGGGTTA;
  ```
  
  
  running code for FIMO output gff --> bed --> sorted bed --> awk
  ```
  awk -F '\t' '{OFS="\t" ; split($10,a,";"); split(a[1], a1, "=") ; split(a[2], a2, "=") ; split(a[3], a3, "="); split(a3[2], b3, "-"); split(a[4], a4, "="); split(a[5], a5, "="); split(a[6], a6, "="); print "chr"$1,$2,$3,$4,$5,$6,$7, $8, $9,a2[2],b3[1],a4[2],a5[2],a6[2]}' fimo_example.bed
  ```
  merge_fimo_result_chr.sorted.bed
  ```
   chr1	10000	10012	.	48.6	-	fimo	nucleotide_motif	.		Name=V_ZNF23_02_1-	V_ZNF23_02_1-	ZNF23	V_ZNF23_02-ZNF23-4540-1	1.38e-05	1	GGGTTAGGGTTA
  chr1	10000	10015	.	84.1	-	fimo	nucleotide_motif	.		Name=V_TRF1_01_1-	V_TRF1_01_1-	TRF1	V_TRF1_01-TRF1-19-1	3.86e-09	0.0124	TTAGGGTTAGGGTTA
  chr1	10006	10018	.	48.6	-	fimo	nucleotide_motif	.		Name=V_ZNF23_02_1-	V_ZNF23_02_1-	ZNF23	V_ZNF23_02-ZNF23-4541-1	1.38e-05	1	GGGTTAGGGTTA
  chr1	10006	10021	.	84.1	-	fimo	nucleotide_motif	.		Name=V_TRF1_01_1-	V_TRF1_01_1-	TRF1	V_TRF1_01-TRF1-20-1	3.86e-09	0.0124	TTAGGGTTAGGGTTA
  chr1	10012	10024	.	48.6	-	fimo	nucleotide_motif	.		Name=V_ZNF23_02_1-	V_ZNF23_02_1-	ZNF23	V_ZNF23_02-ZNF23-4542-1	1.38e-05	1	GGGTTAGGGTTA
  chr1	10012	10027	.	84.1	-	fimo	nucleotide_motif	.		Name=V_TRF1_01_1-	V_TRF1_01_1-	TRF1	V_TRF1_01-TRF1-21-1	3.86e-09	0.0124	TTAGGGTTAGGGTTA
  chr1	10018	10030	.	48.6	-	fimo	nucleotide_motif	.		Name=V_ZNF23_02_1-	V_ZNF23_02_1-	ZNF23	V_ZNF23_02-ZNF23-4543-1	1.38e-05	1	GGGTTAGGGTTA
  chr1	10018	10033	.	84.1	-	fimo	nucleotide_motif	.		Name=V_TRF1_01_1-	V_TRF1_01_1-	TRF1	V_TRF1_01-TRF1-22-1	3.86e-09	0.0124	TTAGGGTTAGGGTTA
  chr1	10024	10036	.	48.6	-	fimo	nucleotide_motif	.		Name=V_ZNF23_02_1-	V_ZNF23_02_1-	ZNF23	V_ZNF23_02-ZNF23-4544-1	1.38e-05	1	GGGTTAGGGTTA
  chr1	10024	10039	.	84.1	-	fimo	nucleotide_motif	.		Name=V_TRF1_01_1-	V_TRF1_01_1-	TRF1	V_TRF1_01-TRF1-23-1	3.86e-09	0.0124	TTAGGGTTAGGGTTA
  ```
- FIMO (new) :   Fimo tsv --> Fimo bed
  Fimo.tsv
  ```
    d        motif_alt_id    sequence_name   start   stop    strand  score   p-value q-value matched_sequence
  V_AP4_01        AP-4    1       155294767       155294784       +       25.4309 7.38e-12        0.0435  AGAGCCAGCTGCGGTCAG
  V_P53_01        p53     1       181135142       181135161       +       32.8776 2.47e-11        0.0728  AGGCATGCCCGGGCATGTCT
  V_P53_01        p53     1       181135142       181135161       -       32.8776 2.47e-11        0.0728  AGACATGCCCGGGCATGCCT
  V_MYOGNF1_01    myogenin_/_NF-1 15      80033659        80033687        +       29.8807 3.47e-11        0.205   TGCCTCTCTAATCTGGCACCCTGCCAGCC
  V_YY1_02        YY1     8       72404808        72404827        -       24.789  4.09e-11        0.00691 TCTCGGCCATCTTGGCTCCT
  V_YY1_02        YY1     1       17054010        17054029        +       24.6147 5.18e-11        0.00691 CCGCCGCCATCTTGGCTCCT
  ```
  
  Fimo.bed
  ```
  $ awk '{OFS="\t" ; print "chr"$3,$4,$5,$1,$8,$6,$10,$2,$7,$9}' fimo_transfac_hg38_human_6175.tsv > fimo_transfac_hg38_human_6175.bed
  
  chr1	155294767	155294784	V_AP4_01	7.38e-12	+	AGAGCCAGCTGCGGTCAG	AP-4	25.4309	0.0435
  chr1	181135142	181135161	V_P53_01	2.47e-11	+	AGGCATGCCCGGGCATGTCT	p53	32.8776	0.0728
  chr1	181135142	181135161	V_P53_01	2.47e-11	-	AGACATGCCCGGGCATGCCT	p53	32.8776	0.0728
  chr15	80033659	80033687	V_MYOGNF1_01	3.47e-11	+	TGCCTCTCTAATCTGGCACCCTGCCAGCC	myogenin_/_NF-1	29.8807	0.205
  chr8	72404808	72404827	V_YY1_02	4.09e-11	-	TCTCGGCCATCTTGGCTCCT	YY1	24.789	0.00691
  chr1	17054010	17054029	V_YY1_02	5.18e-11	+	CCGCCGCCATCTTGGCTCCT	YY1	24.6147	0.00691

  ```
  
  FIMO in `bedops` format
  ```
  awk '{split($10,a,";"); split(a[1],a1,"="); split(a[2],a2,"="); split(a[3],a3,"=");split(a[5],a5,"="); split(a[6],a6,"="); print $1,'\t',$2,'\t',$3,substr(a1[2],1,length(a1[2])-1),'\t',a5[2],'\t',$6,'\t',a6[2]}' transfac_ex.tsv
  ```
  ```
  chr1  10000  10012 V_ZNF23_02_1  1  -  GGGTTAGGGTTA
  chr1  10000  10015 V_TRF1_01_1  0.0124  -  TTAGGGTTAGGGTTA
  chr1  10006  10018 V_ZNF23_02_1  1  -  GGGTTAGGGTTA
  chr1  10006  10021 V_TRF1_01_1  0.0124  -  TTAGGGTTAGGGTTA
  chr1  10012  10024 V_ZNF23_02_1  1  -  GGGTTAGGGTTA
  chr1  10012  10027 V_TRF1_01_1  0.0124  -  TTAGGGTTAGGGTTA
  chr1  10018  10030 V_ZNF23_02_1  1  -  GGGTTAGGGTTA
  chr1  10018  10033 V_TRF1_01_1  0.0124  -  TTAGGGTTAGGGTTA
  chr1  10024  10036 V_ZNF23_02_1  1  -  GGGTTAGGGTTA
  chr1  10024  10039 V_TRF1_01_1  0.0124  -  TTAGGGTTAGGGTTA
  chr1  10030  10042 V_ZNF23_02_1  1  -  GGGTTAGGGTTA
  chr1  10030  10045 V_TRF1_01_1  0.0124  -  TTAGGGTTAGGGTTA
  chr1  10036  10048 V_ZNF23_02_1  1  -  GGGTTAGGGTTA
  chr1  10036  10051 V_TRF1_01_1  0.0124  -  TTAGGGTTAGGGTTA
  chr1  10042  10054 V_ZNF23_02_1  1  -  GGGTTAGGGTTA
  chr1  10042  10057 V_TRF1_01_1  0.0124  -  TTAGGGTTAGGGTTA

  ```
