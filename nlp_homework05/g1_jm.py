""" file: g1.py
    a grammar with no left recursion
"""
g1 = [('S',['DP','VP']),  # categorial rules
      ('DP',['D','NP']),
      ('DP',['NP']),
      ('DP',['Name']),
      ('DP',['Pronoun']),
      ('NP',['N']),
      ('NP',['N','PP']),
      ('VP',['VI']), # made intransitive
      ('VP',['VT','DP']), # made transitive
      ('VP',['VI','PP']), # made intransitive
      ('VP',['VC','CP']), # made complementizer
      ('VP',['V','VP']),
      ('VP',['VT','DP','PP']), # made transitive
      ('VP',['V','DP','CP']),
      ('VP',['V','DP','VP']),
      ('PP',['P']),
      ('PP',['P','DP']),
      ('AP',['A']),
      ('AP',['A','PP']),
      ('CP',['C','S']),
      ('AdvP',['Adv']),
      ('NP',['AP','NP']),
      ('VP',['AdvP','VP']),
      ('AP',['AdvP','AP']),
      ('D',['the']), # now the lexical rules
      ('D',['a']),
      ('D',['some']),
      ('D',['every']),
      ('D',['one']),
      ('D',['two']),
      ('A',['gentle']),
      ('A',['clear']),
      ('A',['honest']),
      ('A',['compassionate']),
      ('A',['brave']),
      ('A',['kind']),
      ('N',['student']),
      ('N',['teacher']),
      ('N',['city']),
      ('N',['university']),
      ('N',['beer']),
      ('N',['wine']),
      ('VI',['laughs']), # PP or nothing
      ('VI',['cries']), # PP or nothing
      ('VT',['praises']), # DP+PP or DP
      ('VT',['criticizes']), # DP+PP or DP
      ('VC',['says']), # CP or DP+PP or DP
      ('VC',['knows']), # CP or DP+PP or DP
      ('Adv',['happily']),
      ('Adv',['sadly']),
      ('Adv',['impartially']),
      ('Adv',['generously']),
      ('Name',['Bill']),
      ('Name',['Sue']),
      ('Name',['Jose']),
      ('Name',['Maria']),
      ('Name',['Presidents','Day']),
      ('Name',['Tuesday']),
      ('Pronoun',['he']),
      ('Pronoun',['she']),
      ('Pronoun',['it']),
      ('Pronoun',['him']),
      ('Pronoun',['her']),
      ('P',['in']),
      ('P',['on']),
      ('P',['with']),
      ('P',['by']),
      ('P',['to']),
      ('P',['from']),
      ('C',['that']),
      ('C',[]),
      ('C',['whether']),
      ('Coord',['and']),
      ('Coord',['or']),
      ('Coord',['but'])]
