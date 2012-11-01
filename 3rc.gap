Read("twistedinvolutionweakordering.gap");

tasks := [];

for n in [8..8] do Add(tasks, rec(system := CoxeterGroup_An(n), thetas := [ [1..n], Reversed([1..n]) ], kmax := -1)); od;
#for n in [3..10] do Add(tasks, rec(system := CoxeterGroup_BCn(n), thetas := [ "id", ], kmax := -1)); od;
#for n in [4..8] do Add(tasks, rec(system := CoxeterGroup_Dn(n), thetas := [ "id", ], kmax := -1)); od;
#Add(tasks, rec(system := CoxeterGroup_E6(), thetas := [ "id", [6,5,3,4,2,1] ], kmax := -1));
#Add(tasks, rec(system := CoxeterGroup_E7(), thetas := [ "id" ], kmax := -1));
#Add(tasks, rec(system := CoxeterGroup_E8(), thetas := [ "id" ], kmax := -1));
#Add(tasks, rec(system := CoxeterGroup_F4(), thetas := [ "id" ], kmax := -1));
#Add(tasks, rec(system := CoxeterGroup_H3(), thetas := [ "id" ], kmax := -1));
#Add(tasks, rec(system := CoxeterGroup_H4(), thetas := [ "id" ], kmax := -1));

#for n in [3..7] do Add(tasks, rec(system := CoxeterGroup_TildeAn(n), thetas := [ "id" ], kmax := 3*n*(n+1)/2)); od;
#for n in [3..7] do Add(tasks, rec(system := CoxeterGroup_TildeBn(n), thetas := [ "id" ], kmax := 3*n*n)); od;
#for n in [3..7] do Add(tasks, rec(system := CoxeterGroup_TildeCn(n), thetas := [ "id" ], kmax := 3*n*n)); od;
#for n in [4..4] do Add(tasks, rec(system := CoxeterGroup_TildeDn(n), thetas := [ "id" ], kmax := 3*n*(n-1))); od;
#Add(tasks, rec(system := CoxeterGroup_TildeE6(), thetas := [ "id" ], kmax := 3*36));
#Add(tasks, rec(system := CoxeterGroup_TildeE7(), thetas := [ "id" ], kmax := 3*63));
#Add(tasks, rec(system := CoxeterGroup_TildeE8(), thetas := [ "id" ], kmax := 3*120));
#Add(tasks, rec(system := CoxeterGroup_TildeF4(), thetas := [ "id" ], kmax := 3*24));

#for p in [7..10] do Add(tasks, rec(system := CoxeterGroup_X31p(p), thetas := [ "id" ], kmax := 3*p)); od;
#for p in [4..10] do for q in [Maximum(5, p)..10] do Add(tasks, rec(system := CoxeterGroup_X32pq(p, q), thetas := [ "id" ], kmax := 3*q)); od; od;
#for p in [3..10] do for q in [Maximum(3, p)..10] do for r in [Maximum(4, q)..10] do Add(tasks, rec(system := CoxeterGroup_X33pqr(p, q, r), thetas := [ "id" ], kmax := 3*r)); od; od; od;

#Add(tasks, rec(system := CoxeterGroup_X41(), thetas := [ "id" ], kmax := 3*15));
#Add(tasks, rec(system := CoxeterGroup_X42(), thetas := [ "id" ], kmax := 3*15));
#Add(tasks, rec(system := CoxeterGroup_X43(), thetas := [ "id" ], kmax := 3*15));
#Add(tasks, rec(system := CoxeterGroup_X44(), thetas := [ "id" ], kmax := 3*15));
#Add(tasks, rec(system := CoxeterGroup_X45(), thetas := [ "id" ], kmax := 3*9));
#Add(tasks, rec(system := CoxeterGroup_X46(), thetas := [ "id" ], kmax := 3*9));
#Add(tasks, rec(system := CoxeterGroup_X47(), thetas := [ "id" ], kmax := 3*15));
#Add(tasks, rec(system := CoxeterGroup_X48(), thetas := [ "id" ], kmax := 3*15));
#Add(tasks, rec(system := CoxeterGroup_X49(), thetas := [ "id" ], kmax := 3*15));
#Add(tasks, rec(system := CoxeterGroup_X51(), thetas := [ "id" ], kmax := 3*60));
#Add(tasks, rec(system := CoxeterGroup_X52(), thetas := [ "id" ], kmax := 3*60));
#Add(tasks, rec(system := CoxeterGroup_X53(), thetas := [ "id" ], kmax := 3*60));
#Add(tasks, rec(system := CoxeterGroup_X54(), thetas := [ "id" ], kmax := 3*60));
#Add(tasks, rec(system := CoxeterGroup_X55(), thetas := [ "id" ], kmax := 3*60));

for task in tasks do
    W := task.system.group;
    matrix := task.system.matrix;
    kmax := task.kmax;
    
    for theta in task.thetas do
        # handle Wk(W,\theta)
        Print("Wk(", Name(W), ", ", theta, ")\n");
        filename := StringToFilename(Concatenation(Name(W), "-", String(List(theta, p -> p))));
        
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
            Print("- IS 3RC                                           \n\n");
        fi;
    od;
od;
