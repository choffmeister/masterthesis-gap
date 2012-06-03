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

CoxeterGroup_An := function (n)
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := Flat(List(Reversed([1..n-1]), m -> Concatenation([3], List([1..m-1], o -> 2))));

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);
    
    SetName(W, Concatenation("A_", String(n)));
    SetSize(W, Factorial(n + 1));
    
    return [W, n, upperTriangleOfCoxeterMatrix];
end;

CoxeterGroup_BCn := function (n)
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := Flat(List(Reversed([1..n-1]), m -> Concatenation([3], List([1..m-1], o -> 2))));
    upperTriangleOfCoxeterMatrix[Length(upperTriangleOfCoxeterMatrix)] := 4;
    
    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);
    
    SetName(W, Concatenation("BC_", String(n)));
    SetSize(W, 2^n * Factorial(n));
    
    return [W, n, upperTriangleOfCoxeterMatrix];
end;

CoxeterGroup_Dn := function (n)
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := Flat(List(Reversed([1..n-1]), m -> Concatenation([3], List([1..m-1], o -> 2))));
    upperTriangleOfCoxeterMatrix[Length(upperTriangleOfCoxeterMatrix)] := 2;
    upperTriangleOfCoxeterMatrix[Length(upperTriangleOfCoxeterMatrix) - 1] := 3;
    upperTriangleOfCoxeterMatrix[Length(upperTriangleOfCoxeterMatrix) - 2] := 3;
    
    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);
    
    SetName(W, Concatenation("D_", String(n)));
    SetSize(W, 2^(n-1) * Factorial(n));
    
    return [W, n, upperTriangleOfCoxeterMatrix];
end;

CoxeterGroup_E6 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [3, 2, 2, 2, 2,  3, 2, 2, 2,  3, 3, 2,  2, 2,  3];
    
    W := CoxeterGroup(6, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "E_6");
    SetSize(W, 2^7 * 3^4 * 5);
    
    return [W, 6, upperTriangleOfCoxeterMatrix];
end;

CoxeterGroup_E7 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [3, 2, 2, 2, 2, 2,  3, 2, 2, 2, 2,  3, 3, 2, 2,  2, 2, 2,  3, 2,  3];
    
    W := CoxeterGroup(7, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "E_7");
    SetSize(W, 2^10 * 3^4 * 5 * 7);
    
    return [W, 7, upperTriangleOfCoxeterMatrix];
end;

CoxeterGroup_E8 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [3, 2, 2, 2, 2, 2, 2,  3, 2, 2, 2, 2, 2,  3, 3, 2, 2, 2,  2, 2, 2, 2,  3, 2, 2,  3, 2,  3];
    
    W := CoxeterGroup(8, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "E_8");
    SetSize(W, 2^14 * 3^5 * 5^2 * 7);
    
    return [W, 8, upperTriangleOfCoxeterMatrix];
end;

CoxeterGroup_F4 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [3, 2, 2, 4, 2, 3];
    
    W := CoxeterGroup(4, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "F_4");
    SetSize(W, 2^7 * 3^2);
    
    return [W, 4, upperTriangleOfCoxeterMatrix];
end;

CoxeterGroup_H3 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [5, 2, 3];
    
    W := CoxeterGroup(3, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "H_3");
    SetSize(W, 120);
    
    return [W, 3, upperTriangleOfCoxeterMatrix];
end;

CoxeterGroup_H4 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [5, 2, 2, 3, 2, 3];
    
    W := CoxeterGroup(4, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "H_4");
    SetSize(W, 14400);
    
    return [W, 4, upperTriangleOfCoxeterMatrix];
end;

CoxeterGroup_I2m := function (m)
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [m];
    
    W := CoxeterGroup(2, upperTriangleOfCoxeterMatrix);
    
    SetName(W, Concatenation("I_2(", String(m), ")"));
    SetSize(W, 2*m);

    return [W, 2, upperTriangleOfCoxeterMatrix];
end;

