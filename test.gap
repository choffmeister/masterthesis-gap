Read("words.gap");
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

Theta := w -> w;

W := CoxeterGroup_An(3);
S := GeneratorsOfGroup(W);
s1 := W.1;
s2 := W.2;
s3 := W.3;

for K in Filtered(Combinations(S), K -> Length(K) > 0) do
    Print(K, "\n");
    Kgroup := Group(K);
    Print(Elements(Kgroup), "\n");
od;

