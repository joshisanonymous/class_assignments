#!/bin/bash
# This script runs a corpus through a finite state transducer
# and returns all those types that were not able to be analyzed.
# The first argument is the transducer being used, the second
# is the corpus text, and the third is an optional regex that
# strips the speaker identifier from the beginning of each line
# (e.g., if R: and J: are in the corpus, use "[RJ]: ").
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

if [ -n "$3" ]
then
  cat $2 |
  sed "s/$3//" |  # remove leading speaker identifiers
  tr " " "\n" |   # tokenize
  sed "s/'/'\n/" |# split up elision like "j'ai"
  egrep "[^-]$" | # don't consider transcribed hesitations
  flookup $1 |
  grep "+?" |     # grab only failures in the results
  sort |
  uniq
else
  cat $2 |
  tr " " "\n" |
  sed "s/'/'\n/" |
  egrep "[^-]$" |
  flookup $1 |
  grep "+?" |
  sort |
  uniq
fi
