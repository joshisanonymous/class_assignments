# This creates a csv for tokens of the passé composé in
# a collection of utterances that have been marked up already.

import re
import csv

dir = "./data/"
files = [
    f"{dir}coulson_checked.txt",
    f"{dir}fitz_checked.txt",
    f"{dir}talbot_checked.txt",
    f"{dir}ward_checked.txt"
]
pattern_speaker = re.compile(r"./data/(.+?)_checked.txt")
pattern_subject = re.compile(r"<S>(.+?)</S>")
pattern_auxiliary = re.compile(r"<A>(.+?)</A>")
pattern_verb = re.compile(r"<V>(.+?)</V>")
pattern_pronoun = re.compile(r"<P>(.+?)</P>")


for file in files:
    speaker = pattern_speaker.search(file).group(1)
    with open(file, "r", encoding="utf-8") as fr:
        corpus = fr.readlines()
        tokens = []
        for line in corpus:
            subject = pattern_subject.search(line).group(1)
            auxiliary = pattern_auxiliary.search(line).group(1)
            verb = pattern_verb.search(line).group(1)
            if pattern_pronoun.search(line):
                pronoun = pattern_pronoun.search(line).group(1)
            else:
                pronoun = "NA"
            tokens.append(f"{auxiliary},{verb},{subject},{pronoun},{speaker}")
        with open(f"{dir}{speaker}_tokens.csv", "w", encoding="utf-8") as fw:
            fw.write("AUXILIAIRE,VERBE,SUJET,PRONOM,LOCUTEUR\n")
            for token in tokens:
                fw.write(f"{token}\n")
