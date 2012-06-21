TwistedInvolutionWeakOrderingPersistReadResults := function(filename)
    local fileD, fileV, fileE, csvLine, data, vertices, edges, newEdge, source, target;
    
    fileD := IO_File(Concatenation("results/", filename, "-data"), "r");
    fileV := IO_File(Concatenation("results/", filename, "-vertices"), "r", 1024*1024);
    fileE := IO_File(Concatenation("results/", filename, "-edges"), "r", 1024*1024);
    
    data := NextIterator(IO_ReadLinesIteratorCSV(fileD, ";"));
    vertices := [];
    edges := [];
    
    for csvLine in IO_ReadLinesIteratorCSV(fileV, ";") do
        Add(vertices, rec(twistedLength := csvLine.twistedLength, name := csvLine.name, inEdges := [], outEdges := []));
    od;
    
    for csvLine in IO_ReadLinesIteratorCSV(fileE, ";") do
        source := vertices[csvLine.sourceIndex + 1];
        target := vertices[csvLine.targetIndex + 1];
        newEdge := rec(source := source, target := target, label := csvLine.label, type := csvLine.type);
        
        Add(source.outEdges, newEdge);
        Add(target.inEdges, newEdge);
        Add(edges, newEdge);
    od;
    
    IO_Close(fileD);
    IO_Close(fileV);
    IO_Close(fileE);
    
    return rec(data := data, vertices := vertices, edges := edges);
end;

TwistedInvolutionWeakOrderingPersistResultsInit := function(filename)
    local fileD, fileV, fileE;
    
    fileD := IO_File(Concatenation("results/", filename, "-data"), "w");
    fileV := IO_File(Concatenation("results/", filename, "-vertices"), "w", 1024*1024);
    fileE := IO_File(Concatenation("results/", filename, "-edges"), "w", 1024*1024);
    IO_Write(fileD, "name;rank;size;generators;matrix;automorphism;wk_size;wk_max_length;calculation_time\n");
    IO_Write(fileV, "twistedLength;name\n");
    IO_Write(fileE, "sourceIndex;targetIndex;label;type\n");

    return rec(fileD := fileD, fileV := fileV, fileE := fileE);
end;

TwistedInvolutionWeakOrderingPersistResultsClose := function(persistInfo)
    IO_Close(persistInfo.fileD);
    IO_Close(persistInfo.fileV);
    IO_Close(persistInfo.fileE);
end;

TwistedInvolutionWeakOrderingPersistResultsInfo := function(persistInfo, W, matrix, theta, numNodes, maxTwistedLength, runtime)
    IO_Write(persistInfo.fileD, "\"", ReplacedString(Name(W), "\\", "\\\\"), "\";");
    IO_Write(persistInfo.fileD, Length(GeneratorsOfGroup(W)), ";");
    if (Size(W) = infinity) then
        IO_Write(persistInfo.fileD, "\"infinity\";");
    else
        IO_Write(persistInfo.fileD, Size(W), ";");
    fi;
    IO_Write(persistInfo.fileD, "[", JoinStringsWithSeparator(List(GeneratorsOfGroup(W), n -> Concatenation("\"", String(n), "\"")), ","), "];");
    IO_Write(persistInfo.fileD, "[", JoinStringsWithSeparator(matrix, ","), "];");
    IO_Write(persistInfo.fileD, "\"", Name(theta), "\";");

    if (Size(W) = infinity) then
        IO_Write(persistInfo.fileD, "\"infinity\";");
        IO_Write(persistInfo.fileD, "\"infinity\";");
    else
        IO_Write(persistInfo.fileD, numNodes, ";");
        IO_Write(persistInfo.fileD, maxTwistedLength, ";");
    fi;
    
    IO_Write(persistInfo.fileD, "\"", ReplacedString(StringTime(runtime), " ", ""), "\"");
end;

TwistedInvolutionWeakOrderingPersistResults := function(persistInfo, nodes, edges)
    local n, e, i, tmp, bubbles;
    
    # bubble sort the edges, to make sure, that double edges are neighbours in the list
    bubbles := 1;
    while bubbles > 0 do
        bubbles := 0;
        for i in [1..Length(edges)-1] do
            if edges[i].source.absIndex = edges[i+1].source.absIndex and edges[i].target.absIndex > edges[i+1].target.absIndex then
                tmp := edges[i];
                edges[i] := edges[i+1];
                edges[i+1] := tmp;
                bubbles := bubbles + 1;
            fi;
        od;
    od;

    for n in nodes do
        if n.absIndex = 1 then
            IO_Write(persistInfo.fileV, n.twistedLength, ";\"e\"\n");
        else
            IO_Write(persistInfo.fileV, n.twistedLength, ";\"", String(n.element), "\"\n");
        fi;
    od;
    
    for e in edges do
        IO_Write(persistInfo.fileE, e.source.absIndex-1, ";", e.target.absIndex-1, ";", e.label, ";", e.type, "\n");
    od;
end;
