import os
import re
import nltk
import sklearn


# Variables
directory = "./data/"
filenames = [directory+file for file in os.listdir(directory)]
open_files = [open(file, "r", encoding="utf-8", newline="") for file in filenames]
line_ending = re.compile(r"(\r)?\n$")
periods = re.compile(r"PT")
all_files = []
all_text = []
corpus_tagged_sents = []

# Data cleanning
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
result = tagger_trigram.evaluate(test_sents)
size_train = len(train_sents)
print(f"{result} -> with disfluency chunks")
print(f"{size_train} -> size of training set")
tagged_test_sents = tagger_trigram.tag_sents([[token for token, tag in sent] for sent in test_sents])
gold = [str(tag) for sentence in test_sents for token, tag in sentence]
pred = [str(tag) for sentence in tagged_test_sents for token,tag in sentence]
print(sklearn.metrics.classification_report(gold, pred))
