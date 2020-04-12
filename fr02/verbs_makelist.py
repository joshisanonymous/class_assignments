# This makes a print friendly read-out of the verbs from verbs.py
# for insertion into the appendix of the final document.

from verbs import *

dir = "./data/"

with open(f"{dir}verbs_reg.tex", "w", encoding="utf-8") as fw:
    fw.write(", ".join(verbs_reg))

with open(f"{dir}verbs_reflex.tex", "w", encoding="utf-8") as fw:
    fw.write(", ".join(verbs_reflex))
