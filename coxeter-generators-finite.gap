CoxeterGroup_An := function (n)
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := Flat(List(Reversed([1..n-1]), m -> Concatenation([3], List([1..m-1], o -> 2))));

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);
    
    SetName(W, Concatenation("A_{", String(n), "}"));
    SetSize(W, Factorial(n + 1));
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_BCn := function (n)
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := Flat(List(Reversed([1..n-1]), m -> Concatenation([3], List([1..m-1], o -> 2))));
    upperTriangleOfCoxeterMatrix[Length(upperTriangleOfCoxeterMatrix)] := 4;
    
    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);
    
    SetName(W, Concatenation("BC_{", String(n), "}"));
    SetSize(W, 2^n * Factorial(n));
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_Dn := function (n)
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := Flat(List(Reversed([1..n-1]), m -> Concatenation([3], List([1..m-1], o -> 2))));
    upperTriangleOfCoxeterMatrix[Length(upperTriangleOfCoxeterMatrix)] := 2;
    upperTriangleOfCoxeterMatrix[Length(upperTriangleOfCoxeterMatrix) - 1] := 3;
    upperTriangleOfCoxeterMatrix[Length(upperTriangleOfCoxeterMatrix) - 2] := 3;
    
    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);
    
    SetName(W, Concatenation("D_{", String(n), "}"));
    SetSize(W, 2^(n-1) * Factorial(n));
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_E6 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [3, 2, 2, 2, 2,  3, 2, 2, 2,  3, 3, 2,  2, 2,  3];
    
    W := CoxeterGroup(6, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "E_6");
    SetSize(W, 2^7 * 3^4 * 5);
    
    return rec(group := W, rank := 6, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_E7 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [3, 2, 2, 2, 2, 2,  3, 2, 2, 2, 2,  3, 3, 2, 2,  2, 2, 2,  3, 2,  3];
    
    W := CoxeterGroup(7, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "E_7");
    SetSize(W, 2^10 * 3^4 * 5 * 7);
    
    return rec(group := W, rank := 7, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_E8 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [3, 2, 2, 2, 2, 2, 2,  3, 2, 2, 2, 2, 2,  3, 3, 2, 2, 2,  2, 2, 2, 2,  3, 2, 2,  3, 2,  3];
    
    W := CoxeterGroup(8, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "E_8");
    SetSize(W, 2^14 * 3^5 * 5^2 * 7);
    
    return rec(group := W, rank := 8, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_F4 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [3, 2, 2, 4, 2, 3];
    
    W := CoxeterGroup(4, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "F_4");
    SetSize(W, 2^7 * 3^2);
    
    return rec(group := W, rank := 4, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_H3 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [5, 2, 3];
    
    W := CoxeterGroup(3, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "H_3");
    SetSize(W, 120);
    
    return rec(group := W, rank := 3, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_H4 := function ()
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [5, 2, 2, 3, 2, 3];
    
    W := CoxeterGroup(4, upperTriangleOfCoxeterMatrix);
    
    SetName(W, "H_4");
    SetSize(W, 14400);
    
    return rec(group := W, rank := 4, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_I2m := function (m)
    local upperTriangleOfCoxeterMatrix, W;

    upperTriangleOfCoxeterMatrix := [m];
    
    W := CoxeterGroup(2, upperTriangleOfCoxeterMatrix);
    
    SetName(W, Concatenation("I_2(", String(m), ")"));
    SetSize(W, 2*m);

    return rec(group := W, rank := 2, matrix := upperTriangleOfCoxeterMatrix);
end;
