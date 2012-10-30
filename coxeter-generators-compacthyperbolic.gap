CoxeterGroup_X31p := function (p)
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 3;
    upperTriangleOfCoxeterMatrix := [p, 2,  3];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, Concatenation("X_3^1(", String(p), ")"));
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X32pq := function (p, q)
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 3;
    upperTriangleOfCoxeterMatrix := [p, 2,  q];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, Concatenation("X_3^2(", String(p), ",", String(q), ")"));
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X33pqr := function (p, q, r)
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 3;
    upperTriangleOfCoxeterMatrix := [p, q,  r];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, Concatenation("X_3^3(", String(p), ",", String(q), ",", String(r), ")"));
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X41 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 4;
    upperTriangleOfCoxeterMatrix := [4, 2, 2,  3, 2,  5];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_4^1");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X42 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 4;
    upperTriangleOfCoxeterMatrix := [3, 2, 2,  5, 2,  3];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_4^2");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X43 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 4;
    upperTriangleOfCoxeterMatrix := [5, 2, 2,  3, 2,  5];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_4^3");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X44 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 4;
    upperTriangleOfCoxeterMatrix := [5, 2, 2,  3, 3,  2];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_4^4");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X45 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 4;
    upperTriangleOfCoxeterMatrix := [4, 2, 3,  3, 2,  3];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_4^5");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X46 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 4;
    upperTriangleOfCoxeterMatrix := [4, 2, 3,  3, 2,  4];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_4^6");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X47 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 4;
    upperTriangleOfCoxeterMatrix := [5, 2, 3,  3, 2,  4];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_4^7");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X48 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 4;
    upperTriangleOfCoxeterMatrix := [5, 2, 3,  3, 2,  3];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_4^8");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X49 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 4;
    upperTriangleOfCoxeterMatrix := [5, 2, 3,  3, 2,  5];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_4^9");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X51 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 5;
    upperTriangleOfCoxeterMatrix := [3, 2, 2, 2,  3, 2, 2,  3, 2,  5];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_5^1");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X52 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 5;
    upperTriangleOfCoxeterMatrix := [4, 2, 2, 2,  3, 2, 2,  3, 2,  5];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_5^2");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X53 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 5;
    upperTriangleOfCoxeterMatrix := [5, 2, 2, 2,  3, 2, 2,  3, 2,  5];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_5^3");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X54 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 5;
    upperTriangleOfCoxeterMatrix := [5, 2, 2, 2,  3, 2, 2,  3, 3,  2];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_5^4");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_X55 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 5;
    upperTriangleOfCoxeterMatrix := [4, 2, 2, 3,  3, 2, 2,  3, 2,  3];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "X_5^4");
    SetSize(W, infinity);
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;
