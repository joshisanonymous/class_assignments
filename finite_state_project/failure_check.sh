#!/bin/bash
# This script runs a corpus through a finite state transducer
# and returns all those types that were not able to be analyzed.
# The first argument is the transducer being used, and the second
# is the corpus text.
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

cat ${@:2} |
tr " " "\n" |     # tokenize
sed "s%'%'\n%" |  # split up elision like "j'ai"
egrep "[^-]$" |   # don't consider transcribed hesitations
flookup $1 |      # grab only failures in the results
grep "+?" |
sort |
uniq -c |
sort -nr
