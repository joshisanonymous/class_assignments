from nltk import load_parser

onea = "Juan vió algo" # ok
oneb = "Juan vió a algo" # star
twoa = "Juan vió alguien" # star
twob = "Juan vió a alguien" # ok
testsuite = [onea, oneb, twoa, twob]

# set cache to False to force it to reload modified grammar
p = load_parser("spanish.fcfg", cache=False)

# utility that prints out the number of analyses
# that the parser finds
# for each member of the test suite defined above
print("{:<20}\t{:>8}".format("example","analyses"))
f = lambda s: len(list(p.parse(s.split())))
for ex in testsuite:
    print("{:<20}\t{:>8}".format(ex, f(ex)))
