from nltk.corpus import gutenberg
import re

# Q1
leaves = gutenberg.raw("whitman-leaves.txt")
pastperfectPattern = re.compile(r"had\s+\w+\'d")
pastperfectUses = pastperfectPattern.findall(leaves)
len(pastperfectUses) # 5

# Q2
from nltk.corpus import movie_reviews
review = movie_reviews.raw("pos/cv989_15824.txt")
compsupPattern = re.compile(r"\w{2,}(er|est)\W")
compsupMatches = [match.group() for match in compsupPattern.finditer(review) if match]
mentPattern = re.compile(r"\w{2,}ment\W")
mentMatches = [match.group() for match in mentPattern.finditer(review) if match]
negPattern = re.compile(r"\W(in|im|ir|il|non|un)\w{2,}")
negMatches = [match.group() for match in negPattern.finditer(review) if match]
pairPattern = re.compile(r"\w{2,}ly\s+\w{1,8}\W")
pairMatches = [match.group() for match in pairPattern.finditer(review) if match]

# Q3
from nltk.corpus import gutenberg
alice = gutenberg.raw("carroll-alice.txt")
pastprogPattern = re.compile(r"(was|were)\s+\w+ing")
pastprogMatches = [match.group() for match in pastprogPattern.finditer(alice) if match]

# Q4
from nltk.corpus import gutenberg
leaves = gutenberg.raw("whitman-leaves.txt")
participlePattern = re.compile(r"(\w+)'(d)")
leavesNorm = participlePattern.sub(r"\g<1>e\g<2>", leaves)

# Q5
willPattern = re.compile(r"(\w+)'(ll\W)")
leavesNorm = willPattern.sub(r"\g<1>\swi\g<2>", leavesNorm)

# Q6
untokenized = " ".join(w for w in nltk.corpus.treebank.words() if not w.startswith("*") and w is not "0")
tokenized = nltk.regexp_tokenize(text=untokenized, pattern=r"[A-Za-z]+|--|[.,?]|\$ [0-9]+(?:.[0-9]+)? (?:million|billion|thousand)?")
