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

#    [CoxeterGroup_An(6), [
#        [], [[1, 6], [2, 5], [3, 4]]
#    ]],

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

    [CoxeterGroup_F4(), [
        [], [[1, 4], [2, 3]]
    ]],
    
    [CoxeterGroup_H3(), [
        [], [[1, 3]]
    ]],
    
#    [CoxeterGroup_H4(), [
#        [], [[1, 4], [2, 3]]
#    ]],
    
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
    
    [CoxeterGroup_I2m(9), [
        [], [[1, 2]]
    ]],
    
    [CoxeterGroup_I2m(10), [
        [], [[1, 2]]
    ]],
    
    [CoxeterGroup_I2m(11), [
        [], [[1, 2]]
    ]],
    
    [CoxeterGroup_I2m(12), [
        [], [[1, 2]]
    ]],
    
    [CoxeterGroup_I2m(13), [
        [], [[1, 2]]
    ]],
    
    [CoxeterGroup_I2m(14), [
        [], [[1, 2]]
    ]]
];

result := [];

for groupData in data do
    W := groupData[1][1];
    S := GeneratorsOfGroup(W);
    
    result1 := [ Name(W), groupData[1][2], Size(W), groupData[1][3], [] ];
    
    for automorphismData in groupData[2] do
        Print("Wk(" , Name(W), ", ", String(automorphismData), ")... ");
        
        theta := GeneratorTranspositioningMap(automorphismData, W);
        wk := TwistedInvolutionWeakOrdering(theta, S, W);
        
        Print("Done.\n");

        result2 := [ automorphismData, wk ];
        Add(result1[5], result2);
    od;
    
    
    Add(result, result1);
od;

file := OutputTextFile("result", false);
SetPrintFormattingStatus(file, false);
PrintTo(file, result);
CloseStream(file);
