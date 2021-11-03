#########################
# file inclusion check by comparing two files containing file names
#
# example of input file:
# 0b069d38-db2f-4d3d-99aa-0533e7e77b19_atacseq_gdc_realn.bam  
# 7e71227a-8d14-4457-be68-a4529eda11de_atacseq_gdc_realn.bam
# 150b94f2-7364-4440-a83f-f6320cc2c113_atacseq_gdc_realn.bam  
# 827122b7-d85e-4b7e-bf91-0667e7c577c9_atacseq_gdc_realn.bam
# 168410db-0f76-4abd-8683-37245b4a3fd4_atacseq_gdc_realn.bam  
# 8b1082ef-9799-4955-b608-2c19234eb900_atacseq_gdc_realn.bam
# 180e986e-2f5f-4885-b53b-b84251a691e4_atacseq_gdc_realn.bam  
#########################

library(readr)

# load filenames
filename_1 = read_tsv('~/Documents/linux/filename_1', col_names = FALSE) 
filename_2 = read_tsv('~/Documents/linux/filename_2', col_names = FALSE)

#check file inclusion
table(substr(filename_1$X1, start=1, stop=54) %in% substr(filename_2$X1, start=1, stop=54))

inclusion = substr(filename_1$X1, start=1, stop=54) %in% substr(filename_2$X1, start=1, stop=54)
filename_1$X1[!inclusion]
