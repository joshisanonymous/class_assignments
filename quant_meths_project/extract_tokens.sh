#!/bin/bash
# This script will extract tokens of tu/toi/te and vous from plain text
# versions of the NCCFr to csv files. The original transcriptions (in ELAN
# .eaf files) each contained two speakers on different tiers. ELAN was used
# to export each tier into its own text file matching the speaker's ID
# (e.g., F12L.txt).
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
  # Captures tokens and saves them to a csv as token,ID
  cat $file |
  tr " " "\n" | # tokenize
  egrep "^(\-?tu|toi|te|t'|\-?vous)$" |
  awk -v filename=$filename 'BEGIN { OFS="," }
                                   { print $1, filename }' >> nccfr_tv_raw.csv
done
