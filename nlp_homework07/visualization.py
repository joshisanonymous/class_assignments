import spacy
from spacy import displacy

dp = spacy.load("models/model-final")
analysis = dp('C\' est de cette façon que des conditions socio-économiques radicalement nouvelles ( néolibéralisme ) ont été imposées durant les années 1980 à 1990 \.')
displacy.serve(analysis, style="dep", port=8888)
