CoxeterGroup_A1xA1 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 2;
    upperTriangleOfCoxeterMatrix := [2];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "A_1 \\times A_1");
    SetSize(W, Factorial(2)*Factorial(2));
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_A2xA2 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 4;
    upperTriangleOfCoxeterMatrix := [3,2,2, 2,2, 3];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "A_2 \\times A_2");
    SetSize(W, Factorial(3)*Factorial(3));
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_A3xA3 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 6;
    upperTriangleOfCoxeterMatrix := [3,2,2,2,2, 3,2,2,2, 2,2,2, 3,2, 3];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "A_3 \\times A_3");
    SetSize(W, Factorial(4)*Factorial(4));
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_A1xA1xA1 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 3;
    upperTriangleOfCoxeterMatrix := [2,2, 2];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "A_1 \\times A_1 \\times A_1");
    SetSize(W, Factorial(2)*Factorial(2)*Factorial(2));
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_A2xA2xA2 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 6;
    upperTriangleOfCoxeterMatrix := [3,2,2,2,2, 2,2,2,2, 3,2,2, 2,2, 3];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "A_2 \\times A_2 \\times A_2");
    SetSize(W, Factorial(3)*Factorial(3)*Factorial(3));
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;

CoxeterGroup_A3xA3xA3 := function ()
    local upperTriangleOfCoxeterMatrix, W, n;

    n := 9;
    upperTriangleOfCoxeterMatrix := [3,2,2,2,2,2,2,2, 3,2,2,2,2,2,2, 2,2,2,2,2,2, 3,2,2,2,2, 3,2,2,2, 2,2,2, 3,2, 3];

    W := CoxeterGroup(n, upperTriangleOfCoxeterMatrix);

    SetName(W, "A_3 \\times A_3 \\times A_3");
    SetSize(W, Factorial(4)*Factorial(4)*Factorial(4));
    
    return rec(group := W, rank := n, matrix := upperTriangleOfCoxeterMatrix);
end;
