#
# Script to search for #defines in .c files
# define in the .c file is the key to errors during the project migration
# defines are better insert in the .h file for the following reasons:
# 1) it is easier to find it and edit them if necessary
# 2) and also these define can be used in other files.

grep -r "#define" | grep ".c:" > defines_in_c_files.txt
