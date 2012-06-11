TwistedInvolutionWeakOrderingPersistResultsInit := function(filename)
    local fileV, fileE;
    
    fileV := OutputTextFile(Concatenation("results/", filename, "-vertices"), false);
    fileE := OutputTextFile(Concatenation("results/", filename, "-edges"), false);
    SetPrintFormattingStatus(fileV, false);
    SetPrintFormattingStatus(fileE, false);
    PrintTo(fileV, "[");
    PrintTo(fileE, "[");
    
    return rec(fileV := fileV, fileE := fileE);
end;

TwistedInvolutionWeakOrderingPersistResultsClose := function(persistInfo)
    PrintTo(persistInfo.fileV, "\n]");
    PrintTo(persistInfo.fileE, "\n]");
    
    CloseStream(persistInfo.fileV);
    CloseStream(persistInfo.fileE);
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
            PrintTo(persistInfo.fileV, "\n");
            PrintTo(persistInfo.fileV, "[", n.twistedLength, ",\"e\"]");
        else
            PrintTo(persistInfo.fileV, ",\n");
            PrintTo(persistInfo.fileV, "[", n.twistedLength, ",\"", n.element, "\"]");
        fi;
    od;
    
    for e in edges do
        if e.absIndex = 1 then
            PrintTo(persistInfo.fileE, "\n");
        else
            PrintTo(persistInfo.fileE, ",\n");
        fi;
    
        PrintTo(persistInfo.fileE, "[", e.source.absIndex-1, ",", e.target.absIndex-1, ",", e.label, ",", e.type, "]");
    od;
end;
