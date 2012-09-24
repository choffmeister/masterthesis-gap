Read("twistedinvolutionweakordering.gap");

tasks := [
    "H_3-id",
    "H_4-id",
    "F_4-id",
    "D__4_-id",
    "D__5_-id",
    "D__6_-id",
    "E_6-id",
#    "E_7-id",
#    "E_8-id",
    "A__4_-id",
    "A__5_-id",
    "A__6_-id",
    "A__7_-id",
    "A__8_-id",
    "BC__3_-id",
    "BC__4_-id",
    "BC__5_-id",
#    "BC__6_-id",
#    "A__8_-id",
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
        
        wK := TwistedInvolutionWeakOrderungLongestWord(graph.vertices[1], K);
        parts := PartitionsSet(S, 4);
        
        for part in parts do
            j := j + 1;
            Print(i, " ", j, "                         \r");
            
            T := part[4];
            S12 := Union(part[2], T);
            S23 := Union(part[3], T);
            S31 := Union(part[4], T);
            
            resS12 := TwistedInvolutionWeakOrderungResiduum(wK, Union(S12, T));
            resS23 := TwistedInvolutionWeakOrderungResiduum(wK, Union(S23, T));
            resS31 := TwistedInvolutionWeakOrderungResiduum(wK, Union(S31, T));
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
    
    Print("\nDone\n");
od;
