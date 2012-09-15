LoadPackage("io");

Read("misc.gap");
Read("coxeter.gap");
Read("twoa-persist.gap");
Read("twoa-misc.gap");
Read("twoa1.gap");
Read("twoa2.gap");
Read("twoa3.gap");

TwistedInvolutionWeakOrderungResiduum := function (vertex, labels)
    local visited, queue, residuum, current, edge;
    
    visited := [ vertex ];
    queue := [ vertex ];
    residuum := [];
    
    while Length(queue) > 0 do
        current := queue[1];
        Remove(queue, 1);
        Add(residuum, current);
        
        for edge in current.outEdges do
            if edge.label in labels and not edge.target in visited then
                Add(visited, edge.target);
                Add(queue, edge.target);
            fi;
        od;
    od;

    return residuum;
end;

TwistedInvolutionWeakOrderungLongestWord := function (vertex, labels)
    local current;
    
    current := vertex;
    
    while Length(Filtered(current.outEdges, e -> e.label in labels)) > 0 do
        current := Filtered(current.outEdges, e -> e.label in labels)[1].target;
    od;
    
    return current;
end;
