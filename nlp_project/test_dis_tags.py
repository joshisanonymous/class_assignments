import os
import re
import nltk
import sklearn


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
dis_tags = re.compile(r".+_DIS")
noun_collapse = re.compile(r"NN[PS]")
verb_collapse = re.compile(r"VB[DNPZ]")

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
    item = dis_tags.sub("DIS", item)
    item = noun_collapse.sub("NN", item)
    item = verb_collapse.sub("VB", item)
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
train_size_words = 0
for sent in train_sents:
    train_size_words += len(sent)
whole_size_sents = len(corpus_tagged_sents)

with open(f"{stats_dir}test_dis_result.txt", "w") as file:
    file.write(str(result))

with open(f"{stats_dir}train_size_words.tex", "w") as file:
    file.write(str(train_size_words))

with open(f"{stats_dir}whole_size_sents.tex", "w") as file:
    file.write(str(whole_size_sents))

tagged_test_sents = tagger_trigram.tag_sents([[token for token, tag in sent] for sent in test_sents])
gold = [str(tag) for sentence in test_sents for token, tag in sentence]
pred = [str(tag) for sentence in tagged_test_sents for token,tag in sentence]

with open(f"{stats_dir}cat_stats.txt", "w") as file:
    file.write(sklearn.metrics.classification_report(gold, pred))

# Export raw text as a file
with open(f"{directory}all_tagged.txt", "w", encoding="utf-8") as file:
    file.write(corpus_raw)

# Save an example of a hand tagged vs tagger tagged sentence
test_sent_examp = [f"{tuple[0]}/{tuple[1]}" for tuple in test_sents[27]]
test_sent_examp = " ".join(test_sent_examp)
with open(f"{directory}hand_tagged_examp.txt", "w", encoding="utf-8") as file:
    file.write(test_sent_examp)

tagged_test_sent_examp = [f"{tuple[0]}/{tuple[1]}" for tuple in tagged_test_sents[27]]
tagged_test_sent_examp = " ".join(tagged_test_sent_examp)
with open(f"{directory}auto_tagged_examp.txt", "w", encoding="utf-8") as file:
    file.write(tagged_test_sent_examp)
