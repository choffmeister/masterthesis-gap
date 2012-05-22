Read("coxeter-generators.gap");

# Reduces a word in a coxeter group
#
# Example:
# G := FreeGroup(2);
# a := G.1;
# b := G.2;
# letters := GroupWordToLetters(a*a*b*a, G);
#
# letters <- [1,1,2,1]
CoxeterReduceWord := function (w, W)
    local rep, subRep, i, j, w2;

    rep := GroupWordToLetters(w, W);

    for i in [1..Length(rep)-1] do
        for j in [i+1..Length(rep)] do
            subRep := [];
            Append(subRep, rep{[1..i-1]});
            Append(subRep, rep{[i+1..j-1]});
            Append(subRep, rep{[j+1..Length(rep)]});

            w2 := GroupLettersToWord(subRep, W);

            if (w = w2) then
                return CoxeterReduceWord(w2, W);
            fi;
        od;    
    od;

    return w;
end;

# Calulates the length of an element in a coxeter group.
CoxeterWordLength := function (w, W)
    return Length(CoxeterReduceWord(w, W));
end;

# Extracts all twisted involutions from a coxeter group.
CoxeterTwistedInvolutions := function (W, Theta)
    return Filtered(Elements(W), w -> IsOne(Theta(w)*w));
end;
