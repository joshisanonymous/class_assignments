""" file: tdh.py
    first parser: collect history
    by Edward P Stabler, Jr.
    updated for python3 by John Hale
"""
def tdhstep(g, input_categories_history): # compute all possible next steps from (i,cs)
    (i,cs,h) = input_categories_history
    if len(cs)>0:
        cs1=cs[1:] # copy of predicted categories except cs[0]
        nextsteps=[]
        for (lhs,rhs) in g:
            if lhs == cs[0]:
                print('expand',lhs,'->',rhs)  # for trace
                h1 = h[:] # copy of history
                h1.append((i,rhs+cs1))
                nextsteps.append((i,rhs+cs1,h1))
        if len(i)>0 and i[0] == cs[0]:
            print('scan',i[0]) # for trace
            i1=i[1:]
            h1 = h[:] # copy of history
            h1.append((i1,cs1))
            nextsteps.append((i1,cs1,h1))
        return nextsteps
    else:
        return []

def derive(g,ds):
    while ds != [] and not (ds[-1][0] == [] and ds[-1][1] == []):
        d = ds.pop()
        ds.extend(tdhstep(g,d))

def parse(g,i):
    ds = [(i,['S'],[(i,['S'])])]
    while ds != []:
        derive(g,ds)
        if ds == []:
            return 'False'
        else:
            d=ds.pop()
            for n,step in enumerate(d[2]):
                print(n,len(step[1]),step)
            ans = input('more? ')
            if len(ans)>0 and ans[0]=='n':
                return d[2]

# Examples:
# parse(g1,['Sue','laughs'])
# parse(g1,['the','student','laughs'])
# parse(g1,['the','student','praises','the','beer'])
# parse(g1,['Bill','knows','Sue','laughs'])
