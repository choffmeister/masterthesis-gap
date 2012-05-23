Read("coxeter-generators.gap");

# Reduces a word in a coxeter group.
CoxeterReduceWord := function (w, W)
    local rep, subRep, i, j, w2;

    rep := GroupWordToLetters(w, W);

    for i in [1..Length(rep)-1] do
        for j in [i+1..Length(rep)] do
            subRep := rep{Filtered([1..Length(rep)], n -> n <> i and n <> j)};

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

