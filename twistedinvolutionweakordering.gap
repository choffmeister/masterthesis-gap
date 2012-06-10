Read("twistedinvolutionweakordering-persist.gap");

FindCircle := function(matrix, nodes, edges, startNode, startLabel)
    local rank, e, combs, comb, k, next, trace, s, n;
    
    rank := -1/2 + Sqrt(1/4 + 2*Length(matrix)) + 1;
    combs := [];

    for e in startNode.inEdges do
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
            
            e := FindElement(n.inEdges, e -> e.label = comb.s[k mod 2 + 1]);
            if e = fail then break; fi;
            n := e.source;

            Add(trace, rec(node := n, edge := e));
            k := k + 1;
        od;
        
        if k < comb.m then continue; fi;
        
        while k > 0 do
            e := FindElement(n.outEdges, e -> e.label = comb.s[k mod 2 + 1]);
            if e = fail then break; fi;
            n := e.target;
            
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
TwistedInvolutionWeakOrdering := function (filename, theta, S, W, matrix, maxLength, optimizations)
    local k, i, j, s, sIndex, x, y, n, e, maxOrder, nodes, edges, absNodeIndex, absEdgeIndex, t, persistInfo, circle, prevNode, currNode, newEdge;
    
    persistInfo := TwistedInvolutionWeakOrderingPersistResultsInit(filename);
    
    if optimizations = 1 then
        maxOrder := Minimum([Maximum(Concatenation(matrix, [1])), 5]);
    else
        maxOrder := 1;
    fi;
    
    nodes := [ [], [ rec(element := One(W), twistedLength := 0, inEdges := [], outEdges := [], absIndex := 1) ] ];
    edges := [ [], [] ];
    absNodeIndex := 2;
    absEdgeIndex := 1;
    k := 0;

    while Length(nodes[2]) > 0 and k < maxLength do
        for i in [1..Length(nodes[2])] do
            Print(k, " ", i, "         \r");
            
            prevNode := nodes[2][i];
            for sIndex in Filtered([1..Length(S)], n -> Position(List(prevNode.inEdges, e -> e.label), n) = fail) do
                if optimizations = 1 then
                    circle := FindCircle(matrix, nodes, edges, prevNode, sIndex);
                else
                    circle := fail;
                fi;
            
                if circle <> fail then
                    t := circle.type;
                    currNode := circle.node;
                else
                    x := prevNode.element;
                    s := S[sIndex];
                    
                    t := 1;
                    y := s^theta*x*s;
                    if (CoxeterElementsCompare(x, y)) then
                        y := x * s;
                        t := 0;
                    fi;
                    
                    currNode := FindElement(nodes[1], n -> FindElement(n.inEdges, e -> e.label = sIndex) = fail and CoxeterElementsCompare(n.element, y));
                    if currNode = fail then
                        currNode := rec(element := y, twistedLength := k + 1, inEdges := [], outEdges := [], absIndex := absNodeIndex);
                        Add(nodes[1], currNode);
                        
                        absNodeIndex := absNodeIndex + 1;
                    fi;
                fi;
                
                newEdge := rec(source := prevNode, target := currNode, label := sIndex, type := t, absIndex := absEdgeIndex);

                Add(edges[1], newEdge);
                Add(currNode.inEdges, newEdge);
                Add(prevNode.outEdges, newEdge);
                
                absEdgeIndex := absEdgeIndex + 1;
            od;
        od;
        
        TwistedInvolutionWeakOrderingPersistResults(persistInfo, nodes[2], edges[2]);

        Add(nodes, [], 1);
        Add(edges, [], 1);
        if (Length(nodes) > maxOrder + 1) then
            for n in nodes[maxOrder + 2] do
                n.inEdges := [];
                n.outEdges := [];
            od;
            Remove(nodes, maxOrder + 2);
            Remove(edges, maxOrder + 2);
        fi;
        k := k + 1;
    od;
    
    TwistedInvolutionWeakOrderingPersistResultsClose(persistInfo);
    
    return [ absNodeIndex - 1, absEdgeIndex - 1, k - 1 ];
end;

