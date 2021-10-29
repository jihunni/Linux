#######################################################################################
# The bash script moves the files on subdirectory with a specific file extension      #
# into the current directory.                                                         #
#######################################################################################  

for directory_name in $(ls -d $PWD/*/); do #iterate all subdirectory
        #echo $directory_name ;

        # select the file (here, file is bam file) to move
        file_name=$(ls ${directory_name}/*.bam)
        file_name=${file_name%.*m} #remove '.bam' on file_name
        echo $file_name ;

        # move file onto upper directory
        mv ${file_name}.bam ./
        mv ${file_name}.bai ./
done
