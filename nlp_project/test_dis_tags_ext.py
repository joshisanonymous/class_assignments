import os
import re
import nltk


# Variables
directory = "./data/"
filenames = [directory+file for file in os.listdir(directory)]
open_files = [open(file, "r", encoding="utf-8", newline="") for file in filenames]
all_files = []
all_text = []
corpus_tagged_sents = []

# Data cleanning
line_ending = re.compile(r"(\r)?\n$")
periods = re.compile(r"PT")

for files in open_files:
    for item in files:
        item = line_ending.sub("", item)
        if item.islower() or item == ".":
            item = f"{item}/"
        elif item.isupper():
            item = f"{item} "
        all_files.append(item)
    files.close()

for item in all_files:
    item = periods.sub(".", item)
    all_text.append(item)

# Make raw text and then tokenize
corpus_raw = "".join(all_text)
corpus_sents = nltk.sent_tokenize(corpus_raw, language="french")

for sentence in corpus_sents:
    corpus_list = sentence.split()
    corpus_tuples = [nltk.tag.str2tuple(item) for item in corpus_list]
    corpus_tagged_sents.append(corpus_tuples)

# Split into training and held out data
size = int(len(corpus_tagged_sents) * 0.9)
train_sents = corpus_tagged_sents[:size]
test_sents = corpus_tagged_sents[size:]

# Train taggers
tagger_default = nltk.DefaultTagger("NN")
tagger_unigram = nltk.UnigramTagger(train_sents, backoff=tagger_default)
tagger_bigram = nltk.BigramTagger(train_sents, backoff=tagger_unigram)
tagger_trigram = nltk.TrigramTagger(train_sents, backoff=tagger_bigram)

# Evaluate with disfluency chunks and print some stats
stats_dir = "./stats/"
result = tagger_trigram.evaluate(test_sents)

with open(f"{stats_dir}test_dis_ext_result.txt", "w") as file:
    file.write(str(result))
