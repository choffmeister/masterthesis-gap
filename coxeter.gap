Read("coxeter-generators.gap");

coxeterElementComparisons := 0;

CoxeterElementsCompare := function (w1, w2)
    coxeterElementComparisons := coxeterElementComparisons + 1;
    return w1 = w2;
end;

CoxeterMatrixEntry := function(matrix, i, j)
    local temp, rank;
    rank := -1/2 + Sqrt(1/4 + 2*Length(matrix)) + 1;

    if (i = j) then
        return 1;
    fi;
    
    if (i > j) then
        temp := i;
        i := j;
        j := temp;
    fi;
    
    return matrix[(rank-1)*(rank)/2 - (rank-i)*(rank-i+1)/2 + (j-i-1) + 1];
end;

