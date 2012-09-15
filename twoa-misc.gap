DetectPossibleRank2Residuums := function(startVertex, startLabel, labels)
    local comb, trace, v, e, k, possibleTraces;
    possibleTraces := [];

    for comb in List(Filtered(labels, label -> label <> startLabel), label -> rec(startVertex := startVertex, st := [startLabel, label])) do
        trace := [ rec(vertex := startVertex, edge := rec(label := comb.st[1], type := -1)) ];
        
        v := startVertex;
        e := fail;
        k := 1;
        
        while true do
            e := FindElement(v.inEdges, e -> e.label = comb.st[k mod 2 + 1]);
            if e = fail then
                break;
            fi;

            v := e.source;
            k := k + 1;
            Add(trace, rec(vertex := v, edge := e));
        od;
        
        while true do
            e := FindElement(v.outEdges, e -> e.label = comb.st[k mod 2 + 1]);
            if e = fail then
                break;
            fi;
            
            v := e.target;
            k := k - 1;
            Add(trace, rec(vertex := v, edge := e));
        od;
        
        if k = 0 then
            Add(possibleTraces, trace);
        fi;
    od;

    return possibleTraces;
end;
