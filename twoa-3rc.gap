TwistedInvolutionWeakOrderingSearchForNon3rcCase := function(filename)
    local graph, S, i, j, K, wK, T, UNUSED, part, S12, S23, S31,
        resS12, resS23, resS31, resT, resDiff, theta, isId, pool;
    
    graph := TwistedInvolutionWeakOrderingPersistReadResults(filename);
    theta := graph.data.automorphism;
    S := [1..graph.data.rank];
    isId := theta = S;
    i := 0;
    
    for K in IteratorOfCombinations(S) do
        j := 0;
        i := i + 1;

        if K <> Set(theta{K}) then
            continue;
        fi;
        
        if isId then
            pool := K;
        else
            pool := S;
        fi;

        wK := TwistedInvolutionWeakOrderingLongestWord(graph.vertices[1], K);
        
        for T in Combinations(S) do
            for UNUSED in Combinations(Difference(pool, T)) do
                for part in PartitionsSet(Difference(pool, Union(T, UNUSED)), 3) do
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
                        return rec(
                            W := graph.data.name,
                            theta := theta,
                            S := List(S, s -> Concatenation("s", String(s))),
                            K := List(K, s -> Concatenation("s", String(s))),
                            wK := wK.name,
                            T := List(T, s -> Concatenation("s", String(s))),
                            S12 := List(S12, s -> Concatenation("s", String(s))),
                            S23 := List(S23, s -> Concatenation("s", String(s))),
                            S31 := List(S31, s -> Concatenation("s", String(s))),
                            w := List(resDiff, n -> n.name)
                        );
                    fi;
                od;
            od;
        od;
    od;
    
    return fail;
end;
