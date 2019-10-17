grammar = """
S -> NP VP
PP -> P NP
NP -> Det N | NP PP | "I"
VP -> V NP | VP PP
Det -> "an" | "my"
N -> "elephant" | "pajamas"
V -> "shot"
P -> "in"
"""
