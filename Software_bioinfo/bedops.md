# ATACseq and bedops
  - add 'chr' on chromosome name
    ```
    awk '{print "chr"$0}' input.bed > output_with_chr.bed
    ```
  - to count the number of lines (the number of peaks, the library size)
    ```
    for file_name in $(ls HMMRATAC_slurm_4_summit_process_500/*)
    do
            cat $file_name | wc -l
    done
    ```
  - to merge multiple bed files into a single bed file
    ```
    cat *.bed > merged.bed
    ```
  - to merge multiplbe bed files into a single tsv format with calculating scores
    ```
    cat *.bed | sort-bed -  | bedmap --count --echo --sum --delim '\t' - > merge.bed  
    ```
  - sorting
    Ref : https://bedops.readthedocs.io/en/latest/content/reference/file-management/sorting/sort-bed.html
    ```
    $ sort-bed --max-mem 2G [--tmpdir $PWD] reallyHugeUnsortedData.bed > reallyHugeSortedData.bed 
    ```
  - to get the features of the intersection of multiple bed files, for features/intervals that occur in at least 2 bed files
      Ref : https://www.biostars.org/p/427327/
      ```
      $ bedops --everything 1.bed 2.bed 3.bed ... N.bed \
          | bedmap --count --echo --delim '\t' - \
          | uniq \
          | awk -v OVERLAPS=2 '$1 >= OVERLAPS' \
          | cut -f2- \
          > common.bed
      ```
  - difference : the genomic regions found within the first (reference) input file, excluding regions in all other input files:
    Ref : https://bedops.readthedocs.io/en/latest/content/reference/set-operations/bedops.html  
    ![image](https://user-images.githubusercontent.com/48517782/147903426-483738af-dfb8-49ac-8a4f-a01ed90d61c1.png)  
    ```
    $ bedops --difference First.bed Second.bed > Result.bed
    ```
  - 
# bedmap
- to map map.bed file on transfac_motif.bed file
  general code
  ```
  bedmap --echo --skip-unmapped map.bed transfac_motif.bed > map_annotated.bed
  ```
  > --echo : to print each line from <ref-file (transfac_motif.bed) >
  > --skip-unmapped : remove the unmapped line (blank line)  
  > reference : map.bed 
  > motif : transfac_motif.bed
  
  running code
  ```
   bedmap --echo --echo-map-id --skip-unmapped TCGA-COAD_merge_process.sorted.bed fimo_transfac_hg38_human_6175.sorted_chr_bedops_padj0.05.bed > TCGA-COAD_merge_process_transfac_padj0.05.bed
  ```
  ```
  # load modules
  module load bedops

  # run the comparison with TRANSFAC
  echo "Start Time        = $(date)"

  bedmap --echo --echo-map-id --skip-unmapped TCGA-COAD_merge_process.sorted.bed fimo_transfac_hg38_human_6175.sorted_chr_bedops_padj0.05.bed > TCGA-COAD_merge_process_transfac_padj0.05.bed

  echo "End Time        = $(date)"
  ```
