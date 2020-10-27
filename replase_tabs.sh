#!/bin/bash
" ">abs_path_files_with_tabs.txt
(find . -type f -name "*.c" -exec grep -l -P "\t" {} +) >>  abs_path_files_with_tabs.txt
(find . -type f -name "*.h" -exec grep -l -P "\t" {} +) >>  abs_path_files_with_tabs.txt

while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    sed -i 's/\t/    /g'  "${LINE}" 
done < abs_path_files_with_tabs.txt

abs_path_files_with_tabs.txt
