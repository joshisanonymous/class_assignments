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
      ('VP',['Vint']),
      ('VP',['Vint','PP']),
      ('VP',['Vtran','DP']),
      ('VP',['Vtran','DP','PP']),
      ('VP',['Vcomp','DP']),
      ('VP',['Vcomp','DP','PP']),
      ('VP',['Vcomp','CP']),
      ('VP',['AuxFut','VFut']),
      ('VP',['AuxPerf','VPerf']),
      ('VP',['AuxProg','PresPart']),
      ('VFut',['Inf']),
      ('VFut',['InfProg','PresPart']),
      ('VPerf',['PastPart']),
      ('VPerf',['PastPartProg','PresPart']),
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
      ('Vint',['laughs']),
      ('Vint',['cries']),
      ('Vtran',['praises']),
      ('Vtran',['criticizes']),
      ('Vcomp',['says']),
      ('Vcomp',['knows']),
      ('AuxFut',['will']),
      ('AuxPerf',['has']),
      ('AuxProg',['is']),
      ('Inf',['laugh']),
      ('InfProg',['be']),
      ('PastPart',['laughed']),
      ('PastPartProg',['been']),
      ('PresPart',['laughing']),
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
