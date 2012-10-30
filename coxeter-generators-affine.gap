CoxeterGroup_TildeAn := function (n)
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := Flat(List(Reversed([1..n]), m -> Concatenation([3], List([1..m-1], o -> 2))));

    if n = 1 then
        upperTriangleOfCoxeterMatrix[1] := 0;
    else
        upperTriangleOfCoxeterMatrix[n] := 3;
    fi;

    W := CoxeterGroup(n + 1, upperTriangleOfCoxeterMatrix);
    
    SetName(W, Concatenation("\\tilde A_{", String(n), "}"));
    SetSize(W, infinity);
    
    return rec(group := W, rank := n + 1, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_TildeBn := function (n)
    local upperTriangleOfCoxeterMatrix, W;

    if n = 2 then
        upperTriangleOfCoxeterMatrix := [4,2,4];
    else
        upperTriangleOfCoxeterMatrix := Flat(List(Reversed([1..n-1]), m -> Concatenation([3], List([1..m-1], o -> 2))));
        upperTriangleOfCoxeterMatrix[Length(upperTriangleOfCoxeterMatrix)] := 4;
        upperTriangleOfCoxeterMatrix := Concatenation(List([1..n], m -> 2), upperTriangleOfCoxeterMatrix);
        upperTriangleOfCoxeterMatrix[2] := 3;
    fi;

    W := CoxeterGroup(n + 1, upperTriangleOfCoxeterMatrix);
    
    SetName(W, Concatenation("\\tilde B_{", String(n), "}"));
    SetSize(W, infinity);
    
    return rec(group := W, rank := n + 1, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_TildeCn := function (n)
    local upperTriangleOfCoxeterMatrix, W;

    if n = 2 then
        upperTriangleOfCoxeterMatrix := [4,2,4];
    else
        upperTriangleOfCoxeterMatrix := Flat(List(Reversed([1..n-1]), m -> Concatenation([3], List([1..m-1], o -> 2))));
        upperTriangleOfCoxeterMatrix[Length(upperTriangleOfCoxeterMatrix)] := 4;
        upperTriangleOfCoxeterMatrix := Concatenation(List([1..n], m -> 2), upperTriangleOfCoxeterMatrix);
        upperTriangleOfCoxeterMatrix[1] := 4;
    fi;

    W := CoxeterGroup(n + 1, upperTriangleOfCoxeterMatrix);
    
    SetName(W, Concatenation("\\tilde C_{", String(n), "}"));
    SetSize(W, infinity);
    
    return rec(group := W, rank := n + 1, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_TildeDn := function (n)
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := Flat(List(Reversed([1..n-1]), m -> Concatenation([3], List([1..m-1], o -> 2))));
    upperTriangleOfCoxeterMatrix[Length(upperTriangleOfCoxeterMatrix)] := 2;
    upperTriangleOfCoxeterMatrix[Length(upperTriangleOfCoxeterMatrix) - 1] := 3;
    upperTriangleOfCoxeterMatrix[Length(upperTriangleOfCoxeterMatrix) - 2] := 3;
    upperTriangleOfCoxeterMatrix := Concatenation(List([1..n], m -> 2), upperTriangleOfCoxeterMatrix);
    upperTriangleOfCoxeterMatrix[2] := 3;
    
    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);
    
    SetName(W, Concatenation("\\tilde D_{", String(n), "}"));
    SetSize(W, infinity);
    
    return rec(group := W, rank := n + 1, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_TildeE6 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [2, 2, 2, 3, 2, 2,  3, 2, 2, 2, 2,  3, 2, 2, 2,  3, 3, 2,  2, 2,  3];
    
    W := CoxeterGroup(6 + 1, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "\\tilde E_6");
    SetSize(W, infinity);
    
    return rec(group := W, rank := 6 + 1, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_TildeE7 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [3, 2, 2, 2, 2, 2, 2,  3, 2, 2, 2, 2, 2,  3, 2, 2, 2, 2,  3, 3, 2, 2,  2, 2, 2,  3, 2,  3];
    
    W := CoxeterGroup(7 + 1, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "\\tilde E_7");
    SetSize(W, infinity);
    
    return rec(group := W, rank := 7 + 1, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_TildeE8 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [2, 2, 2, 2, 2, 2, 2, 3,  3, 2, 2, 2, 2, 2, 2,  3, 2, 2, 2, 2, 2,  3, 3, 2, 2, 2,  2, 2, 2, 2,  3, 2, 2,  3, 2,  3];
    
    W := CoxeterGroup(8 + 1, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "\\tilde E_8");
    SetSize(W, infinity);
    
    return rec(group := W, rank := 8 + 1, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_TildeF4 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [3, 2, 2, 2,  3, 2, 2,  4, 2,  3];
    
    W := CoxeterGroup(4 + 1, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "\\tilde F_4");
    SetSize(W, infinity);
    
    return rec(group := W, rank := 4 + 1, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_TildeG2 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [3, 2, 6];
    
    W := CoxeterGroup(2 + 1, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "\\tilde G_2");
    SetSize(W, infinity);
    
    return rec(group := W, rank := 2 + 1, matrix := upperTriangleOfCoxeterMatrix);
end;
