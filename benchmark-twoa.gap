Read("twistedinvolutionweakordering.gap");

tasks := [
    rec(system := CoxeterGroup_An(1), thetas := [ "id" ]),
    rec(system := CoxeterGroup_An(2), thetas := [ "id" ]),
    rec(system := CoxeterGroup_An(3), thetas := [ "id" ]),
    rec(system := CoxeterGroup_An(4), thetas := [ "id" ]),
    rec(system := CoxeterGroup_An(5), thetas := [ "id" ]),
    rec(system := CoxeterGroup_An(6), thetas := [ "id" ]),
    rec(system := CoxeterGroup_An(7), thetas := [ "id" ]),
    rec(system := CoxeterGroup_An(8), thetas := [ "id" ]),
    rec(system := CoxeterGroup_An(9), thetas := [ "id" ]),
    #rec(system := CoxeterGroup_An(10), thetas := [ "id" ]),
    #rec(system := CoxeterGroup_An(11), thetas := [ "id" ]),
    rec(system := CoxeterGroup_E6(), thetas := [ "id" ]),
    #rec(system := CoxeterGroup_E7(), thetas := [ "id" ]),
];

benchmarks := [];

for task in tasks do
    W := task.system.group;
    matrix := task.system.matrix;
    
    for theta in task.thetas do
        theta := GroupAutomorphismByPermutation(W, theta);
        Print(Name(W), " ", Name(theta), "\n");
        
        coxeterElementComparisons := 0;
        startTime := Runtime();
        result := TwistedInvolutionWeakOrdering1(fail, W, matrix, theta);
        endTime := Runtime();
        
        Add(benchmarks, rec(name := Name(W), algo := "TWOA1", time := StringTime(endTime - startTime), result := result, comparisons := coxeterElementComparisons));
        
        coxeterElementComparisons := 0;
        startTime := Runtime();
        result := TwistedInvolutionWeakOrdering2(fail, W, matrix, theta);
        endTime := Runtime();
        
        Add(benchmarks, rec(name := Name(W), algo := "TWOA2", time := StringTime(endTime - startTime), result := result, comparisons := coxeterElementComparisons));
        
        coxeterElementComparisons := 0;
        startTime := Runtime();
        result := TwistedInvolutionWeakOrdering3(fail, W, matrix, theta);
        endTime := Runtime();
        
        Add(benchmarks, rec(name := Name(W), algo := "TWOA3", time := StringTime(endTime - startTime), result := result, comparisons := coxeterElementComparisons));
    od;
od;

Print("Algo\tW\ttime\t\tmax rho\t|V|\t|E|\tcomparisons\n");
for b in benchmarks do
    Print(b.algo, "\t", b.name, "\t", b.time, "\t", b.result.maxTwistedLength, "\t", b.result.numVertices, "\t", b.result.numEdges, "\t", b.comparisons, "\n");
od;
