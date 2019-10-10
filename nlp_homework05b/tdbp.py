""" file: tdbp.py  stabler@ucla.edu
    beam parser
    updated for python3 by John Hale
"""
import heapq

def tdpstep(g, input_categories_parses): # compute all possible next steps from (ws,cs)
    (ws,cs,p) = input_categories_parses
    if len(cs)>0:
        cs1=cs[1:] # copy of predicted categories except cs[0]
        p1 = p[:]  # copy of rules used so far
        nextsteps=[]
        for (lhs,rhs) in g:
            if lhs == cs[0]:
                #print 'expand',lhs,'->',rhs  # for trace
                nextsteps.append((ws,rhs+cs1,p1+[[lhs]+rhs]))
        if len(ws)>0 and ws[0] == cs[0]:
            #print 'scan',ws[0] # for trace
            ws1=ws[1:]
            nextsteps.append((ws1,cs1,p1))
        return nextsteps
    else:
        return []

def derive(g,beam,k):
    while beam != [] and not (min(beam)[1] == [] and min(beam)[2] == []):
        (prob0,ws0,cs0,p0) = heapq.heappop(beam)
        nextsteps = tdpstep(g,(ws0,cs0,p0))
        #print('nextsteps=',nextsteps)
        if len(nextsteps) > 0:
            prob1 = prob0/float(len(nextsteps))
            if -(prob1) > k:
                for (ws1,cs1,p1) in nextsteps:
                    heapq.heappush(beam,(prob1,ws1,cs1,p1))
                    #print ('pushed',(prob1,ws1,cs1)) # for trace
       #print('|beam|=',len(beam)) # for trace

def parse(g,ws,k):
    beam = [(-1.,ws,['S'],[])]
    heapq.heapify(beam) # make list of derivations into a "min-heap"
    while beam != []:
        derive(g,beam,k)
        if beam == []:
            return 'False'
        else:
            d=heapq.heappop(beam)
            print('ll=',d[3])
            ans = input('another? ')
            if len(ans)>0 and ans[0]=='n':
                return d[3]

# Examples:
# parse(g1,['Sue','laughs'],-1.)
# parse(g1,['Bill','knows','that','Sue','laughs'],-1.)
# parse(g0,['Sue','laughs'],0.01)
# parse(g0,['Sue','laughs'],0.0001)
# parse(g0,['the','student','laughs'],0.0001)
# parse(g0,['the','student','laughs'],0.000001)
# parse(g0min,['the','kind','student','laughs'],0.0000001)
