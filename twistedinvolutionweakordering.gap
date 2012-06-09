Read("twistedinvolutionweakordering-persist.gap");

FindCircle := function(matrix, nodes, edges, startNode, startLabel)
    local rank, e, combs, comb, k, next, trace, s, n;
    
    rank := -1/2 + Sqrt(1/4 + 2*Length(matrix)) + 1;
    combs := [];

    for e in Filtered(edges[2], e -> e.targetIndex = startNode.absIndex) do
        Add(combs, rec(startNode := startNode, s := [ startLabel, e.label ], m := CoxeterMatrixEntry(matrix, rank, startLabel, e.label)));
    od;
    
    for comb in Filtered(combs, comb -> comb.m <> 0) do
        trace := [];
        k := 1;
        n := comb.startNode;
        
        Add(trace, rec(node := n, edge := rec(label := comb.s[1])));
        
        while k < comb.m do
            if k + 1 > Length(nodes) then
                break;
            fi;
            
            e := FindElementIndex(edges[k+1], e -> e.targetIndex = n.absIndex and e.label = comb.s[k mod 2 + 1]);
            if e = -1 then break; fi;
            e := edges[k+1][e];
            
            n := nodes[k+2][e.sourceIndex - nodes[k+2][1].absIndex + 1];
            
            Add(trace, rec(node := n, edge := e));
            k := k + 1;
        od;
        
        if k < comb.m then continue; fi;
        
        while k > 0 do
            e := FindElementIndex(edges[k], e -> e.sourceIndex = n.absIndex and e.label = comb.s[k mod 2 + 1]);
            if e = -1 then break; fi;
            e := edges[k][e];
            
            n := nodes[k][e.targetIndex - nodes[k][1].absIndex + 1];
            
            Add(trace, rec(node := n, edge := e));
            k := k - 1;
        od;
        
        if k = 0 then
            return rec(node := trace[Length(trace)].node, type := trace[comb.m + 1].edge.type, trace := trace);
        fi;
    od;
    
    return fail;
end;

# Calculates the poset Wk(theta).
TwistedInvolutionWeakOrdering := function (filename, theta, S, W, matrix, maxLength)
    local k, i, j, s, sIndex, x, y, n, e, nodes, edges, absNodeIndex, absEdgeIndex, t, persistInfo, circle;
    
    persistInfo := TwistedInvolutionWeakOrderingPersistResultsInit(filename);
    
    nodes := [ [], [ rec(element := One(W), twistedLength := 0, incomingLabels := [], absIndex := 1) ] ];
    edges := [ [], [] ];
    absNodeIndex := 2;
    absEdgeIndex := 1;
    k := 0;

    while Length(nodes[2]) > 0 and k < maxLength do
        for i in [1..Length(nodes[2])] do
            Print(k, " ", i, "         \r");
            
            for sIndex in Filtered([1..Length(S)], n -> Position(nodes[2][i].incomingLabels, n) = fail) do
                x := nodes[2][i].element;
                s := S[sIndex];
                
                t := 1;
                y := s^theta*x*s;
                if (x = y) then
                    y := x * s;
                    t := 0;
                fi;
                
                j := FindElementIndex(nodes[1], n -> Position(n.incomingLabels, sIndex) = fail and n.element = y);
                if j = -1 then
                    Add(nodes[1], rec(element := y, twistedLength := k + 1, incomingLabels := [], absIndex := absNodeIndex));
                    j := Length(nodes[1]);
                    
                    absNodeIndex := absNodeIndex + 1;
                fi;
                
                Add(nodes[1][j].incomingLabels, sIndex);
                Add(edges[1], rec(sourceIndex := nodes[2][i].absIndex, targetIndex := nodes[1][j].absIndex, label := sIndex, type := t, absIndex := absEdgeIndex));
                absEdgeIndex := absEdgeIndex + 1;
            od;
        od;
        
        TwistedInvolutionWeakOrderingPersistResults(persistInfo, nodes[2], edges[2]);

        Add(nodes, [], 1);
        Add(edges, [], 1);
        if (Length(nodes) > 2) then Remove(nodes, 3); fi;
        if (Length(edges) > 2) then Remove(edges, 3); fi;
        k := k + 1;
    od;
    
    TwistedInvolutionWeakOrderingPersistResultsClose(persistInfo);
    
    return [ absNodeIndex - 1, absEdgeIndex - 1, k - 1 ];
end;

# Calculates the poset Wk(theta).
TwistedInvolutionWeakOrderingOptimized := function (filename, theta, S, W, matrix, maxLength)
    local k, i, j, s, sIndex, x, y, n, e, nodes, edges, absNodeIndex, absEdgeIndex, t, persistInfo, circle, maxOrder, optimizationCounter;
    
    persistInfo := TwistedInvolutionWeakOrderingPersistResultsInit(filename);
    
    maxOrder := Minimum([Maximum(Concatenation(matrix, [2])), 5]);
    nodes := [ [], [ rec(element := One(W), twistedLength := 0, incomingLabels := [], absIndex := 1) ] ];
    edges := [ [], [] ];
    absNodeIndex := 2;
    absEdgeIndex := 1;
    k := 0;

    while Length(nodes[2]) > 0 and k < maxLength do
        optimizationCounter := [ 0, 0 ];
        
        for i in [1..Length(nodes[2])] do
            Print(k, " ", i, "         \r");
            
            for sIndex in Filtered([1..Length(S)], n -> Position(nodes[2][i].incomingLabels, n) = fail) do
                circle := FindCircle(matrix, nodes, edges, nodes[2][i], sIndex);
            
                if circle <> fail then
                    Add(circle.node.incomingLabels, sIndex);
                    Add(edges[1], rec(sourceIndex := nodes[2][i].absIndex, targetIndex := circle.node.absIndex, label := sIndex, type := circle.type, absIndex := absEdgeIndex));
                    absEdgeIndex := absEdgeIndex + 1;
                    optimizationCounter[1] := optimizationCounter[1] + 1;
                else
                    x := nodes[2][i].element;
                    s := S[sIndex];
                    
                    t := 1;
                    y := s^theta*x*s;
                    if (x = y) then
                        y := x * s;
                        t := 0;
                    fi;
                    
                    j := FindElementIndex(nodes[1], n -> Position(n.incomingLabels, sIndex) = fail and n.element = y);
                    if j = -1 then
                        Add(nodes[1], rec(element := y, twistedLength := k + 1, incomingLabels := [], absIndex := absNodeIndex));
                        j := Length(nodes[1]);
                        
                        absNodeIndex := absNodeIndex + 1;
                    fi;
                    
                    Add(nodes[1][j].incomingLabels, sIndex);
                    Add(edges[1], rec(sourceIndex := nodes[2][i].absIndex, targetIndex := nodes[1][j].absIndex, label := sIndex, type := t, absIndex := absEdgeIndex));
                    absEdgeIndex := absEdgeIndex + 1;
                    optimizationCounter[2] := optimizationCounter[2] + 1;
                fi;
            od;
        od;
        
        TwistedInvolutionWeakOrderingPersistResults(persistInfo, nodes[2], edges[2]);

        Add(nodes, [], 1);
        Add(edges, [], 1);
        if (Length(nodes) > maxOrder + 1) then Remove(nodes, maxOrder + 2); fi;
        if (Length(edges) > maxOrder + 1) then Remove(edges, maxOrder + 2); fi;
        k := k + 1;
    od;
    
    TwistedInvolutionWeakOrderingPersistResultsClose(persistInfo);
    
    return [ absNodeIndex - 1, absEdgeIndex - 1, k - 1, optimizationCounter ];
end;

