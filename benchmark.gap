Read("twistedinvolutionweakordering.gap");

tasks := [];
for n in [1..11] do Add(tasks, rec(system := CoxeterGroup_An(n), thetas := [ [1..n] ], kmax := -1)); od;
for n in [2..6] do Add(tasks, rec(system := CoxeterGroup_BCn(n), thetas := [ [1..n] ], kmax := -1)); od;
for n in [4..6] do Add(tasks, rec(system := CoxeterGroup_Dn(n), thetas := [ [1..n] ], kmax := -1)); od;
Add(tasks, rec(system := CoxeterGroup_F4(), thetas := [ [1..4] ], kmax := -1));
Add(tasks, rec(system := CoxeterGroup_H3(), thetas := [ [1..3] ], kmax := -1));
Add(tasks, rec(system := CoxeterGroup_H4(), thetas := [ [1..4] ], kmax := -1));
Add(tasks, rec(system := CoxeterGroup_E6(), thetas := [ [1..6] ], kmax := -1));
Add(tasks, rec(system := CoxeterGroup_E7(), thetas := [ [1..7] ], kmax := -1));
Add(tasks, rec(system := CoxeterGroup_E8(), thetas := [ [1..8] ], kmax := -1));

WriteResults := function(file, system, algo, time, result, comparisons)
    IO_Write(file, algo, ",$", Name(system.group), "$,", system.rank, ",", Size(system.group), ",",
        Float(time/1000), ",", result.maxTwistedLength, ",", result.numVertices, ",", result.numEdges, ",",
        comparisons, "\n");    
end;

file := IO_File("benchmarks/benchmark", "w", 1);
IO_Write(file,"A,W,R,S,T,H,V,E,C\n");

for task in tasks do
    W := task.system.group;
    matrix := task.system.matrix;
    kmax := task.kmax;
    
    for theta in task.thetas do
        Print(Name(W), "\n");

        Print("TWOA3\n");
        k := 0;
        startTime := Runtime();
        endTime := startTime;
        while (endTime - startTime < 1000) do
            coxeterElementComparisons := 0;
            result := TwistedInvolutionWeakOrdering3(fail, W, matrix, theta, kmax);
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
            result := TwistedInvolutionWeakOrdering2(fail, W, matrix, theta, kmax);
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
            result := TwistedInvolutionWeakOrdering1(fail, W, matrix, theta, kmax);
            endTime := Runtime();
            k := k + 1;
        od;
        WriteResults(file, task.system, 1, (endTime - startTime)/k, result, coxeterElementComparisons);
    od;
od;

IO_Close(file);
