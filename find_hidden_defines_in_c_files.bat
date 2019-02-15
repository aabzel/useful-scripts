#
# Script to search for #defines in .c files
# define in the .c file is the key to errors during the project migration
# defines are better insert in the .h file for the following reasons:
# 1) it is easier to find it and edit them if necessary
# 2) and also these define can be used in other files.

grep -r "#define" | grep ".c:"  | grep -v "unwanted_word"> defines_in_c_files.txt

var="#define"
fileExtention="*.c"
unwantedWord1="Drivers"
unwantedWord2="Middlewares"
grep $var $(find -name $fileExtention ) | grep -v $unwantedWord1| grep -v $unwantedWord2 > c_files_with_defines_in_curr_dir.txt
echo "rule violation: defines in .c file"
cat c_files_with_defines_in_curr_dir.txt


