import nltk
from nltk.corpus import brown

# Divvy up corpus
size = int(len(brown.tagged_sents(categories="news")) * 0.9)
train_sents = brown.tagged_sents(categories="news")[:size]
test_sents = brown.tagged_sents(categories="news")[size:]

# Create an always-noun tagger
default_tagger = nltk.DefaultTagger("NN")

# Train a unigram model
unigram_tagger = nltk.UnigramTagger(train_sents, backoff=default_tagger)

# Train a bigram model
bigram_tagger = nltk.BigramTagger(train_sents, backoff=unigram_tagger)

# Evaluate
bigram_tagger.evaluate(test_sents)  # 0.845...

# Examine mistagged words and "that"
guess = [(word, hypothesis) for s in test_sents for (word, hypothesis) in bigram_tagger.tag(nltk.tag.util.untag(s))]
wrong = [(word, hypothesis, actual) for ((word, hypothesis), (_, actual)) in zip(guess, [(w, t) for s in test_sents for (w, t) in s]) if hypothesis != actual and hypothesis is not None]
