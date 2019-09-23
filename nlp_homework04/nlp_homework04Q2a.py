import nltk
from nltk.data import find

# Import corpus
root = find("corpora/bnc/")
bncnews = nltk.corpus.TaggedCorpusReader(root, "bnc-news-wtp.txt", tagset="en-claws")

# Divvy up corpus
size = int(len(bncnews.tagged_sents()) * 0.9)
train_sents = bncnews.tagged_sents()[:size]
test_sents = bncnews.tagged_sents()[size:]

# Create an always-noun tagger
default_tagger = nltk.DefaultTagger("NN")

# Train a unigram model
unigram_tagger = nltk.UnigramTagger(train_sents, backoff=default_tagger)

# Train a bigram model
bigram_tagger = nltk.BigramTagger(train_sents, backoff=unigram_tagger)

# Evaluate
bigram_tagger.evaluate(test_sents)  # 0.928467...
