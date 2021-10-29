# basic grammar
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
- https://devhints.io/bash

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
```
for file_name in $(ls *.fastq); do
        echo ${file_name} ;
done

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

```


file name w/o extension
```
for f in $(ls *_*_fohttps://wiki.kldp.org/HOWTO/html/Adv-Bash-Scr-HOWTO/string-manipulation.htmlrward_paired.fastq); do
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

## merge fastq
```
cat file*.fastq > bigfile.fastq
```
