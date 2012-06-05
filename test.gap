Read("misc.gap");
Read("coxeter.gap");
Read("twistedinvolution.gap");

data := [
    [ CoxeterGroup_An(1), [ [1] ] ],
    [ CoxeterGroup_An(2), [ [1,2], [2,1] ] ],
    [ CoxeterGroup_BCn(2), [ [1,2] ] ],
    [ CoxeterGroup_BCn(3), [ [1,2,3] ] ],
    [ CoxeterGroup_Dn(4), [ [1,2,3,4] ] ],
    [ CoxeterGroup_E6(), [ [1,2,3,4,5,6], [6,5,3,4,2,1] ] ],
#    [ CoxeterGroup_E7(), [ [1,2,3,4,5,6,7] ] ],
#    [ CoxeterGroup_E8(), [ [1,2,3,4,5,6,7,8] ] ],
    [ CoxeterGroup_F4(), [ [1,2,3,4] ] ],
    [ CoxeterGroup_H3(), [ [1,2,3] ] ],
    [ CoxeterGroup_H4(), [ [1,2,3,4] ] ],
    [ CoxeterGroup_I2m(3), [ [1,2], [2,1] ] ],
    [ CoxeterGroup_I2m(4), [ [1,2], [2,1] ] ],
    [ CoxeterGroup_TildeAn(1), [ [1,2], [2,1] ] ],
    [ CoxeterGroup_TildeAn(2), [ [1,2,3] ] ]
];

for groupData in data do
    W := groupData[1][1];
    S := GeneratorsOfGroup(W);
    
    for automorphismData in groupData[2] do
        startTime := Runtime();
    
        automorphism := GroupAutomorphismByImages(W, automorphismData);
        filename := Concatenation([Name(W), "-", Name(automorphism)]);

        fileD := OutputTextFile(Concatenation("results/", filename, "-data"), false);
        SetPrintFormattingStatus(fileD, false);
        PrintTo(fileD, "#name, rank, size, coxeter matrix, automorphism\n");
        PrintTo(fileD, Name(W), "\n");
        PrintTo(fileD, groupData[1][2], "\n");
        PrintTo(fileD, Size(W), "\n");
        PrintTo(fileD, "[", JoinStringsWithSeparator(groupData[1][3], ","), "]\n");
        PrintTo(fileD, Name(automorphism), "\n");
        CloseStream(fileD);
        
        Print("Wk(" , Name(W), ", ", Name(automorphism), ")...\n");

        if (IsFinite(W)) then
            info := TwistedInvolutionWeakOrdering(filename, automorphism, S, W, infinity);
        else
            info := TwistedInvolutionWeakOrdering(filename, automorphism, S, W, 10);
        fi;
        
        endTime := Runtime();
        
        Print("- Time spent: ", StringTime(endTime - startTime), "\n");
        Print("- Size of Inv(theta): ", info[1], "\n");
        Print("\n");
    od;
od;

