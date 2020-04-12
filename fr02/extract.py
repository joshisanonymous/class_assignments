# This will extract possible tokens of the passé composé
# from a French corpus that involve verbs that would call
# for être as the auxiliary according to Standard French
# and saves them to new files to be manually checked.

import re
from verbs import verbs_reg, verbs_reflex


verbs = verbs_reg.union(verbs_reflex)
data_dir = "./data/"
files = [
    f"{data_dir}coulson.txt",
    f"{data_dir}talbot.txt",
    f"{data_dir}fitz.txt",
    f"{data_dir}ward.txt"
]
pattern_interviewer = re.compile(r"J:")


for file in files:
    with open(file, "r", encoding="utf-8") as fr:
        corpus = fr.readlines()
        to_check = []
        for line in corpus:
            for word in verbs:
                if word in line and not pattern_interviewer.match(line):
                    to_check.append(line)
                    break
        with open(f"{file}_check", "w", encoding="utf-8") as fw:
            for line in to_check:
                fw.write(line)
