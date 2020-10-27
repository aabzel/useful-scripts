#!/bin/bash
(grep -r "CSRC_MISRA" | grep "\.c" | grep -oP "\w+\.c" | sort | uniq) >  misra_files.txt

" "> misra_files_abs_path.txt 

while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    find -name "${LINE}" >> misra_files_abs_path.txt 
done < misra_files.txt

" "> misra_files_len_cnt.txt 
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    cat "${LINE}" | wc -l >> misra_files_len_cnt.txt 
done < misra_files_abs_path.txt

awk '{ sum += $1 } END { print sum }'  misra_files_len_cnt.txt