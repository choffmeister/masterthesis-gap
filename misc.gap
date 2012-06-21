GroupAutomorphismByPermutation := function (G, generatorPermutation)
    local automorphism, generators;
    
    generators := GeneratorsOfGroup(G);
    
    if generatorPermutation = "id" or generatorPermutation = [1..Length(generators)] then
        automorphism := IdentityMapping(G);
        SetName(automorphism, "id");
        
        return automorphism;
    elif generatorPermutation = "-id" then
        generatorPermutation := Reversed([1..Length(GeneratorsOfGroup(G))]);
    fi;
    
    automorphism := GroupHomomorphismByImages(G, G, generators, generators{generatorPermutation});
    SetName(automorphism, Concatenation("(", JoinStringsWithSeparator(generatorPermutation, ","), ")"));

    return automorphism;
end;

GroupAutomorphismIdNeg := function (G)
    return GroupAutomorphismByPermutation(G, Reversed([1..Length(GeneratorsOfGroup(G))]));
end;

GroupAutomorphismId := function (G)
    return GroupAutomorphismByPermutation(G, [1..Length(GeneratorsOfGroup(G))]);
end;

FindElement := function (list, selector)
    local i;
    
    for i in [1..Length(list)] do
        if (selector(list[i])) then
            return list[i];
        fi;
    od;
    
    return fail;
end;

StringToFilename := function(str)
    local result, c;
    
    result := "";
    
    for c in str do
        if IsDigitChar(c) or IsAlphaChar(c) or c = '-' or c = '_' then
            Add(result, c);
        else
            Add(result, '_');
        fi;
    od;
    
    return result;
end;

IO_ReadLinesIterator := function (file)
    local IsDone, Next, ShallowCopy;
    
    IsDone := function (iter)
        return iter!.nextLine = "" or iter!.nextLine = fail;
    end;
    
    Next := function (iter)
        local line;
        
        line := iter!.nextLine;
        
        if line = fail then
            Error(LastSystemError());
            return fail;
        fi;
        
        iter!.nextLine := IO_ReadLine(iter!.file);
        
        return Chomp(line);
    end;
    
    ShallowCopy := function (iter)
        return fail;
    end;
    
    return IteratorByFunctions(rec(IsDoneIterator := IsDone, NextIterator := Next,
        ShallowCopy := ShallowCopy, file := file, nextLine := IO_ReadLine(file)));
end;

IO_ReadLinesIteratorCSV := function (file, seperator)
    local IsDone, Next, ShallowCopy;
    
    IsDone := function (iter)
        return iter!.nextLine = "" or iter!.nextLine = fail;
    end;
    
    Next := function (iter)
        local line, lineSplitted, result, i;
        
        line := iter!.nextLine;
        if line = fail then
            Error(LastSystemError());
            return fail;
        fi;
        iter!.nextLine := IO_ReadLine(iter!.file);
        
        lineSplitted := SplitString(Chomp(line), iter!.seperator);
        result := rec();
        
        for i in [1..Minimum(Length(iter!.headers), Length(lineSplitted))] do
            result.(iter!.headers[i]) := EvalString(lineSplitted[i]);
        od;
        
        return result;
    end;
    
    ShallowCopy := function (iter)
        return fail;
    end;
    
    return IteratorByFunctions(rec(IsDoneIterator := IsDone, NextIterator := Next,
        ShallowCopy := ShallowCopy, file := file, seperator := seperator,
        headers := SplitString(Chomp(IO_ReadLine(file)), seperator),
        nextLine := IO_ReadLine(file)));
end;

