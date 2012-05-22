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

CoxeterGroup := function (rank, upperTriangleOfCoxeterMatrix)
    local generatorNames, relations, F, S, W, i, j, k;
    
    generatorNames := List([1..rank], n -> Concatenation("s", String(n)));
    
    F := FreeGroup(generatorNames);
    S := GeneratorsOfGroup(F);
    
    relations := [];
    
    Append(relations, List([1..rank], n -> S[n]^2));
    
    k := 1;
    for i in [1..rank] do
        for j in [i+1..rank] do
            Add(relations, (S[i]*S[j])^(upperTriangleOfCoxeterMatrix[k]));
            k := k + 1;
        od;
    od;

    W := F / relations;
    
    return W;
end;

CoxeterGroup_An := function (n)
    local upperTriangleOfCoxeterMatrix;

    upperTriangleOfCoxeterMatrix := Flat(List(Reversed([1..n-1]), m -> Concatenation([3], List([1..m-1], o -> 2))));

    return CoxeterGroup(n, upperTriangleOfCoxeterMatrix);
end;

