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
TwistedInvolutionWeakOrdering := function (theta, S, W)
    local done, k, i, j, l, s, x, y, nodes, edges, incomingEdges, elementsByLength;
    
    done := false;
    k := 0;
    nodes := [[One(W), 0]];
    edges := [];

    while not done do
        done := true;

        for i in Filtered([1..Length(nodes)], n -> nodes[n][2] = k) do
            done := false;
            
            incomingEdges := Filtered(edges, e -> e[2] = i);
            x := nodes[i][1];
            
            for l in Filtered([1..Length(S)], n -> Position(List(incomingEdges, e -> e[3]), n) = fail) do
                s := S[l];
                
                y := theta(s)*x*s;
                if (x = y) then
                    y := x * s;
                fi;
                
                j := FindElementIndex(nodes, n -> n[2] = k + 1 and n[1] = y);
                if j = -1 then
                    Add(nodes, [y, k + 1]);
                    j := Length(nodes);
                fi;
                
                Add(edges, [i, j, l]);
            od;
        od;

        k := k + 1;
    od;
    
    return [S, nodes, edges];
end;

