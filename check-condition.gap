Read("twistedinvolutionweakordering.gap");

tasks := [
    "H_3-id",
    "H_4-id",
    "F_4-id",
    "D__4_-id",
    "D__5_-id",
    "D__6_-id",
#    "E_6-id",
#    "E_7-id",
    "E_8-id",
    "A__1_-id",
    "A__2_-id",
    "A__3_-id",
    "A__4_-id",
    "A__5_-id",
    "A__6_-id",
    "A__7_-id",
    "BC__3_-id",
    "BC__4_-id",
    "BC__5_-id",
    "BC__6_-id",
    "A__8_-id",
#    "A__9_-id",
#    "A__10_-id",
#    "BC__7_-id",
];

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
                            "W = ", graph.name, "\n",
                            "theta = ", graph.automorphism, "\n",
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
    
    Print("\nDone\n");
od;
