# The action of a set of symbols _S on the coxeter group
# W as described in "Hultman 2007: The combinatorics of twisted involutions in
# Coxeter groups, Section 3".
MonoidAction := function (theta, w, _s, W)
    local result, a, b, s;
    
    result := w;

    for s in _s do
        a := result * s;
        b := theta(s) * a;
        
        if b = result then
            result := a;
        else
            result := b;
        fi;
    od;
    
    return result;
end;

# Reduces a twisted expression.
TwistedInvolutionReduceTwistedExpression := function (theta, _s, W)
    local i, j, _s2, _sEvaluated;

    _sEvaluated := MonoidAction(theta, One(W), _s, W);

    for i in [1..Length(_s)-1] do
        for j in [i+1..Length(_s)] do
            _s2 := _s{Filtered([1..Length(_s)], n -> n <> i and n <> j)};
            
            if _sEvaluated = MonoidAction(theta, One(W), _s2, W) then
                return TwistedInvolutionReduceTwistedExpression(theta, _s2, W);
            fi;
        od;    
    od;

    return _s;
end;

# Calulates the reduced length of a twisted expression.
TwistedInvolutionTwistedExpressionLength := function (theta, _s, W)
    return Length(TwistedInvolutionReduceTwistedExpression(theta, _s, W));
end;

FindElementIndex := function (list, selector)
    local i;
    
    for i in [1..Length(list)] do
        if (selector(list[i])) then
            return i;
        fi;
    od;
    
    return -1;
end;

# Calculates the poset Wk(theta).
TwistedInvolutionWeakOrdering := function (filename, theta, S, W, maxLength)
    local k, i, j, l, s, x, y, n, e, index, nodes0, nodes1, edges0, edges1, incomingEdges, t, fileV, fileE, vCount, eCount;
    
    fileV := OutputTextFile(Concatenation("results/", filename, "-vertices"), false);
    fileE := OutputTextFile(Concatenation("results/", filename, "-edges"), false);
    
    vCount := 0;
    eCount := 0;
    
    SetPrintFormattingStatus(fileV, false);
    SetPrintFormattingStatus(fileE, false);
    
    PrintTo(fileV, "[");
    PrintTo(fileE, "[");
    
    k := 0;
    index := 0;
    nodes0 := [[One(W), 0, []]];
    nodes1 := [];
    edges0 := [];
    edges1 := [];

    while Length(nodes0) > 0 and k < maxLength do
        for i in [1..Length(nodes0)] do
            Print(k, " ", i, "         \r");
            incomingEdges := Filtered(edges0, e -> e[2] = index + i);
            x := nodes0[i][1];
            
            for l in Filtered([1..Length(S)], n -> Position(nodes0[i][3], n) = fail) do
                s := S[l];
                
                t := 1;
                y := s^theta*x*s;
                if (x = y) then
                    y := x * s;
                    t := 0;
                fi;
                
                j := FindElementIndex(nodes1, n -> Position(n[3], l) = fail and n[1] = y);
                if j = -1 then
                    Add(nodes1, [y, k + 1, []]);
                    j := Length(nodes1);
                fi;
                
                Add(nodes1[j][3], l);
                Add(edges1, [index + i, index + Length(nodes0) + j, l, t]);
            od;
        od;

        for n in nodes0 do
            if vCount = 0 then
                PrintTo(fileV, "\n");
                PrintTo(fileV, "[", n[2], ",\"e\"]");
            else
                PrintTo(fileV, ",\n");
                PrintTo(fileV, "[", n[2], ",\"", n[1], "\"]");
            fi;
            
            vCount := vCount + 1;
        od;
        
        Sort(edges0, function (a, b) return a[1] < b[1] or a[2] < b[2]; end);

        for e in edges0 do
            if eCount = 0 then
                PrintTo(fileE, "\n");
            else
                PrintTo(fileE, ",\n");
            fi;
        
            PrintTo(fileE, "[", e[1]-1, ",", e[2]-1, ",", e[3], ",", e[4], "]");
            eCount := eCount + 1;
        od;

        index := index + Length(nodes0);
        nodes0 := nodes1;
        nodes1 := [];
        edges0 := edges1;
        edges1 := [];
        k := k + 1;
    od;
    
    PrintTo(fileV, "\n]");
    PrintTo(fileE, "\n]");
    
    CloseStream(fileV);
    CloseStream(fileE);
    
    return [ vCount, eCount, k - 1 ];
end;

