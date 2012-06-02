# Finds the maximal element in a list by a given evaluator. The evaluator has
# to map every element in the list to an integer.
#
# Example:
# L := [1,3,-1,-4];
# max := FindMaxElement(L, n -> AbsInt(n));
#
# max <- -4
FindMaxElement := function (list, evaluator)
    local maxElement, maxValue, i;
        
    maxElement := list[1];
    maxValue := evaluator(maxElement);
    
    for i in [2..Length(list)] do
        if (evaluator(list[i]) > maxValue) then
            maxElement := list[i];
        fi;
    od;

    return maxElement;
end;

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

# Tests if a group is invariant under a given homomorphism.
#
# Example:
# G := FreeGroup(2);
# a := G.1;
# b := G.2;
# G2 := Group(a);
#
# h1 := g -> g;
# h2 := (a <-> b);
#
# i1 := IsGroupInvariantUnderHomomorphism(h1, G2);
# i2 := IsGroupInvariantUnderHomomorphism(h2, G2);
#
# i1 <- true
# i2 <- false
IsGroupInvariantUnderHomomorphism := function (homomorphism, group)
    local g;
    
    for g in GeneratorsOfGroup(group) do
        if not (homomorphism(g) in group) then
            return false;
        fi;
    od;

    return true;
end;

GeneratorTranspositioningMap := function(transpositions, W)
    return function(w)
        local letters, t;

        letters := GroupWordToLetters(w, W);

        letters := List(letters, function (n)
            for t in transpositions do
                if t[1] = n then
                    return t[2];
                fi;
                
                if t[2] = n then
                    return t[1];
                fi;
            od;
            
            return n;
        end);

        return GroupLettersToWord(letters, W);
    end;
end;

GeneratorPermutatingMap := function(permutation, W)
    return function(w)
        local letters;

        letters := GroupWordToLetters(w, W);

        letters := List(letters, n -> permutation[n]);

        return GroupLettersToWord(letters, W);
    end;
end;

