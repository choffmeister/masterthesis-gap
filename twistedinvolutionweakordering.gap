Read("twistedinvolutionweakordering-persist.gap");

TwistedInvolutionDeduceNodeAndEdgeFromGraph := function(matrix, nodes, edges, startNode, startLabel)
    local rank, combs, comb, trace, e, k, n;
    
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
        
        while k > 0 do
            e := FindElement(n.outEdges, e -> e.label = comb.s[k mod 2 + 1]);
            if e = fail then break; fi;
            n := e.target;
            
            Add(trace, rec(node := n, edge := e));
            k := k - 1;
        od;
        
        if Length(trace) = 2*comb.m then
            return rec(node := trace[Length(trace)].node, type := trace[comb.m + 1].edge.type, trace := trace);
        fi;
    od;
    
    return fail;
end;

# Calculates the poset Wk(theta).
TwistedInvolutionWeakOrdering := function (filename, theta, S, W, matrix, maxLength)
    local persistInfo, maxOrder, nodes, edges, absNodeIndex, absEdgeIndex, prevNode, currNode, newEdge,
        label, type, deduction, k, i, s, x, y, n;
    
    persistInfo := TwistedInvolutionWeakOrderingPersistResultsInit(filename);
    
    maxOrder := Minimum([Maximum(Concatenation(matrix, [1])), 5]);
    nodes := [ [], [ rec(element := One(W), twistedLength := 0, inEdges := [], outEdges := [], absIndex := 1) ] ];
    edges := [ [], [] ];
    absNodeIndex := 2;
    absEdgeIndex := 1;
    k := 0;

    while Length(nodes[2]) > 0 and k < maxLength do
        for i in [1..Length(nodes[2])] do
            Print(k, " ", i, "         \r");
            
            prevNode := nodes[2][i];
            for label in Filtered([1..Length(S)], n -> Position(List(prevNode.inEdges, e -> e.label), n) = fail) do
                deduction := TwistedInvolutionDeduceNodeAndEdgeFromGraph(matrix, nodes, edges, prevNode, label);
            
                if deduction <> fail then
                    type := deduction.type;
                    currNode := deduction.node;
                else
                    x := prevNode.element;
                    s := S[label];
                    
                    type := 1;
                    y := s^theta*x*s;
                    if (CoxeterElementsCompare(x, y)) then
                        y := x * s;
                        type := 0;
                    fi;
                    
                    currNode := FindElement(nodes[1], n -> FindElement(n.inEdges, e -> e.label = label) = fail and CoxeterElementsCompare(n.element, y));
                    if currNode = fail then
                        currNode := rec(element := y, twistedLength := k + 1, inEdges := [], outEdges := [], absIndex := absNodeIndex);
                        Add(nodes[1], currNode);
                        
                        absNodeIndex := absNodeIndex + 1;
                    fi;
                fi;
                
                newEdge := rec(source := prevNode, target := currNode, label := label, type := type, absIndex := absEdgeIndex);

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
    
    return rec(numNodes := absNodeIndex - 1, numEdges := absEdgeIndex - 1, maxTwistedLength := k - 1);
end;

