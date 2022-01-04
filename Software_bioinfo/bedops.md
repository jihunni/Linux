# ATACseq and bedops
  - add 'chr' on chromosome name
    ```
    awk '{print "chr"$0}' input.bed > output_with_chr.bed
    ```
  - to count the number of lines (the number of peaks)
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
  bedmap --echo --skip-unmapped transfac_motif.bed map.bed > map_annotated.bed
  ```
  > --echo : to print each line from <ref-file (transfac_motif.bed) >
  > --skip-unmapped : remove the unmapped line (blank line)  
  
  running code
  ```
  bedmap --echo --skip-unmapped /home/jihun/data/motif/merge_fimo_result_chr.bed summits_difference_TCGA_ENCODE.bed > summits_difference_TCGA_ENCODE_transfac.bed
  ```
  
  It does not work!
  ```
  # load module
  module load bedops

  #input
  reference_file='reference_bedmap_motifs_2.bed'
  data_file='reference_bedmap_map_2.bed'
  #data_file='/home/jihun/data/TCGA-COAD_ATAC/HMMRATAC_slurm_2/eedca752-bfb9-4a73-a800-613aa1f5fe27_atacseq_gdc_realn_summits.sorted.bed'

  #output
  output_file='bedmap_example.bed'
  # --echo-map flag gathers overlapping mapped elements for every reference elements
  bedmap --echo  --mean ${reference_file} ${data_file} > $output_file
  #bedmap --chrom chr21 --skip-unmapped --echo-map ${reference_file} ${data_file} > example_out.bed
  ```
