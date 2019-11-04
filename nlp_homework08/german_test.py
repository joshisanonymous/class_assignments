# This tests several sentences using a feature-based grammar of German

import nltk
from nltk import load_parser

sentences = [
    "der Hunde kommt".split(),
    "der Hund kommt".split(),
    "der Hund kommt mir".split(),
    "der Hund folgt mir".split()
    ]
chart_parser = load_parser("german.fcfg", trace=2)

for sentence in sentences:
    for tree in chart_parser.parse(sentence):
        print(tree)
        tree.draw()
