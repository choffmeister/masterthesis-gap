# Generates a list of generator indices from a word.
#
# Example:
# G := FreeGroup(2);
# a := G.1;
# b := G.2;
# letters := GroupWordToLetters(a*a*b*a, G);
#
# letters <- [1,1,2,1]
GroupWordToLetters := function (word, G)
    local rep;
    
    rep := ExtRepOfObj(word);
    
    return Flat(List([1,3..Length(rep)-1], m -> List([1..rep[m+1]], k -> rep[m])));
end;

# Generates a word from a list of generator indices.
#
# Example:
# G := FreeGroup(2);
# a := G.1;
# b := G.2;
# word := GroupLettersToWord([1,1,2,1], G);
#
# word <- a^2*b*a
GroupLettersToWord := function (letters, G)
    local result, generators, i;
    
    result := One(G);
    generators := GeneratorsOfGroup(G);
    
    for i in [1..Length(letters)] do
        result := result * generators[letters[i]];
    od;
    
    return result;
end;

GroupAutomorphismByImages := function (G, generatorPermutation)
    local automorphism, generators;
    
    generators := GeneratorsOfGroup(G);
    automorphism := GroupHomomorphismByImages(G, G, generators, generators{generatorPermutation});
    
    if (generatorPermutation = [1..Length(generators)]) then
        SetName(automorphism, "id");
    else
        SetName(automorphism, Concatenation("(", JoinStringsWithSeparator(generatorPermutation, ","), ")"));
    fi;

    return automorphism;
end;

GroupAutomorphismIdentity := function (G)
    return GroupAutomorphismByImages(G, [1..Length(GeneratorsOfGroup(G))]);
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


FindElementIndex := function (list, selector)
    local i;
    
    for i in [1..Length(list)] do
        if (selector(list[i])) then
            return i;
        fi;
    od;
    
    return -1;
end;

