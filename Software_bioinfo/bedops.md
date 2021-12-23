# bedops
  - to merge multiple bed files into a single bed file
    ```
    cat *.bed > merged.bed
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
# bedmap
-
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
