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

# Extracts all twisted involutions from a coxeter group.
TwistedInvolutions := function (theta, W)
    return Filtered(Elements(W), w -> IsOne(theta(w)*w));
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
TwistedInvolutionWeakOrdering := function (theta, I, W)
    local vertices, edges, queue, currentElement, currentTwistedExpression, currentIndex, nextElement, nextTwistedExpression, i, j;
    
    vertices := [[One(W),0]];
    edges := [];
    queue := [[One(W), [], 1]];
    
    while Length(queue) > 0 do
        currentElement := queue[1][1];
        currentTwistedExpression := queue[1][2];
        currentIndex := queue[1][3];
        Remove(queue, 1);
        
        for i in [1..Length(I)] do
            nextElement := CoxeterReduceWord(MonoidAction(theta, currentElement, [I[i]], W), W);
            nextTwistedExpression := TwistedInvolutionReduceTwistedExpression(theta, Concatenation(currentTwistedExpression, [I[i]]), W);
            
            if (Length(nextTwistedExpression) = Length(currentTwistedExpression) + 1) then
                j := FindElementIndex(vertices, n -> n[1] = nextElement); 
                if j = -1 then
                    Add(vertices, [nextElement, Length(nextTwistedExpression)]);
                    j := Length(vertices);
                    
                    Add(queue, [nextElement, nextTwistedExpression, j]);
                fi;

                Add(edges, [currentIndex - 1, j - 1, i - 1]);
            fi;
        od;
    od;
    
    return [List(I, n -> String(n)), List(vertices, n -> [String(n[1]), n[2]]), edges];
end;

