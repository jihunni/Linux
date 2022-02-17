# basic grammar
# redirection
- `>`: 명령어 뒤에 나오는 파일에 쓸 때 사용(=write or overwrite)
- `>>`: 명령어 뒤에 나오는 파일에 추가할 때 사용(=append)

# SheBang
Ref : https://bcp0109.tistory.com/343  

general  
```
#!<interpreter> [optional-arg]
```

running code (absolute path)  
```
#!/bin/sh
#!/bin/bash
#!/usr/bin/pwsh
#!/usr/bin/env python3
```

running code ()
```
#! /usr/bin/env bash
#! /usr/bin/env python
```

## variable
```
string_1='abcdef'
echo ${string_1}

string_2='ghijk'
echo ${string_2}

For list,
echo ${list[0]}
```
> warning! no space bewteen equality
## operator
ref : https://linuxhint.com/bash_operator_examples/

## array
ref : http://blog.redjini.com/282

## Brace expression
```
$ {1..5} 
1 2 3 4 5

$ {string_1,string_2} 
abcdef ghijk
```
> warning! no space between comma

reference : 
- https://wiki.bash-hackers.org/syntax/expansion/brace
- 
## if else
```
if [command]
then
	[command]

elif
then
	[command]

else
	[command]
fi
```

reference : 
- https://devhints.io/bash. 

case
ref : https://hbase.tistory.com/23. 

# save the output of a function into a variable
```
variable_name=$(command [option ...] arg1 arg2 ...)
```
reference : https://www.tecmint.com/assign-linux-command-output-to-variable/


# file search
```
# search files that does not contain '_bak' on current directory
find . -maxdepth 1 -mindepth 1 ! -name '*_bak'
```
reference: https://stackoverflow.com/questions/11043878/linux-search-file-based-on-file-name-pattern

count the number of files
	```
	ls | wc -l
	```

# create folder
```
output_directory='ex1234'
if test -d "${output_directory}"
then
        echo "output directory does already exist. Nothing happen"
        cd "${output_directory}"
else
        echo "output directory does not exist and create a new directory"
        mkdir ${output_directory}

fi
```

# file iteration
iteration with a file list
```
# to change a directory temporarily
pushd [directory]
echo 'directory is reset'

for file_name in $(ls *.fastq); do
        echo ${file_name} ;
	
	file_name="${file_name##*/}" # to get fileName with extension (to remove path)
        file_name="${file_name%.*}" # to remove file extenstion
        echo ${file_name} ;

	
done

# to recover the directory
popd
echo 'directory is reset'

```

iteration with reading a file contents
```
#!/bin/bash
# download fasta file from a input list
fileName=/home/data/ref_genome/bacterial_genome/RefSeq_bacterial_FTPpath.txt
while read p; do
        echo "$p"
        wget $p
done < $fileName
```


```
#check whether it works
ls ./{01_ENCSR496PPU,02_ENCSR600ZHS,03_ENCSR491VXJ,04_ENCSR970UNF,05_ENCSR355SGJ}/

chmod 755 ./{01_ENCSR496PPU,02_ENCSR600ZHS,03_ENCSR491VXJ,04_ENCSR970UNF,05_ENCSR355SGJ}/bwa-mem2.sh
#./{01_ENCSR496PPU,02_ENCSR600ZHS,03_ENCSR491VXJ,04_ENCSR970UNF,05_ENCSR355SGJ}/bwa-mem2.sh

for directory in {01_ENCSR496PPU,02_ENCSR600ZHS,03_ENCSR491VXJ,04_ENCSR970UNF,05_ENCSR355SGJ}
do
        PWD=/home/jihun/data/ENCODE/${directory}
        echo $PWD
        export PWD="/home/jihun/data/ENCODE/${directory}"
        $PWD/bwa-mem2.sh
done
~     
```
iterate subdirectory:  
https://stackoverflow.com/questions/14352290/listing-only-directories-using-ls-in-bash
```
ls */
ls -d */
```

