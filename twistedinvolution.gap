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

# Calculates the poset Wk(theta).
TwistedInvolutionCalculateWktheta := function (theta, I, W)
    local queue, current, currentLength, current2, i;
    
    queue := [[]];

    while Length(queue) > 0 do
        current := queue[1];
        Remove(queue, 1);
        
        currentLength := TwistedInvolutionTwistedExpressionLength(theta, current, W);
        
        for i in I do
            current2 := Concatenation(current, [i]);
            
            if (TwistedInvolutionTwistedExpressionLength(theta, current2, W) = currentLength + 1) then
                Add(queue, current2);
                
                #TODO: return results instead of printing it to the screen
                Print(current, " < ", current2, "\n");
            fi;
        od;  
    od;
end;

