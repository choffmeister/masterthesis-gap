LoadPackage("io");

Read("misc.gap");
Read("coxeter.gap");
Read("twoa-persist.gap");
Read("twoa-misc.gap");
Read("twoa1.gap");
Read("twoa2.gap");
Read("twoa3.gap");

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
