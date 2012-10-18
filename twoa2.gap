# Calculates the poset Wk(theta).
TwistedInvolutionWeakOrdering2 := function (filename, W, matrix, theta, kmax)
    local persistInfo, maxOrder, vertices, edges, absVertexIndex, absEdgeIndex, prevVertex, currVertex, newEdge, possibleResiduums,
        label, type, deduction, startTime, endTime, S, k, i, s, x, y, n, h, res;
    
    persistInfo := TwistedInvolutionWeakOrderingPersistResultsInit(filename);
    
    S := GeneratorsOfGroup(W);
    maxOrder := Minimum([Maximum(Concatenation(matrix, [1])), 5]);
    vertices := [ [], [ rec(element := One(W), twistedLength := 0, inEdges := [], outEdges := [], absIndex := 1) ] ];
    edges := [ [], [] ];
    absVertexIndex := 2;
    absEdgeIndex := 1;
    k := 0;

    while Length(vertices[2]) > 0 do
        if kmax > -1 and k > kmax then
            break;
        fi;
        
        for i in [1..Length(vertices[2])] do
            Print(k, " ", i, "         \r");
            
            prevVertex := vertices[2][i];
            for label in Filtered([1..Length(S)], n -> Position(List(prevVertex.inEdges, e -> e.label), n) = fail) do
                x := prevVertex.element;
                s := S[label];
                
                type := 1;
                y := s^theta*x*s;
                if (CoxeterElementsCompare(x, y)) then
                    y := x * s;
                    type := 0;
                fi;

                possibleResiduums := DetectPossibleRank2Residuums(prevVertex, label, [1..Length(S)]);
                currVertex := fail;
                for res in possibleResiduums do
                    h := Length(res) / 2;
                    
                    if CoxeterElementsCompare(res[h*2].vertex.element, y) then
                        currVertex := res[h*2].vertex;
                        break;
                    fi;
                od;

                if currVertex = fail then
                    currVertex := rec(element := y, twistedLength := k + 1, inEdges := [], outEdges := [], absIndex := absVertexIndex);
                    Add(vertices[1], currVertex);
                    
                    absVertexIndex := absVertexIndex + 1;
                fi;
                
                newEdge := rec(source := prevVertex, target := currVertex, label := label, type := type, absIndex := absEdgeIndex);

                Add(edges[1], newEdge);
                Add(currVertex.inEdges, newEdge);
                Add(prevVertex.outEdges, newEdge);
                
                absEdgeIndex := absEdgeIndex + 1;
            od;
        od;
        
        TwistedInvolutionWeakOrderingPersistResults(persistInfo, vertices[2], edges[2]);

        Add(vertices, [], 1);
        Add(edges, [], 1);
        if (Length(vertices) > maxOrder + 1) then
            for n in vertices[maxOrder + 2] do
                n.inEdges := [];
                n.outEdges := [];
            od;
            Remove(vertices, maxOrder + 2);
            Remove(edges, maxOrder + 2);
        fi;
        k := k + 1;
    od;
    
    TwistedInvolutionWeakOrderingPersistResultsInfo(persistInfo, W, matrix, theta, absVertexIndex - 1, k - 1);
    TwistedInvolutionWeakOrderingPersistResultsClose(persistInfo);
    
    return rec(numVertices := absVertexIndex - 1, numEdges := absEdgeIndex - 1, maxTwistedLength := k - 1);
end;
