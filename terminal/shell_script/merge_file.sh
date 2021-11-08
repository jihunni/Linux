# merge all multiple output files from FIMO in a one tsv
# Some output files are located in 'fimo_output1' directory and the other output files are located in 'fimo_output2'

output_fileName='merge_fimo_result_5.tsv'

# header
cat header_file.tsv >  ${output_fileName}

# iterate
for file_name in $(ls fimo_output1|grep fimo_); do
        echo ${file_name} ;
        #cat fimo_output1/${file_name}/fimo.tsv >> merge_fimo_result_3.tsv
                #problem : the first header line should be removed
        sed -n '2,$p' fimo_output1/${file_name}/fimo.tsv >>  ${output_fileName}
done


for file_name in $(ls fimo_output2|grep fimo_); do
        echo ${file_name} ;
        sed -n '2,$p' fimo_output2/${file_name}/fimo.tsv >>  ${output_fileName}
done
