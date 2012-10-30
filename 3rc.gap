Read("twistedinvolutionweakordering.gap");

tasks := [];

for n in [3..13] do Add(tasks, rec(system := CoxeterGroup_An(n), thetas := [ "id", "-id" ], kmax := -1)); od;
for n in [3..10] do Add(tasks, rec(system := CoxeterGroup_BCn(n), thetas := [ "id", ], kmax := -1)); od;
for n in [4..8] do Add(tasks, rec(system := CoxeterGroup_Dn(n), thetas := [ "id", ], kmax := -1)); od;
Add(tasks, rec(system := CoxeterGroup_E6(), thetas := [ "id", [6,5,3,4,2,1] ], kmax := -1));
Add(tasks, rec(system := CoxeterGroup_E7(), thetas := [ "id" ], kmax := -1));
Add(tasks, rec(system := CoxeterGroup_E8(), thetas := [ "id" ], kmax := -1));
Add(tasks, rec(system := CoxeterGroup_F4(), thetas := [ "id" ], kmax := -1));
Add(tasks, rec(system := CoxeterGroup_H3(), thetas := [ "id" ], kmax := -1));
Add(tasks, rec(system := CoxeterGroup_H4(), thetas := [ "id" ], kmax := -1));

for n in [3..7] do Add(tasks, rec(system := CoxeterGroup_TildeAn(n), thetas := [ "id" ], kmax := 3*n*(n+1)/2)); od;
for n in [3..7] do Add(tasks, rec(system := CoxeterGroup_TildeBn(n), thetas := [ "id" ], kmax := 3*n*n)); od;
for n in [3..7] do Add(tasks, rec(system := CoxeterGroup_TildeCn(n), thetas := [ "id" ], kmax := 3*n*n)); od;
for n in [4..4] do Add(tasks, rec(system := CoxeterGroup_TildeDn(n), thetas := [ "id" ], kmax := 3*n*(n-1))); od;
Add(tasks, rec(system := CoxeterGroup_TildeE6(), thetas := [ "id" ], kmax := 3*36));
Add(tasks, rec(system := CoxeterGroup_TildeE7(), thetas := [ "id" ], kmax := 3*63));
Add(tasks, rec(system := CoxeterGroup_TildeE8(), thetas := [ "id" ], kmax := 3*120));
Add(tasks, rec(system := CoxeterGroup_TildeF4(), thetas := [ "id" ], kmax := 3*24));

Sort(tasks, function(u,v)
    local a,b;
    
    if u.kmax = -1 then
        a := Size(u.system.group);
    else
        a := (u.system.rank/2)^u.kmax;
    fi;
    
    if v.kmax = -1 then
        b := Size(v.system.group);
    else
        b := (v.system.rank/2)^v.kmax;
    fi;
    
    return a < b;
end);

for task in tasks do
    W := task.system.group;
    matrix := task.system.matrix;
    kmax := task.kmax;
    
    for theta in task.thetas do
        theta := GroupAutomorphismByPermutation(W, theta);
        
        Print("Wk(", Name(W), ", ", Name(theta), ")\n");
        filename := StringToFilename(Concatenation(Name(W), "-", Name(theta)));
 
        # calculate Wk(W,\theta)
        Print("- Calculating poset\n");
        TwistedInvolutionWeakOrdering3(filename, W, matrix, theta, kmax);

        # check if Wk(W,\theta) is 3-residually connected
        Print("- Checking for 3-residually connectedness\n");
        counterexample := TwistedInvolutionWeakOrderingSearchForNon3rcCase(filename);
        
        if counterexample <> fail then
            counterexamplefile := IO_File(Concatenation("counterexamples/", filename), "w", 1);
            IO_Write(counterexamplefile,
                "W = ", counterexample.W, "\n",
                "theta = ", counterexample.theta, "\n",
                "S = ", counterexample.S, "\n",
                "K = ", counterexample.K, "\n",
                "wK = ", counterexample.wK, "\n",
                "T = ", counterexample.T, "\n",
                "S12 = ", counterexample.S12, "\n",
                "S23 = ", counterexample.S23, "\n",
                "S31 = ", counterexample.S31, "\n",
                "w = ", counterexample.w, "\n\n\n\n");
            IO_Close(counterexamplefile);
            
            Print("- IS NOT 3RC **************************************\n\n");
        else
            Print("- IS 3RC\n\n");
        fi;
    od;
od;
