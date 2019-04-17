#!/bin/bash
# This script will extract lines that contain 3rd person plural subject
# pronouns from plain text transcriptions of interviews and saves them
# a new text file with the original line numbers.
#
# Usage: The script takes one or more arguments, which is the list of text
# files.
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

for file in $@
do
  # Captures the speaker ID from the filename
  filename=`echo "$file" |
            awk -F "." '{ print $1 }' | # removes the extension
            awk -F "/" '{ print $NF }'` # removes the path
  # Captures the actual lines
  cat $file |
  egrep -vn "^J(osh)?:" | # remove lines spoken by the interviewer
  egrep "(ça|c'|ils|elles|eux)" > ${filename}_lines.txt
done
