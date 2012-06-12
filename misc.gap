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

