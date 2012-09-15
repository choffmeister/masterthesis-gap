Read("twistedinvolutionweakordering.gap");

tasks := [
    rec(system := CoxeterGroup_An(1), thetas := [ "id" ]),
    rec(system := CoxeterGroup_An(2), thetas := [ "id" ]),
    rec(system := CoxeterGroup_An(3), thetas := [ "id" ]),
];

file := IO_File("benchmarks/benchmark", "w");
IO_Write(file,"algo,W,rankW,sizeW,time,maxRho,numVertices,numEdges,comparisons\n");

WriteResults := function(system, algo, time, result, comparisons)
    IO_Write(file, algo, ",", Name(system.group), ",", system.rank, ",", Size(system.group), ",", time, ",", result.maxTwistedLength, ",", result.numVertices, ",", result.numEdges, ",", comparisons, "\n");
end;

for task in tasks do
    W := task.system.group;
    matrix := task.system.matrix;
    
    for theta in task.thetas do
        theta := GroupAutomorphismByPermutation(W, theta);

        coxeterElementComparisons := 0;
        startTime := Runtime();
        result := TwistedInvolutionWeakOrdering3(fail, W, matrix, theta);
        endTime := Runtime();
        WriteResults(task.system, 3, endTime - startTime, result, coxeterElementComparisons);

        coxeterElementComparisons := 0;
        startTime := Runtime();
        result := TwistedInvolutionWeakOrdering2(fail, W, matrix, theta);
        endTime := Runtime();
        WriteResults(task.system, 2, endTime - startTime, result, coxeterElementComparisons);
        
        coxeterElementComparisons := 0;
        startTime := Runtime();
        result := TwistedInvolutionWeakOrdering1(fail, W, matrix, theta);
        endTime := Runtime();
        WriteResults(task.system, 1, endTime - startTime, result, coxeterElementComparisons);
    od;
od;

IO_Close(file);
