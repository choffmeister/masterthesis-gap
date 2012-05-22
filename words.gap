GroupWordToLetters := function (word, G)
    local rep;
    
    rep := ExtRepOfObj(word);
    
    return Flat(List([1,3..Length(rep)-1], m -> List([1..rep[m+1]], k -> rep[m])));
end;

GroupLettersToWord := function (letters, G)
    local result, generators, i;
    
    result := One(G);
    generators := GeneratorsOfGroup(G);
    
    for i in [1..Length(letters)] do
        result := result * generators[letters[i]];
    od;
    
    return result;
end;

