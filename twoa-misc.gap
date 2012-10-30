TwistedInvolutionWeakOrderingResiduum := function (vertex, labels)
    local visited, queue, residuum, current, edge;
    
    visited := [ vertex.absIndex ];
    queue := [ vertex ];
    residuum := [];
    
    while Length(queue) > 0 do
        current := queue[1];
        Remove(queue, 1);
        Add(residuum, current);
        
        for edge in current.outEdges do
            if edge.label in labels and not edge.target.absIndex in visited then
                Add(visited, edge.target.absIndex);
                Add(queue, edge.target);
            fi;
        od;
        
        for edge in current.inEdges do
            if edge.label in labels and not edge.source.absIndex in visited then
                Add(visited, edge.source.absIndex);
                Add(queue, edge.source);
            fi;
        od;
    od;

    return residuum;
end;

TwistedInvolutionWeakOrderingLongestWord := function (vertex, labels)
    local current;
    
    current := vertex;
    
    while Length(Filtered(current.outEdges, e -> e.label in labels)) > 0 do
        current := Filtered(current.outEdges, e -> e.label in labels)[1].target;
    od;
    
    return current;
end;

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
