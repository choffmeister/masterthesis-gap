LoadPackage("io");

Read("misc.gap");
Read("coxeter.gap");
Read("twistedinvolution.gap");

data := [
    [ CoxeterGroup_An(1), [ "id" ] ],
    [ CoxeterGroup_An(2), [ "id", [2,1] ] ],
    [ CoxeterGroup_An(3), [ "id", [3,2,1] ] ],
    [ CoxeterGroup_An(4), [ "id", [4,3,2,1] ] ],
    [ CoxeterGroup_An(5), [ "id", [5,4,3,2,1] ] ],
    [ CoxeterGroup_An(6), [ "id", [6,5,4,3,2,1] ] ],
    [ CoxeterGroup_An(7), [ "id", [7,6,5,4,3,2,1] ] ],
    [ CoxeterGroup_An(8), [ "id", [8,7,6,5,4,3,2,1] ] ],
#    [ CoxeterGroup_An(9), [ "id", [9,8,7,6,5,4,3,2,1] ] ],
#    [ CoxeterGroup_An(10), [ "id", [10,9,8,7,6,5,4,3,2,1] ] ],
    [ CoxeterGroup_BCn(2), [ "id" ] ],
    [ CoxeterGroup_BCn(3), [ "id" ] ],
    [ CoxeterGroup_BCn(4), [ "id" ] ],
    [ CoxeterGroup_BCn(5), [ "id" ] ],
    [ CoxeterGroup_Dn(4), [ "id" ] ],
#    [ CoxeterGroup_E6(), [ "id", [6,5,3,4,2,1] ] ],
#    [ CoxeterGroup_E7(), [ "id" ] ],
#    [ CoxeterGroup_E8(), [ "id" ] ],
    [ CoxeterGroup_F4(), [ "id", [4,3,2,1] ] ],
    [ CoxeterGroup_H3(), [ "id" ] ],
    [ CoxeterGroup_H4(), [ "id" ] ],
    [ CoxeterGroup_I2m(3), [ "id", [2,1] ] ],
    [ CoxeterGroup_I2m(4), [ "id", [2,1] ] ],
#    [ CoxeterGroup_TildeAn(1), [ "id", [2,1] ] ], # coxetergroups with an infinity label are not supported now
    [ CoxeterGroup_TildeAn(2), [ "id" ] ],
];

mat := [ 7,3,6 ];
W := CoxeterGroup(3, mat);
SetName(W, "\\textrm{Test}");
SetSize(W, infinity);
Add(data, [ [ W, 3, mat ], [ [1,2,3] ] ]);

ProfileFunctions([FindElement, TwistedInvolutionDeduceNodeAndEdgeFromGraph, CoxeterElementsCompare]);
totalStartTime := Runtime();

for groupData in data do
    W := groupData[1][1];
    S := GeneratorsOfGroup(W);
    matrix := groupData[1][3];
    
    for automorphismData in groupData[2] do
        if automorphismData = "id" then
            automorphism := IdentityMapping(W);
            SetName(automorphism, "id");
        else
            automorphism := GroupAutomorphismByImages(W, automorphismData);
        fi;
        
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

        startTime := Runtime();
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

totalEndTime := Runtime();
DisplayProfile();
Print("Total time: ", StringTime(totalEndTime - totalStartTime), "\n");