substring :  
https://wiki.kldp.org/HOWTO/html/Adv-Bash-Scr-HOWTO/string-manipulation.html
```
${string%%substring}
$string의 뒷 부분에서부터 가장 길게 일치하는 $substring을 삭제.

stringZ=abcABC123ABCabc
#                    ||
#        |------------|

echo ${stringZ%b*c}      # abcABC123ABCa
# $stringZ의 뒷 부분부터 계산해서 'b'와 'c' 사이에서 가장 짧게 일치하는 부분을 삭제.

echo ${stringZ%%b*c}     # a
# $stringZ의 뒷 부분부터 계산해서 'b'와 'c' 사이에서 가장 길게 일치하는 부분을 삭제.


# remove file extension
file_name=${file_name%.*m} #remove '.bam' on file_name
```


file name w/o extension
Ref: https://wiki.kldp.org/HOWTO/html/Adv-Bash-Scr-HOWTO/string-manipulation.html
```
${string%substring}
$string의 뒷 부분에서부터 가장 짧게 일치하는 $substring을 삭제.

${string%%substring}
$string의 뒷 부분에서부터 가장 길게 일치하는 $substring을 삭제.

stringZ=abcABC123ABCabc
#                    ||
#        |------------|

echo ${stringZ%b*c}      # abcABC123ABCa
# $stringZ의 뒷 부분부터 계산해서 'b'와 'c' 사이에서 가장 짧게 일치하는 부분을 삭제.

echo ${stringZ%%b*c}     # a
# $stringZ의 뒷 부분부터 계산해서 'b'와 'c' 사이에서 가장 길게 일치하는 부분을 삭제.
```

```
for f in $(ls *_*_forward_paired.fastq); do
        #remove '_forward_paired.fastq'
        echo ${f%_*_forward_paired.fastq} ;

done

```


list file name
```
file_name_list=$(ls data/*.bam)

#similarly, for loop
IN=$file_name_list
arrIN=(${IN// / })
file_name=${arrIN[0]}
```
substring ref : https://wiki.kldp.org/HOWTO/html/Adv-Bash-Scr-HOWTO/string-manipulation.html  


```
## parameters
input_directory="${PWD}/12_ENCSR548QCP"
input_output_array=("ENCFF138HKP.fastq.gz ENCFF565VHZ.fastq.gz NCLB246GTQ") #(input1 input2 output_Name)
triming_seq="/opt/trimmomatic/0.39/adapters/NexteraPE-PE.fa"
output_directory="$PWD/01_ENCSR496PPU/skewer"

# run program
echo $input_directory
for list_array in "${input_output_array[@]}" 
do
	IFS=' ' read -r -a list <<< "$list_array"
		# split string with deliminator ' ' and save in an array
		# "abc def gqqq" --> list[0], list[1], list[2]
	#list=$(echo ${list_array} | tr " " "\n")

	#echo "list0"
	#echo ${list[0]}
	#echo "list1"
	#echo ${list[1]}
	#echo "list2"
	#echo ${list[2]}
	input1=${list[0]}
	input2=${list[1]}
	output_filename=${list[2]}
		
	/program -x ${triming_seq} -o ${output_directory}/${output_filename} $input_directory/${input1} $input_directory/${input2}
```

## merge fastq
Ref : https://shlee1990.tistory.com/585 : `cat` 명령어   
Ref: https://do-study.tistory.com/75 : `cat` arguemnt처리  
```
# merge all of contents
cat file1 file2 file3
cat file*.fastq > bigfile.fastq
ls [파일명패턴] | xargs cat > [결과파일명]
```

Ref : https://jhnyang.tistory.com/287 : `sed` 명령어
```
sed -n `1p` filename
sed -n `1,3p` filename
sed -n `3,$p` filename

```
> -n : to print only the desired part  
> p : 'print'   
> comma determine the range of print
> 1.3 : 1~3
> 3,$ : 3~end of the line
> 

# to measure performance
```
echo "Start Time        = $(date)"
echo "End Time        = $(date)"
```
