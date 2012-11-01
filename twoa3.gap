# Calculates the poset Wk(theta).
TwistedInvolutionWeakOrdering3 := function (filename, W, matrix, theta, kmax)
    local persistInfo, maxOrder, vertices, edges, absVertexIndex, absEdgeIndex, prevVertex, currVertex, newEdge, possibleResiduums,
        label, type, deduction, startTime, endTime, endTypes, S, k, i, s, x, _y, y, n, m, h, res, thetamap;
    
    persistInfo := TwistedInvolutionWeakOrderingPersistResultsInit(filename);
    
    S := GeneratorsOfGroup(W);
    thetamap := GroupHomomorphismByImages(W, W, S, S{theta});
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
                y := x*s;
                _y := s^thetamap*y;
                type := -1;

                possibleResiduums := DetectPossibleRank2Residuums(prevVertex, label, [1..Length(S)]);
                currVertex := fail;
                for res in possibleResiduums do
                    m := CoxeterMatrixEntry(matrix, res[1].edge.label, res[2].edge.label);
                    h := Length(res) / 2;
                    
                    if h = 1 then
                        if m = 2 and res[h*2].edge.type = 1 and CoxeterElementsCompare(res[h*2].vertex.element, _y) then
                            currVertex := res[h*2].vertex;
                            type := 1;
                            break;
                        fi;
                    else
                        endTypes := [-1, res[h].edge.type, res[h+1].edge.type, res[h*2].edge.type];
                        endTypes[1] := endTypes[3] + endTypes[4] - endTypes[2];

                        if endTypes[4] = 0 then
                            currVertex := res[h*2].vertex;
                            type := endTypes[1];
                            break;
                        elif endTypes = [1,1,1,1] then
                            if m = h or (Gcd(m,h) > 1 and CoxeterElementsCompare(res[h*2].vertex.element, _y)) then
                                currVertex := res[h*2].vertex;
                                type := 1;
                                break;
                            fi;
                        elif endTypes = [0,1,0,1] then
                            if m = h or (Gcd(m,h) > 1 and CoxeterElementsCompare(res[h*2].vertex.element, y)) then
                                currVertex := res[h*2].vertex;
                                type := 0;
                                break;
                            fi;
                        elif endTypes = [1,0,0,1] and m mod 2 = 1 then
                            if (m+1)/2 = h or (Gcd((m+1)/2,h) > 1 and CoxeterElementsCompare(res[h*2].vertex.element, _y)) then
                                currVertex := res[h*2].vertex;
                                type := 1;
                                break;
                            fi;
                        fi;
                    fi;
                od;

                if currVertex = fail then
                    if CoxeterElementsCompare(x, _y) then
                        type := 0;
                        _y := y;
                    else
                        type := 1;
                    fi;

                    currVertex := rec(element := _y, twistedLength := k + 1, inEdges := [], outEdges := [], absIndex := absVertexIndex);
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
