#!/bin/bash
# This script will extract tokens of 3rd person plural subject pronouns from
# plain text transcriptions of interview and save them to to csv files.
#
# Usage: The script takes one or more arguments, which is the list of text
# files.
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

for file in $@
do
  # Captures the speaker ID from the filename
  filename=`echo "$file" |
            awk -F "_" '{ print $1 }' | # removes the extension
            awk -F "/" '{ print $NF }'` # removes the path
  # Captures tokens and saves them to a csv as token,ID
  cat $file |
  tr " " "\n" | # tokenize
  egrep "^\-?(eux|eux-autres|ça|c'|ils|elles)$" |
  awk -v filename=$filename 'BEGIN { OFS="," }
                                   { print $1, filename }' >> third_person_raw.csv
done
