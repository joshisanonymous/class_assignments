import nltk
from nltk import load_parser


sentences = [
    "der Hunde kommt".split(),
    "der Hund kommt "
    "der Hund kommt".split(),
    "uns moegen die Katze".split(),
    "uns moegen".split()
]
chart_parser = load_parser("german.fcfg", trace=2)

for sentence in sentences:
    for tree in chart_parser.parse(sentence):
        print(tree)
