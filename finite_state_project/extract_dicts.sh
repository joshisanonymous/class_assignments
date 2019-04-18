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

# Create the directory where all the dictionaries will go
mkdir ./generated_dicts

#####################
#      English      #
#####################

# Get all the tagged words from the SPPAS English dictionary
awk '{ print $1 }' eng.dict |
sed "s/(.)//" | # These two lines remove duplicates in the form
uniq |          # of name(#) that were for different pronunciations
tree-tagger-english |
awk -F "\t" '{ print $2, $3 }' > extracted_eng_dict.txt

# Save all the English verb headwords to their own file
awk '/^V.{,2}/ { print $2 }' extracted_eng_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsEng" }
           { printf("%s    VEngInf    ;\n", $1) }' > generated_dicts/engV_dict.lexc

# Save all the English non-headword non-verbs to their own file
awk '!/^V.{,2}/ { print $2 }' extracted_eng_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON NonVerbsEng" }
           { printf("%s    #    ;\n", $1) }' > generated_dicts/engNV_dict.lexc

# Get rid of intermediate extracted_eng_dict.txt file
rm extracted_eng_dict.txt

####################
#      French      #
####################

# Get all the tagged words from the SPPAS French dictionary
awk '{ print $1 }' fra.dict |
sed "s/(.)//" | # These two lines remove duplicates in the form
uniq |          # of name(#) that were for different pronunciations
tree-tagger-french |
awk -F "\t" '{ print $2, $3 }' > extracted_fra_dict.txt

# Save all the -er French verb headwords to their own file
awk '/^V.*er$/ && !/aller$/ && !/eler$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreERInf    ;\n", $1, substr($1, 1, length($1) - 2)) }' > generated_dicts/freVer_dict.lexc

# Save all the -ir French verb headwords to their own file
awk '/^V.*[^o]ir$/ && !/enir$/ && !/mourir$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreIRInf    ;\n", $1, substr($1, 1, length($1) - 2)) }' > generated_dicts/freVir_dict.lexc

# Save all the -ire French verb headwords to their own file
awk '/^V.*ire$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreIREInf    ;\n", $1, substr($1, 1, length($1) - 3)) }' > generated_dicts/freVire_dict.lexc

# Save all the -endre French verb headwords to their own file
awk '/^V.*endre$/ && !/^V.*prendre$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreENDREInf    ;\n", $1, substr($1, 1, length($1) - 5)) }' > generated_dicts/freVendre_dict.lexc

# Save all the -prendre French verb headwords to their own file
awk '/^V.*prendre$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFrePRENDREInf    ;\n", $1, substr($1, 1, length($1) - 7)) }' > generated_dicts/freVprendre_dict.lexc

# Save all the -ondre French verb headwords to their own file
awk '/^V.*ondre$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreONDREInf    ;\n", $1, substr($1, 1, length($1) - 5)) }' > generated_dicts/freVondre_dict.lexc

# Save all the -oir French verb headwords to their own file
awk '/^V.*[^l]oir$/ && !/voir$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreOIRInf    ;\n", $1, substr($1, 1, length($1) - 3)) }' > generated_dicts/freVoir_dict.lexc

# Save all the aller French verb headwords to their own file
awk '/^V.*\saller$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:0    VFreALLERInf    ;\n", $1) }' > generated_dicts/freValler_dict.lexc

# Save all the -enir French verb headwords to their own file
awk '/^V.*enir$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreENIRInf    ;\n", $1, substr($1, 1, length($1) - 4)) }' > generated_dicts/freVenir_dict.lexc

# Save all the -aître French verb headwords to their own file
awk '/^V.*aître$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreAITREInf    ;\n", $1, substr($1, 1, length($1) - 5)) }' > generated_dicts/freVaitre_dict.lexc

# Save all the -ouloir French verb headwords to their own file
awk '/^V.*ouloir$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreOULOIRInf    ;\n", $1, substr($1, 1, length($1) - 6)) }' > generated_dicts/freVouloir_dict.lexc

# Save all the -eler French verb headwords to their own file
awk '/^V.*eler$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreELERInf    ;\n", $1, substr($1, 1, length($1) - 4)) }' > generated_dicts/freVeler_dict.lexc

# Save all the -ouvoir French verb headwords to their own file
awk '/^V.*ouvoir$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreOUVOIRInf    ;\n", $1, substr($1, 1, length($1) - 6)) }' > generated_dicts/freVouvoir_dict.lexc

# Save all the mourir French verb headwords to their own file
awk '/^V.*mourir$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:0    VFreMOURIRInf    ;\n", $1) }' > generated_dicts/freVmourir_dict.lexc

# Save all the -ettre French verb headwords to their own file
awk '/^V.*ettre$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreETTREInf    ;\n", $1, substr($1, 1, length($1) - 5)) }' > generated_dicts/freVettre_dict.lexc

# Save all the -alloir French verb headwords to their own file
awk '/^V.*alloir$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreALLOIRInf    ;\n", $1, substr($1, 1, length($1) - 6)) }' > generated_dicts/freValloir_dict.lexc

# Save all the être French verb headwords to their own file
awk '/^V.*\sêtre$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:0    VFreETREInf    ;\n", $1) }' > generated_dicts/freVetre_dict.lexc

# Save all the avoir French verb headwords to their own file
awk '/^V.*\savoir$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:0    VFreAVOIRInf    ;\n", $1) }' > generated_dicts/freVavoir_dict.lexc

# Save all the -voir French verb headwords to their own file
awk '/^V.*voir$/ && !/^V.*(\sa|ce|u|sa|de)voir$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s:%s    VFreVOIRInf    ;\n", $1, substr($1, 1, length($1) - 4)) }' > generated_dicts/freVvoir_dict.lexc

# Save all the French verb headwords that don't fit in the other clases
# (i.e., that need to be accounted for still) to their own file
awk '/^V.{,2}/ && !/(er|ir|ire|endre|ettre|oir|aître|être)$/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON VerbsFre" }
           { printf("%s    #    ;\n", $1) }' > generated_dicts/freVother_dict.lexc

# Save all the French non-headword non-verbs to their own file
awk '!/^V.{,2}/ { print $2 }' extracted_fra_dict.txt |
sort |
uniq |
awk 'BEGIN { print "LEXICON NonVerbsFre" }
           { printf("%s    #    ;\n", $1) }' > generated_dicts/freNV_dict.lexc

# Get rid of intermediate extracted_fra_dict.txt file
rm extracted_fra_dict.txt
