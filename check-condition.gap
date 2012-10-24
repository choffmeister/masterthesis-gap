Read("twistedinvolutionweakordering.gap");

tasks := [
    "H_3-id",
    "H_4-id",
    "F_4-id",
    "D__4_-id",
    "D__5_-id",
    "D__6_-id",
    "BC__3_-id",
    "BC__4_-id",
    "BC__5_-id",
    "BC__6_-id",
    "BC__7_-id",
    "E_6-id",
    "E_6-_6_5_3_4_2_1_",
    "E_7-id",
    "E_8-id",
    "_tilde_A__1_-id",
    "_tilde_A__2_-id",
    "_tilde_A__3_-id",
    "_tilde_A__4_-id",
    "_tilde_B__2_-id",
    "_tilde_B__3_-id",
    "_tilde_C__3_-id",
    "_tilde_G_2-id",
    "A__1_-id",
    "A__2_-id",
    "A__3_-id",
    "A__4_-id",
    "A__5_-id",
    "A__6_-id",
    "A__7_-id",
    "A__8_-id",
    "A__9_-id",
    "A__10_-id",
    "A__11_-id",
    "A__12_-id",
    "A__13_-id",
    "A__13_-id",
];

file := IO_File("counterexamples/counterexamples", "w", 1);

for task in tasks do
    graph := TwistedInvolutionWeakOrderingPersistReadResults(task);
    S := [1..graph.data.rank];
    Print(graph.data.name, " ", graph.data.automorphism, "\n");
    i := 0;
    
    for K in IteratorOfCombinations(S) do
        j := 0;
        i := i + 1;
        
        wK := TwistedInvolutionWeakOrderingLongestWord(graph.vertices[1], K);

        for T in Combinations(S) do
            for UNUSED in Combinations(Difference(S, T)) do
                for part in PartitionsSet(Difference(S, Union(T, UNUSED)), 3) do
                    j := j + 1;
                    Print(i, " ", j, "                         \r");
                    
                    S12 := Union(part[1], T);
                    S23 := Union(part[2], T);
                    S31 := Union(part[3], T);

                    resS12 := TwistedInvolutionWeakOrderingResiduum(wK, Union(S12, T));
                    resS23 := TwistedInvolutionWeakOrderingResiduum(wK, Union(S23, T));
                    resS31 := TwistedInvolutionWeakOrderingResiduum(wK, Union(S31, T));
                    resT := TwistedInvolutionWeakOrderingResiduum(wK, T);

                    resDiff := Difference(Intersection(resS12, resS23, resS31), resT);

                    if Length(resDiff) > 0 then
                        Print("*** FOUND COUNTEREXAMPLE ***\n",
                            "W = ", graph.data.name, "\n",
                            "theta = ", graph.data.automorphism, "\n",
                            "S = ", S, "\n",
                            "K = ", K, "\n",
                            "wK = ", wK.name, "\n",
                            "T = ", T, "\n",
                            "S12 = ", S12, "\n",
                            "S23 = ", S23, "\n",
                            "S31 = ", S31, "\n",
                            "w = ", List(resDiff, n -> n.name), "\n\n");
                            
                        IO_Write(file, "W = ", graph.data.name, "\n",
                            "theta = ", graph.data.automorphism, "\n",
                            "S = ", S, "\n",
                            "K = ", K, "\n",
                            "wK = ", wK.name, "\n",
                            "T = ", T, "\n",
                            "S12 = ", S12, "\n",
                            "S23 = ", S23, "\n",
                            "S31 = ", S31, "\n",
                            "w = ", List(resDiff, n -> n.name), "\n\n"); 
                    fi;
                od;
            od;
        od;
    od;
    
    Print("\nDone\n");
od;
