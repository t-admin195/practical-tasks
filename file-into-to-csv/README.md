# bash-file-report

simple Bash script that generates a CSV report of all files in a directory.

## usage

1. run script:  
   `./file_report.sh [dir]`

2. output includes:  
   - file path  
   - file size in bytes  
   - last modified date

4. save output to CSV file:  
   `./file_report.sh /home/user/docs > report.csv`

5. example output:
   ```
   Path,Size (bytes),Last Modified
   Path,Size (bytes),Last Modified
"./file-into-to-csv.sh",344,"2025-06-16 13:31:42.295542130 +0000"
"./README.md",597,"2025-06-16 13:35:36.266798362 +0000"
   ```
