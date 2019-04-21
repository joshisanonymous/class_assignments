#!/bin/bash
# This script will extract tokens of 3rd person plural subject pronouns from
# plain text transcriptions of interview and save them to to csv files.
#
# Usage: The script takes one or more arguments, which is the list of text
# files.
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

# Create the header for the csv file
echo "PRONOUN,SPEAKER,SPECIFICITY,ANIMACY,REF.DISTANCE,VERB.TYPE" > third_person_raw.csv

for file in $@
do
  # Captures the speaker ID from the filename and makes it available to perl later
  export speaker=`echo "$file" |
                  awk -F "." '{ print $1 }' | # removes the extension
                  awk -F "/" '{ print $NF }'` # removes the path
  # Captures tokens and saves them to a csv as ...
  cat $file |
  grep -A $(wc -l < $file) "</META>" | # grab everything after the initial meta-data
  tr " " "\n" | # tokenize
  perl -n -e '/^<(.*),(.*),(.*),(.*)\>(.*)\</.*\>$/ && print "$5,$ENV{speaker},$1,$2,$3,$4\n"' >> third_person_raw.csv
done
