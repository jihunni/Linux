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
