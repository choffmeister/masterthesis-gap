Read("twistedinvolutionweakordering-persist.gap");

# Calculates the poset Wk(theta).
TwistedInvolutionWeakOrdering := function (filename, theta, S, W, matrix, maxLength)
    local k, i, j, s, sIndex, x, y, n, e, nodes, edges, absNodeIndex, absEdgeIndex, t, persistInfo;
    
    persistInfo := TwistedInvolutionWeakOrderingPersistResultsInit(filename);
    
    k := 0;
    nodes := [ [], [ rec(element := One(W), twistedLength := 0, incomingLabels := [], absIndex := 1) ] ];
    edges := [ [], [] ];
    absNodeIndex := 2;
    absEdgeIndex := 1;

    while Length(nodes[2]) > 0 and k < maxLength do
        for i in [1..Length(nodes[2])] do
            Print(k, " ", i, "         \r");
            
            x := nodes[2][i].element;
            
            for sIndex in Filtered([1..Length(S)], n -> Position(nodes[2][i].incomingLabels, n) = fail) do
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

