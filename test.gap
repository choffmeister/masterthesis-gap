Read("misc.gap");
Read("coxeter.gap");

Rho := function (Theta, w, sWord)
    local result, s, a, b;
    
    result := w;
    
    for s in sWord do
        a := result * s;
        b := Theta(s) * a;
        
        if b = w then
            result := a;
        else
            result := b;
        fi;
    od;
    
    return result;
end;

Compare := function (Theta, I, w1, w2)
    local w, i1, i2, i3, j, sWord;
    
    #TODO: replace with some non trash and unflexible code
    for i1 in [1..Length(I)] do
        for i2 in [0..Length(I)] do
            for i3 in [0..Length(I)] do
                if i2 = 0 and i3 <> 0 then
                    continue;
                fi;
                
                sWord := [I[i1]];
                if i2 <> 0 then
                    Add(sWord, I[i2]);
                fi;
                if i3 <> 0 then
                    Add(sWord, I[i3]);
                fi;
                
                if (w2 = Rho(Theta, w1, sWord)) then
                    #Print(w1, " * ", sWord, " = ", w2, " -> ", w1, " < ", w2, "\n");
                    return true;
                fi;
            od;
        od;
    od;
    
    return false;
end;

# By now we suppose, that W is finite
Print("Generating coxeter group... ");
W := CoxeterGroup_An(3);
S := GeneratorsOfGroup(W);
Print("Done.\n");

Theta := w -> w;

Print("Finding twisted involutions... ");
InvW := CoxeterTwistedInvolutions(W, Theta);
Print("Done.\n");

Ssubsets := Filtered(Combinations(S), K -> Length(K) > 0);
Sort(Ssubsets, function (v,w) return Length(v) < Length(w); end);

Compare(Theta, [W.1, W.2], W.1, W.2);

for K in List(Ssubsets, K -> Group(K)) do
    Print("Checking property (*) for ", K, "...\n");
    
    if not IsGroupInvariantUnderHomomorphism(Theta, K) then
        continue;
    fi;

    #TODO: replace with non-trivial implementation
    wK := FindMaxElement(Elements(K), w -> CoxeterWordLength(w, W));
        
    #TODO: prevent unneseccary loops
    for S1 in Ssubsets do
        for S2 in Ssubsets do
            for S3 in Ssubsets do
                S1S2 := Set(S1);
                IntersectSet(S1S2, S2);
                if Length(S1S2) = 0 then continue; fi;
                S2S3 := Set(S2);
                IntersectSet(S2S3, S3);
                if Length(S2S3) = 0 then continue; fi;
                S3S1 := Set(S3);
                IntersectSet(S3S1, S1);
                if Length(S3S1) = 0 then continue; fi;
                S1S2S3 := Set(S1);
                IntersectSet(S1S2S3, S2);
                IntersectSet(S1S2S3, S3);
                if Length(S1S2S3) = 0 then continue; fi;
                
                for w in InvW do
                    if not Compare(Theta, S1S2, wK, w) then
                        continue;
                    fi;
                    if not Compare(Theta, S2S3, wK, w) then
                        continue;
                    fi;
                    if not Compare(Theta, S3S1, wK, w) then
                        continue;
                    fi;
                    
                    if not Compare(Theta, S1S2S3, wK, w) then
                        Print("Fail\n");
                        Print("S1: ", S1, "\n");
                        Print("S2: ", S2, "\n");
                        Print("S3: ", S3, "\n");
                        Print("wK: ", wK, "\n");
                        Print("w: ", w, "\n");
                    fi;
                od;
            od;
        od;
    od;
    
    Print("Done.\n");
od;

