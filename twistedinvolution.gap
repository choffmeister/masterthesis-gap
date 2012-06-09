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

Read("twistedinvolutionweakordering.gap");
