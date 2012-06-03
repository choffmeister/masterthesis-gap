Read("misc.gap");
Read("coxeter.gap");
Read("twistedinvolution.gap");

data := [
    [CoxeterGroup_An(1), [
        []
    ]],
    [CoxeterGroup_An(2), [
        [], [[1, 2]]
    ]],
    [CoxeterGroup_An(3), [
        [], [[1, 3]]
    ]],

    [CoxeterGroup_An(4), [
        [], [[1, 4], [2, 3]]
    ]],

    [CoxeterGroup_An(5), [
        [], [[1, 5], [2, 4]]
    ]],

    [CoxeterGroup_An(6), [
        [], [[1, 6], [2, 5], [3, 4]]
    ]],

    [CoxeterGroup_BCn(2), [
        [], [[1, 2]]
    ]],

    [CoxeterGroup_BCn(3), [
        []
    ]],
    
    [CoxeterGroup_BCn(4), [
        []
    ]],
    
    [CoxeterGroup_Dn(4), [
        []
    ]],
    
    [CoxeterGroup_E6(), [
        [], [[1, 6], [2, 5]]
    ]],
    
    [CoxeterGroup_E7(), [
        #[]
    ]],
    
    [CoxeterGroup_E8(), [
        #[]
    ]],

    [CoxeterGroup_F4(), [
        [], [[1, 4], [2, 3]]
    ]],
    
    [CoxeterGroup_H3(), [
        []
    ]],
    
    [CoxeterGroup_H4(), [
        []
    ]],
    
    [CoxeterGroup_I2m(5), [
        [], [[1, 2]]
    ]],
    
    [CoxeterGroup_I2m(6), [
        [], [[1, 2]]
    ]],
    
    [CoxeterGroup_I2m(7), [
        [], [[1, 2]]
    ]],
    
    [CoxeterGroup_I2m(8), [
        [], [[1, 2]]
    ]],
    
    [CoxeterGroup_TildeAn(1), [
        [], [[1, 2]]
    ]],
    
    [CoxeterGroup_TildeAn(2), [
        []
    ]],
    
    [CoxeterGroup_TildeAn(3), [
        [], [[1, 3], [2, 4]]
    ]],
    
    [CoxeterGroup_TildeAn(4), [
        []
    ]],
    
    [CoxeterGroup_TildeAn(5), [
        [], [[1, 4], [2, 5], [3, 6]]
    ]]
];

convertSize := function (s)
    if s = infinity then
        return 0;
    else
        return s;
    fi;
end;

elementToName := function (w)
    if IsOne(w) then
        return "e";
    else
        return String(w);
    fi;
end;

result := [];

for groupData in data do
    W := groupData[1][1];
    S := GeneratorsOfGroup(W);
    
    result1 := [ Name(W), groupData[1][2], convertSize(Size(W)), groupData[1][3], [] ];
    
    for automorphismData in groupData[2] do
        Print("Wk(" , Name(W), ", ", String(automorphismData), ")...\n");
        
        theta := GeneratorTranspositioningMap(automorphismData, W);
        
        if (IsFinite(W)) then
            wk := TwistedInvolutionWeakOrdering(theta, S, W);
        else
            wk := TwistedInvolutionWeakOrderingWithMaxLength(theta, S, W, 8);
        fi;
        
        Print("Done.\n");

        result2 := [ automorphismData, [List(wk[1], n -> String(n)), List(wk[2], n -> [elementToName(n[1]), n[2]]), List(wk[3], n -> [n[1]-1, n[2]-1, n[3]-1, n[4]])] ];
        Add(result1[5], result2);
    od;
    
    
    Add(result, result1);
od;

file := OutputTextFile("result", false);
SetPrintFormattingStatus(file, false);
PrintTo(file, result);
CloseStream(file);
