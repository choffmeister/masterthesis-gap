Read("twistedinvolutionweakordering.gap");

CalculateTwistedWeakOrderings := function()
    local tasks, task, theta, W, matrix;

    tasks := [
        rec(system := CoxeterGroup_An(1), thetas := [ "id" ]),
        rec(system := CoxeterGroup_An(2), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_An(3), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_An(4), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_An(5), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_An(6), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_An(7), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_An(8), thetas := [ "id", "-id" ]),
#        rec(system := CoxeterGroup_An(9), thetas := [ "id", "-id" ]),
#        rec(system := CoxeterGroup_An(10), thetas := [ "id", "-id" ]),
#        rec(system := CoxeterGroup_An(11), thetas := [ "id", "-id" ]),
#        rec(system := CoxeterGroup_An(10), thetas := [ "id" ]),
#        rec(system := CoxeterGroup_An(12), thetas := [ "id", "-id" ]),
#        rec(system := CoxeterGroup_An(13), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_BCn(2), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_BCn(3), thetas := [ "id" ]),
        rec(system := CoxeterGroup_BCn(4), thetas := [ "id" ]),
        rec(system := CoxeterGroup_BCn(5), thetas := [ "id" ]),
        rec(system := CoxeterGroup_Dn(4), thetas := [ "id" ]),
        rec(system := CoxeterGroup_Dn(5), thetas := [ "id" ]),
        rec(system := CoxeterGroup_Dn(6), thetas := [ "id" ]),
        rec(system := CoxeterGroup_E6(), thetas := [ "id", [6,5,3,4,2,1] ]),
#        rec(system := CoxeterGroup_E7(), thetas := [ "id" ]),
#        rec(system := CoxeterGroup_E8(), thetas := [ "id" ]),
        rec(system := CoxeterGroup_H3(), thetas := [ "id" ]),
        rec(system := CoxeterGroup_H4(), thetas := [ "id" ]),
        rec(system := CoxeterGroup_I2m(3), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_I2m(4), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_I2m(5), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_I2m(6), thetas := [ "id", "-id" ]),
    ];

    for task in tasks do
        W := task.system.group;
        matrix := task.system.matrix;
        
        for theta in List(task.thetas, t -> GroupAutomorphismByPermutation(W, t)) do
            Print(Name(W), " ", Name(theta), "\n");
            TwistedInvolutionWeakOrdering(StringToFilename(Concatenation(Name(W), "-", Name(theta))), W, matrix, theta);
        od;
    od;
end;

TestCondition := function ()
    local tasks, task, S, K, _T, T, K12, K23, K31, parts, part, graph;
    
    tasks := [
        "A__1_-id",
        "A__2_-id",
        "A__3_-id",
        "A__4_-id",
        "A__5_-id",
        "A__6_-id",
        "A__7_-id",
        "A__8_-id",
    ];
    
    for task in tasks do
        graph := TwistedInvolutionWeakOrderingPersistReadResults(task);
        S := [1..graph.data.rank];
        
        Print(graph.data.name, "\n");
        
        for K in IteratorOfCombinations(S) do
            if Length(K) <= 2 or Length(K) = Length(S) then continue; fi;
            parts := PartitionsSet(K, 3);
            
            for _T in IteratorOfCombinations(K) do
                T := Union(_T, Difference(S, K));
                
                for part in parts do
                    K12 := part[1];
                    K23 := part[2];
                    K31 := part[3];
                    
                    #Print("K=", K, " T=", T, " K12=", K12, " K23=", K23, " K31=", K31, "\n");
                od;
            od;
        od;
    od;
end;

