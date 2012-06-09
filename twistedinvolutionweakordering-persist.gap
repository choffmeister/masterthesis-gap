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
    local edgesSorted, n, e;
    
    edgesSorted := StructuralCopy(edges);

    Sort(edgesSorted, function (a, b) return a.sourceIndex < b.sourceIndex or a.targetIndex < b.targetIndex; end);

    for n in nodes do
        if n.absIndex = 1 then
            PrintTo(persistInfo.fileV, "\n");
            PrintTo(persistInfo.fileV, "[", n.twistedLength, ",\"e\"]");
        else
            PrintTo(persistInfo.fileV, ",\n");
            PrintTo(persistInfo.fileV, "[", n.twistedLength, ",\"", n.element, "\"]");
        fi;
    od;
    
    for e in edgesSorted do
        if e.absIndex = 1 then
            PrintTo(persistInfo.fileE, "\n");
        else
            PrintTo(persistInfo.fileE, ",\n");
        fi;
    
        PrintTo(persistInfo.fileE, "[", e.sourceIndex-1, ",", e.targetIndex-1, ",", e.label, ",", e.type, "]");
    od;
end;
