#!/bin/bash

# check if a directory argument is provided
DIR="${1:-.}" #default to current directory if not specified 
# CSV
echo "Path,Size (bytes),Last Modified"

# iterate over files
find "$DIR" -type f | while read -r FILE; do
    SIZE=$(stat -c %s "$FILE")
    MOD_DATE=$(stat -c %y "$FILE")
    echo "\"$FILE\",$SIZE,\"$MOD_DATE\""
done

