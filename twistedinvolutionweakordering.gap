LoadPackage("io");

Read("misc.gap");
Read("coxeter.gap");
Read("twistedinvolutionweakordering-persist.gap");

TwistedInvolutionDeduceVertexAndEdgeFromGraph := function(matrix, startVertex, startLabel, labels)
    local rank, comb, trace, possibleEqualVertices, e, k, n;
    
    rank := -1/2 + Sqrt(1/4 + 2*Length(matrix)) + 1;
    possibleEqualVertices := [];
    
    for comb in List(Filtered(labels, label -> label <> startLabel), label -> rec(startVertex := startVertex, s := [startLabel, label], m := CoxeterMatrixEntry(matrix, rank, startLabel, label))) do
        trace := [];
        k := 1;
        n := comb.startVertex;
        
        Add(trace, rec(vertex := n, edge := rec(label := comb.s[1], type := -1)));
        
        while k < comb.m do
            e := FindElement(n.inEdges, e -> e.label = comb.s[k mod 2 + 1]);
            if e = fail then break; fi;
            n := e.source;

            Add(trace, rec(vertex := n, edge := e));
            k := k + 1;
        od;
        
        while k > 0 do
            e := FindElement(n.outEdges, e -> e.label = comb.s[k mod 2 + 1]);
            if e = fail then break; fi;
            n := e.target;
            
            Add(trace, rec(vertex := n, edge := e));
            k := k - 1;
        od;
        
        if k <> 0 then continue; fi;
        
        if Length(trace) = 2*comb.m then
            return rec(result := 0, vertex := trace[Length(trace)].vertex, type := trace[comb.m + 1].edge.type, trace := trace);
        fi;
        
        if Length(trace) >= 4 then
            if trace[Length(trace) / 2 + 1].edge.type <> trace[Length(trace) / 2].edge.type then
                # cannot be equal
            else
                if trace[Length(trace)].edge.type = 0 then
                    return rec(result := 0, vertex := trace[Length(trace)].vertex, type := 0, trace := trace);
                else
                    Add(possibleEqualVertices, trace[Length(trace)].vertex);
                fi;
            fi;
        else
            Add(possibleEqualVertices, trace[Length(trace)].vertex);
        fi;
    od;

    return rec(result := -1, possibleEqualVertices := possibleEqualVertices);
end;

# Calculates the poset Wk(theta).
TwistedInvolutionWeakOrdering3 := function (filename, W, matrix, theta)
    local persistInfo, maxOrder, vertices, edges, absVertexIndex, absEdgeIndex, prevVertex, currVertex, newEdge,
        label, type, deduction, startTime, endTime, S, k, i, s, x, y, n;
    
    persistInfo := TwistedInvolutionWeakOrderingPersistResultsInit(filename);
    
    S := GeneratorsOfGroup(W);
    maxOrder := Minimum([Maximum(Concatenation(matrix, [1])), 5]);
    vertices := [ [], [ rec(element := One(W), twistedLength := 0, inEdges := [], outEdges := [], absIndex := 1) ] ];
    edges := [ [], [] ];
    absVertexIndex := 2;
    absEdgeIndex := 1;
    k := 0;

    while Length(vertices[2]) > 0 do
        if not IsFinite(W) then
            if k > 200 or absVertexIndex > 10000 then
                break;
            fi;
        fi;
        
        for i in [1..Length(vertices[2])] do
            Print(k, " ", i, "         \r");
            
            prevVertex := vertices[2][i];
            for label in Filtered([1..Length(S)], n -> Position(List(prevVertex.inEdges, e -> e.label), n) = fail) do
                deduction := TwistedInvolutionDeduceVertexAndEdgeFromGraph(matrix, prevVertex, label, [1..Length(S)]);
                
                if deduction.result = 0 then
                    type := deduction.type;
                    currVertex := deduction.vertex;
                elif deduction.result = 1 then
                    type := deduction.type;
                    
                    currVertex := rec(element := y, twistedLength := k + 1, inEdges := [], outEdges := [], absIndex := absVertexIndex);
                    Add(vertices[1], currVertex);
                    
                    absVertexIndex := absVertexIndex + 1;
                else
                    x := prevVertex.element;
                    s := S[label];
                    
                    type := 1;
                    y := s^theta*x*s;
                    if (CoxeterElementsCompare(x, y)) then
                        y := x * s;
                        type := 0;
                    fi;

                    currVertex := FindElement(deduction.possibleEqualVertices, n -> CoxeterElementsCompare(n.element, y));

                    if currVertex = fail then
                        currVertex := rec(element := y, twistedLength := k + 1, inEdges := [], outEdges := [], absIndex := absVertexIndex);
                        Add(vertices[1], currVertex);
                        
                        absVertexIndex := absVertexIndex + 1;
                    fi;
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

# Calculates the poset Wk(theta).
TwistedInvolutionWeakOrdering2 := function (filename, W, matrix, theta)
    local persistInfo, maxOrder, vertices, edges, absVertexIndex, absEdgeIndex, prevVertex, currVertex, newEdge,
        label, type, deduction, startTime, endTime, S, k, i, s, x, y, n;
    
    persistInfo := TwistedInvolutionWeakOrderingPersistResultsInit(filename);
    
    S := GeneratorsOfGroup(W);
    maxOrder := Minimum([Maximum(Concatenation(matrix, [1])), 5]);
    vertices := [ [], [ rec(element := One(W), twistedLength := 0, inEdges := [], outEdges := [], absIndex := 1) ] ];
    edges := [ [], [] ];
    absVertexIndex := 2;
    absEdgeIndex := 1;
    k := 0;

    while Length(vertices[2]) > 0 do
        if not IsFinite(W) then
            if k > 200 or absVertexIndex > 10000 then
                break;
            fi;
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

                currVertex := FindElement(vertices[1], n -> CoxeterElementsCompare(n.element, y));

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

# Calculates the poset Wk(theta).
TwistedInvolutionWeakOrdering1 := function (filename, W, matrix, theta)
    local persistInfo, maxOrder, vertices, edges, absVertexIndex, absEdgeIndex, prevVertex, currVertex, newEdge,
        label, type, deduction, startTime, endTime, S, k, i, s, x, y, n;
    
    persistInfo := TwistedInvolutionWeakOrderingPersistResultsInit(filename);
    
    S := GeneratorsOfGroup(W);
    maxOrder := Minimum([Maximum(Concatenation(matrix, [1])), 5]);
    vertices := [ [], [ rec(element := One(W), twistedLength := 0, inEdges := [], outEdges := [], absIndex := 1) ] ];
    edges := [ [], [] ];
    absVertexIndex := 2;
    absEdgeIndex := 1;
    k := 0;

    while Length(vertices[2]) > 0 do
        if not IsFinite(W) then
            if k > 200 or absVertexIndex > 10000 then
                break;
            fi;
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

                currVertex := FindElement(vertices[1], n -> CoxeterElementsCompare(n.element, y));

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
