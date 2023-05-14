# This program collects the score files from ab initio protein folding simulation and plot the rms-total score graph.
INPUT_DIRECTORY='output'
OUTPUT_FILE='score_collection.fsc'

first_iter=0
rm $OUTPUT_FILE
for file_name in $(ls $INPUT_DIRECTORY/*/score.fsc); do
        # to print the header
        if [ $first_iter = 0 ] ; then
                # to print the first line (header)
                sed -n '1p' $file_name >> $OUTPUT_FILE ;
                (( first_iter ++ ))  
        fi  

        # to write the contents except the first line (header)
        sed '1d' $file_name >> $OUTPUT_FILE ;
done

# to plot
echo 'x_axis \t y_axis'
sed -n '1p' score_collection.fsc | awk {'print $27 "\t" $2'}
# echo $(( sed -n '1p' score_collection.fsc | awk {'print $27 "\t" $2'} ))
sed '1d' score_collection.fsc | awk {'print $27 "\t" $2'} | sort -nk 1 > score_collection_rms_score.dat

# plotting with gnuplot in Linux
#printf "plot 'score_collection_rms_score.dat' \n" | gnuplot
gnuplot -e "set terminal png size 900,600; set output 'xyz.png' ; plot 'score_collection_rms_score.dat' title 'data' "
