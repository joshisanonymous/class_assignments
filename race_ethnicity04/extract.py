# This will extract possible tokens of the verbs from
# a Louisiana Creole corpus that have been determined
# to be expressing the present habitual and saves them
# to csv files where they will be manually coded as
# long or short form verbs.

import os
from os.path import isfile, join
import re
from bs4 import BeautifulSoup as BS


data_dir = "./data/"
files = [join(data_dir, f) for f in os.listdir(data_dir) if isfile(join(data_dir, f))]
pattern_interviewer = re.compile(r"TK:")
pattern_verb = re.compile(r"<VERB>(.+?)</VERB>")
pattern_sep = re.compile(r"(?:</VERB>\s.*?\s<VERB>|^.*?<VERB>|</VERB>.*?$)")


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
            fw.write("Verb,Speaker,Sentence,Origin,BirthYear,Gender,Race\n")
            for line in to_check:
                fw.write(line)
