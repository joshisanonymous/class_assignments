# This will extract possible tokens of the possessive
# determiners from a Louisiana Creole corpus and saves
# them to csv files where they will be manually coded

import os
from os.path import isfile, join
import re
from bs4 import BeautifulSoup as BS


data_dir = "./data/"
files = [join(data_dir, f) for f in os.listdir(data_dir) if isfile(join(data_dir, f))]
pattern_interviewer = re.compile(r"TK:")
pattern_verb = re.compile(r"<DET>(.+?)</DET>")
pattern_sep = re.compile(r"(?:</DET>\s.*?\s<DET>|^.*?<DET>|</DET>.*?$)")


for file in files:
    with open(file, "r", encoding="utf-8", newline=None) as fr:
        corpus = fr.readlines()
        meta = []
        for line in corpus:
            if "</META>" in line:
                meta.append(line)
                break
            meta.append(line)
        meta = BS("".join(meta))
        participants = meta.find_all("participant")
        corpus = [line.replace("\n", "") for line in corpus]
        to_check = []
        for line in corpus:
            if pattern_verb.search(line) and not pattern_interviewer.match(line):
                speaker = line[:2]
                line = line[4:]
                for participant in participants:
                    if speaker in participant.find("name").string:
                        origin = participant.find("origin").string
                        birthyear = participant.find("birthyear").string
                        gender = participant.find("gender").string
                        race = participant.find("race").string
                matches = [match for match in filter(None, pattern_sep.split(line)) if "\n" not in match]
                for match in matches:
                    to_check.append(f'{match},{speaker},"{line}",{origin},{birthyear},{gender},{race}\n')
        with open(f"{file}.csv", "w", encoding="utf-8") as fw:
            fw.write("Determiner,Speaker,Sentence,Origin,BirthYear,Gender,Race\n")
            for line in to_check:
                fw.write(line)
