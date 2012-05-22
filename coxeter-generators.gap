# Generates a coxeter group with given rank and relations. The relations have to
# be given in a linear list of the upper right entries (above diagonal) of the
# coxeter matrix.
#
# Example:
# To generate the coxeter group A_4 with the following coxeter matrix:
#
# | 1 3 2 2 |
# | 3 1 3 2 |
# | 2 3 1 3 |
# | 2 2 3 1 |
#
# A4 := CoxeterGroup(4, [3,2,2, 3,2, 3]);
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

# Generates the coxeter group A_n with given rank n.
#
# Example:
# A4 := CoxeterGroup_An(4);
CoxeterGroup_An := function (n)
    local upperTriangleOfCoxeterMatrix;

    upperTriangleOfCoxeterMatrix := Flat(List(Reversed([1..n-1]), m -> Concatenation([3], List([1..m-1], o -> 2))));

    return CoxeterGroup(n, upperTriangleOfCoxeterMatrix);
end;
