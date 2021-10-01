# basic grammar
## variable
```
string_1='abcdef'
echo ${string_1}

string_2='ghijk'
echo ${string_2}
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

file name w/o extension
```
for f in $(ls *_*_forward_paired.fastq); do
        #remove '_forward_paired.fastq'
        echo ${f%_*_forward_paired.fastq} ;

done

```

## merge fastq
```
cat file*.fastq > bigfile.fastq
```
