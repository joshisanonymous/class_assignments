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
