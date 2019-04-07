#!/bin/bash
# This script extracts all words from eng.dict and fra.dict, tags
# them using TreeTagger, then outputs the following each to their own
# intermediate lexc file with the LEXICON header that they belong
# under included:
#
# English verbs, English non-verbs, French verbs of each class,
# and French non-verbs.
#
# The point is to manually copy the results to the core lexc file
# and, in the process, to check for obvious issues (e.g., remove
# <unknown> and irregular verbs like être placed in non-verbs).
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

# Get all the tagged words from the SPPAS English dictionary
awk '{ print $1 }' eng.dict |
sed "s/(.)//" | # These two lines remove duplicates in the form
uniq |          # of name(#) that were for different pronunciations
tree-tagger-english > extracted_eng_dict.txt

# Save all the English verb headwords to their own file
awk -F "\t" '{ print $2, $3 }' extracted_eng_dict.txt |
awk '/^V.{,2}/ { print $2 }' |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsEng" }
           { printf("%s    VEngInf    ;\n", $1) }' > engV_dict.lexc

# Save all the English non-headword non-verbs to their own file
awk -F "\t" '{ print $2, $1 }' extracted_eng_dict.txt |
awk '!/^V.{,2}/ { print $2 }' |
sort |
uniq |
awk 'BEGIN { print "LEXICON NonVerbsEng" }
           { printf("%s    #    ;\n", $1) }' > engNV_dict.lexc

# Get rid of intermediate extracted_eng_dict.txt file
rm extracted_eng_dict.txt

# Get all the tagged words from the SPPAS French dictionary
awk '{ print $1 }' fra.dict |
sed "s/(.)//" | # These two lines remove duplicates in the form
uniq |          # of name(#) that were for different pronunciations
tree-tagger-french |
awk -F "\t" '{ print $2, $3 }' > extracted_fra_dict.txt

# Save all the -er French verb headwords to their own file
awk '{ print $1, $2 }' extracted_fra_dict.txt |
awk '/^V.{,2}.*er$/ { print $2 }' |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreERInf    ;\n", $1, substr($1, 1, length($1) - 2)) }' > freVer_dict.lexc

# Save all the -ir French verb headwords to their own file
awk '{ print $1, $2 }' extracted_fra_dict.txt |
awk '/^V.{,2}.*[^o]ir$/ { print $2 }' |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreIRInf    ;\n", $1, substr($1, 1, length($1) - 2)) }' > freVir_dict.lexc

# Save all the -ire French verb headwords to their own file
awk '{ print $1, $2 }' extracted_fra_dict.txt |
awk '/^V.{,2}.*ire$/ { print $2 }' |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreIREInf    ;\n", $1, substr($1, 1, length($1) - 3)) }' > freVire_dict.lexc

# Save all the -endre French verb headwords to their own file
awk '{ print $1, $2 }' extracted_fra_dict.txt |
awk '/^V.{,2}.*endre$/ { print $2 }' |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreENDREInf    ;\n", $1, substr($1, 1, length($1) - 5)) }' > freVendre_dict.lexc

# Save all the -oir French verb headwords to their own file
awk '{ print $1, $2 }' extracted_fra_dict.txt |
awk '/^V.{,2}.*oir$/ { print $2 }' |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreOIRInf    ;\n", $1, substr($1, 1, length($1) - 3)) }' > freVoir_dict.lexc

# Save all the French non-headword non-verbs to their own file
awk '{ print $1, $2 }' extracted_fra_dict.txt |
awk '!/^V.{,2}/ { print $2 }' |
sort |
uniq |
awk 'BEGIN { print "LEXICON NonVerbsFre" }
           { printf("%s    #    ;\n", $1) }' > freNV_dict.lexc

# Get rid of intermediate extracted_fra_dict.txt file
rm extracted_fra_dict.txt
