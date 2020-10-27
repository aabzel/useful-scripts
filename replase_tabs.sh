#!/bin/bash
" ">abs_path_files_with_tabs.txt
#(find . -type f -name "*.c" -exec grep -l -P "\t" {} +)

(find . -type f -name "*convert*.c" -exec grep -l -P "\t" {} +) >>  abs_path_files_with_tabs.txt
(find . -type f -name "*shell*.c" -exec grep -l -P "\t" {} +) >>  abs_path_files_with_tabs.txt
(find . -type f -name "*board*.c" -exec grep -l -P "\t" {} +) >>  abs_path_files_with_tabs.txt
(find . -type f -name "*lin*.c" -exec grep -l -P "\t" {} +) >>  abs_path_files_with_tabs.txt
(find . -type f -name "*uio*.c" -exec grep -l -P "\t" {} +) >>  abs_path_files_with_tabs.txt
(find . -type f -name "*tja1021*.c" -exec grep -l -P "\t" {} +) >>  abs_path_files_with_tabs.txt
(find . -type f -name "*tic124*.c" -exec grep -l -P "\t" {} +) >>  abs_path_files_with_tabs.txt
(find . -type f -name "*ksz8081*.c" -exec grep -l -P "\t" {} +) >>  abs_path_files_with_tabs.txt
(find . -type f -name "*ad56*.c" -exec grep -l -P "\t" {} +) >>  abs_path_files_with_tabs.txt
(find . -type f -name "*lin*.c" -exec grep -l -P "\t" {} +) >>  abs_path_files_with_tabs.txt

while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    sed -i 's/\t/    /g'  "${LINE}" 
done < abs_path_files_with_tabs.txt

abs_path_files_with_tabs.txt