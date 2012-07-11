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
        rec(system := CoxeterGroup_An(9), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_An(10), thetas := [ "id", "-id" ]),
#        rec(system := CoxeterGroup_An(11), thetas := [ "id", "-id" ]),
#        rec(system := CoxeterGroup_An(10), thetas := [ "id" ]),
#        rec(system := CoxeterGroup_An(12), thetas := [ "id", "-id" ]),
#        rec(system := CoxeterGroup_An(13), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_BCn(2), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_BCn(3), thetas := [ "id" ]),
#        rec(system := CoxeterGroup_BCn(4), thetas := [ "id" ]),
#        rec(system := CoxeterGroup_BCn(5), thetas := [ "id" ]),
#        rec(system := CoxeterGroup_BCn(6), thetas := [ "id" ]),
#        rec(system := CoxeterGroup_BCn(7), thetas := [ "id" ]),
        rec(system := CoxeterGroup_Dn(4), thetas := [ "id" ]),
        rec(system := CoxeterGroup_Dn(5), thetas := [ "id" ]),
        rec(system := CoxeterGroup_Dn(6), thetas := [ "id" ]),
        rec(system := CoxeterGroup_E6(), thetas := [ "id", [6,5,3,4,2,1] ]),
        rec(system := CoxeterGroup_E7(), thetas := [ "id" ]),
#        rec(system := CoxeterGroup_E8(), thetas := [ "id" ]),
        rec(system := CoxeterGroup_F4(), thetas := [ "id" ]),
        rec(system := CoxeterGroup_H3(), thetas := [ "id" ]),
        rec(system := CoxeterGroup_H4(), thetas := [ "id" ]),
#        rec(system := CoxeterGroup_I2m(3), thetas := [ "id", "-id" ]),
#        rec(system := CoxeterGroup_I2m(4), thetas := [ "id", "-id" ]),
#        rec(system := CoxeterGroup_I2m(5), thetas := [ "id", "-id" ]),
#        rec(system := CoxeterGroup_I2m(6), thetas := [ "id", "-id" ]),
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

Benchmark := function ()
    local tasks, task, theta, W, matrix, benchmarks, b, result, startTime, endTime;

    tasks := [
        rec(system := CoxeterGroup_An(9), thetas := [ "id" ]),
        #rec(system := CoxeterGroup_An(10), thetas := [ "id" ]),
        #rec(system := CoxeterGroup_An(11), thetas := [ "id" ]),
        rec(system := CoxeterGroup_E6(), thetas := [ "id" ]),
        #rec(system := CoxeterGroup_E7(), thetas := [ "id" ]),
    ];
    
    benchmarks := [];
    
    Print("Benchmark algo 1\n");
    
    for task in tasks do
        W := task.system.group;
        matrix := task.system.matrix;
        
        for theta in List(task.thetas, t -> GroupAutomorphismByPermutation(W, t)) do
            Print(Name(W), " ", Name(theta), "\n");
            
            startTime := Runtime();
            result := TwistedInvolutionWeakOrdering1(fail, W, matrix, theta);
            endTime := Runtime();
            
            Add(benchmarks, rec(name := Name(W), algo := "TWOA1", time := StringTime(endTime - startTime), result := result));
        od;
    od;
    
    Print("Benchmark algo 2\n");
    
    for task in tasks do
        W := task.system.group;
        matrix := task.system.matrix;
        
        for theta in List(task.thetas, t -> GroupAutomorphismByPermutation(W, t)) do
            Print(Name(W), " ", Name(theta), "\n");
            
            startTime := Runtime();
            result := TwistedInvolutionWeakOrdering(fail, W, matrix, theta);
            endTime := Runtime();
            
            Add(benchmarks, rec(name := Name(W), algo := "TWOA2", time := StringTime(endTime - startTime), result := result));
        od;
    od;
    
    for b in benchmarks do
        Display(b);
    od;
end;

TestCondition := function ()
    local tasks, task, S, K, _T, T, K12, K23, K31, wK, parts, part, graph,
        resS12, resS23, resS31, resT, resDiff, i, j;
    
    tasks := [
#        "H_3-id",
#        "H_4-id",
#        "F_4-id",
#        "D__4_-id",
#        "D__5_-id",
#        "D__6_-id",
#        "E_6-id",
#        "E_7-id",
        "E_8-id",
#        "A__4_-id",
 #       "A__5_-id",
 #       "A__6_-id",
 #       "A__7_-id",
 #       "BC__4_-id",
 #       "BC__5_-id",
 #       "BC__6_-id",
 #       "A__8_-id",
 #       "A__9_-id",
 #       "A__10_-id",
 #       "BC__7_-id",
    ];
    
    for task in tasks do
        graph := TwistedInvolutionWeakOrderingPersistReadResults(task);
        S := [1..graph.data.rank];
        Print(graph.data.name, " ", graph.data.automorphism, "\n");
        i := 0;
        
        for K in IteratorOfCombinations(S) do
            j := 0;
            i := i + 1;
            
            if Length(K) <= 2 or Length(K) = Length(S) then continue; fi;
            parts := PartitionsSet(K, 3);
            wK := TwistedInvolutionWeakOrderungLongestWord(graph.vertices[1], K);
            
            for _T in IteratorOfCombinations(K) do
                j := j + 1;
                Print(i, " ", j, "                         \r");
                
                T := Union(_T, Difference(S, K));
                
                for part in parts do
                    K12 := part[1];
                    K23 := part[2];
                    K31 := part[3];
                    #Print("K=", K, " T=", T, " K12=", K12, " K23=", K23, " K31=", K31, "\n");
                    
                    resS12 := TwistedInvolutionWeakOrderungResiduum(wK, Union(K12, T));
                    resS23 := TwistedInvolutionWeakOrderungResiduum(wK, Union(K23, T));
                    resS31 := TwistedInvolutionWeakOrderungResiduum(wK, Union(K31, T));
                    resT := TwistedInvolutionWeakOrderungResiduum(wK, T);
                    
                    resDiff := Difference(Intersection(resS12, resS23, resS31), resT);
                    
                    if Length(resDiff) > 0 then
                        Print("*** FOUND COUNTEREXAMPLE ***\n",
                            "W = ", graph.name, "\n",
                            "theta = ", graph.automorphis, "\n",
                            "S = ", S, "\n",
                            "K = ", K, "\n",
                            "wK = ", wK, "\n",
                            "T = ", T, "\n",
                            "K12 = ", K12, "\n",
                            "K23 = ", K23, "\n",
                            "K31 = ", K31, "\n",
                            "w = ", resDiff, "\n\n");
                    fi;
                od;
            od;
        od;
    od;
end;

