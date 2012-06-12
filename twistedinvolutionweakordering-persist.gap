TwistedInvolutionWeakOrderingPersistResultsInit := function(filename)
    local fileV, fileE;
    
    fileV := IO_File(Concatenation("results/", filename, "-vertices"), "w", 1024*1024);
    fileE := IO_File(Concatenation("results/", filename, "-edges"), "w", 1024*1024);
    IO_Write(fileV, "[");
    IO_Write(fileE, "[");
    
    return rec(fileV := fileV, fileE := fileE);
end;

TwistedInvolutionWeakOrderingPersistResultsClose := function(persistInfo)
    IO_Write(persistInfo.fileV, "\n]");
    IO_Write(persistInfo.fileE, "\n]");
    
    IO_Close(persistInfo.fileV);
    IO_Close(persistInfo.fileE);
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
            IO_Write(persistInfo.fileV, "\n");
            IO_Write(persistInfo.fileV, "[", n.twistedLength, ",\"e\"]");
        else
            IO_Write(persistInfo.fileV, ",\n");
            IO_Write(persistInfo.fileV, "[", n.twistedLength, ",\"", n.element, "\"]");
        fi;
    od;
    
    for e in edges do
        if e.absIndex = 1 then
            IO_Write(persistInfo.fileE, "\n");
        else
            IO_Write(persistInfo.fileE, ",\n");
        fi;
    
        IO_Write(persistInfo.fileE, "[", e.source.absIndex-1, ",", e.target.absIndex-1, ",", e.label, ",", e.type, "]");
    od;
end;
