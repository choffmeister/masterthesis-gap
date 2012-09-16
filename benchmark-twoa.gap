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
    rec(system := CoxeterGroup_An(10), thetas := [ "id" ]),
    rec(system := CoxeterGroup_An(11), thetas := [ "id" ]),
    rec(system := CoxeterGroup_BCn(2), thetas := [ "id" ]),
    rec(system := CoxeterGroup_BCn(3), thetas := [ "id" ]),
    rec(system := CoxeterGroup_BCn(4), thetas := [ "id" ]),
    rec(system := CoxeterGroup_BCn(5), thetas := [ "id" ]),
    rec(system := CoxeterGroup_BCn(6), thetas := [ "id" ]),
    rec(system := CoxeterGroup_Dn(4), thetas := [ "id" ]),
    rec(system := CoxeterGroup_Dn(5), thetas := [ "id" ]),
    rec(system := CoxeterGroup_Dn(6), thetas := [ "id" ]),
    rec(system := CoxeterGroup_F4(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_H3(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_H4(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_E6(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_E7(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_E8(), thetas := [ "id" ]),
];

WriteResults := function(file, system, algo, time, result, comparisons)
    IO_Write(file, algo, ",", Name(system.group), ",", system.rank, ",", Size(system.group), ",",
        Float(time/1000), ",", result.maxTwistedLength, ",", result.numVertices, ",", result.numEdges, ",",
        comparisons, "\n");    
end;

file := IO_File("benchmarks/benchmark", "w", 1);
IO_Write(file,"algo,W,rankW,sizeW,time,maxRho,numVertices,numEdges,comparisons\n");

for task in tasks do
    W := task.system.group;
    matrix := task.system.matrix;
    
    for theta in task.thetas do
        Print(Name(W), "\n");
        theta := GroupAutomorphismByPermutation(W, theta);
        
        Print("TWOA3\n");
        k := 0;
        startTime := Runtime();
        endTime := startTime;
        while (endTime - startTime < 1000) do
            coxeterElementComparisons := 0;
            result := TwistedInvolutionWeakOrdering3(fail, W, matrix, theta);
            endTime := Runtime();
            k := k + 1;
        od;
        WriteResults(file, task.system, 3, (endTime - startTime)/k, result, coxeterElementComparisons);

        Print("TWOA2\n");
        k := 0;
        startTime := Runtime();
        endTime := startTime;
        while (endTime - startTime < 1000) do
            coxeterElementComparisons := 0;
            result := TwistedInvolutionWeakOrdering2(fail, W, matrix, theta);
            endTime := Runtime();
            k := k + 1;
        od;
        WriteResults(file, task.system, 2, (endTime - startTime)/k, result, coxeterElementComparisons);

        Print("TWOA1\n");
        k := 0;
        startTime := Runtime();
        endTime := startTime;
        while (endTime - startTime < 1000) do
            coxeterElementComparisons := 0;
            result := TwistedInvolutionWeakOrdering1(fail, W, matrix, theta);
            endTime := Runtime();
            k := k + 1;
        od;
        WriteResults(file, task.system, 1, (endTime - startTime)/k, result, coxeterElementComparisons);
    od;
od;

IO_Close(file);
