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
