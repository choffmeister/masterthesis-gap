Read("misc.gap");
Read("coxeter.gap");
Read("twistedinvolution.gap");

data := [
    [ CoxeterGroup_An(1), [ [1] ] ],
    [ CoxeterGroup_An(2), [ [1,2], [2,1] ] ],
    [ CoxeterGroup_An(3), [ [1,2,3], [3,2,1] ] ],
    [ CoxeterGroup_An(4), [ [1,2,3,4], [4,3,2,1] ] ],
    [ CoxeterGroup_An(5), [ [1,2,3,4,5], [5,4,3,2,1] ] ],
    [ CoxeterGroup_An(6), [ [1,2,3,4,5,6], [6,5,4,3,2,1] ] ],
    [ CoxeterGroup_An(7), [ [1,2,3,4,5,6,7], [7,6,5,4,3,2,1] ] ],
    [ CoxeterGroup_An(8), [ [1,2,3,4,5,6,7,8], [8,7,6,5,4,3,2,1] ] ],
#    [ CoxeterGroup_An(9), [ [1,2,3,4,5,6,7,8,9], [9,8,7,6,5,4,3,2,1] ] ],
#    [ CoxeterGroup_An(10), [ [1,2,3,4,5,6,7,8,9,10], [10,9,8,7,6,5,4,3,2,1] ] ],
#    [ CoxeterGroup_BCn(2), [ [1,2] ] ],
#    [ CoxeterGroup_BCn(3), [ [1,2,3] ] ],
#    [ CoxeterGroup_BCn(4), [ [1,2,3,4] ] ],
#    [ CoxeterGroup_BCn(5), [ [1,2,3,4,5] ] ],
#    [ CoxeterGroup_Dn(4), [ [1,2,3,4] ] ],
#    [ CoxeterGroup_E6(), [ [1,2,3,4,5,6], [6,5,3,4,2,1] ] ],
#    [ CoxeterGroup_E7(), [ [1,2,3,4,5,6,7] ] ],
#    [ CoxeterGroup_E8(), [ [1,2,3,4,5,6,7,8] ] ],
    [ CoxeterGroup_F4(), [ [1,2,3,4] ] ],
    [ CoxeterGroup_H3(), [ [1,2,3] ] ],
    [ CoxeterGroup_H4(), [ [1,2,3,4] ] ],
    [ CoxeterGroup_I2m(3), [ [1,2], [2,1] ] ],
    [ CoxeterGroup_I2m(4), [ [1,2], [2,1] ] ],
    [ CoxeterGroup_TildeAn(1), [ [1,2], [2,1] ] ],
    [ CoxeterGroup_TildeAn(2), [ [1,2,3] ] ],
];

ProfileFunctions([FindElementIndex, FindElement, TwistedInvolutionDeduceNodeAndEdgeFromGraph, CoxeterElementsCompare]);

for groupData in data do
    W := groupData[1][1];
    S := GeneratorsOfGroup(W);
    matrix := groupData[1][3];
    
    for automorphismData in groupData[2] do
        startTime := Runtime();
    
        automorphism := GroupAutomorphismByImages(W, automorphismData);
        filename := StringToFilename(Concatenation([Name(W), "-", Name(automorphism)]));

        fileD := OutputTextFile(Concatenation("results/", filename, "-data"), false);
        SetPrintFormattingStatus(fileD, false);
        PrintTo(fileD, "{\n");
        PrintTo(fileD, "\"name\":\"", ReplacedString(Name(W), "\\", "\\\\"), "\",\n");
        PrintTo(fileD, "\"rank\":", groupData[1][2], ",\n");
        if (Size(W) = infinity) then
            PrintTo(fileD, "\"size\":\"infinity\",\n");
        else
            PrintTo(fileD, "\"size\":", Size(W), ",\n");
        fi;
        PrintTo(fileD, "\"generators\":[", JoinStringsWithSeparator(List(GeneratorsOfGroup(W), n -> Concatenation("\"", String(n), "\"")), ","), "],\n");
        PrintTo(fileD, "\"matrix\":[", JoinStringsWithSeparator(groupData[1][3], ","), "],\n");
        PrintTo(fileD, "\"automorphism\":\"", Name(automorphism), "\",\n");
        
        Print("Wk(" , Name(W), ", ", Name(automorphism), ")...\n");

        if (IsFinite(W)) then
            info := TwistedInvolutionWeakOrdering(filename, automorphism, S, W, matrix, infinity);
        else
            info := TwistedInvolutionWeakOrdering(filename, automorphism, S, W, matrix, 10);
        fi;
        
        endTime := Runtime();

        if (Size(W) = infinity) then
            PrintTo(fileD, "\"wk_size\":\"infinity\",\n");
            PrintTo(fileD, "\"wk_max_length\":\"infinity\",\n");
        else
            PrintTo(fileD, "\"wk_size\":", info.numNodes, ",\n");
            PrintTo(fileD, "\"wk_max_length\":", info.maxTwistedLength, ",\n");
        fi;
        PrintTo(fileD, "\"calculation_time\":\"", ReplacedString(StringTime(endTime - startTime), " ", ""), "\"\n");
        PrintTo(fileD, "}\n");
        CloseStream(fileD);
        
        Print("- Time spent: ", StringTime(endTime - startTime), "\n");
        Print("- Size of Inv(theta): ", info.numNodes, "\n");
        Print("\n");
    od;
od;

DisplayProfile();


