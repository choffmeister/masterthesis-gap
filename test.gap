Read("misc.gap");
Read("coxeter.gap");
Read("twistedinvolution.gap");

# By now we suppose, that W is finite
W := CoxeterGroup_An(3);
S := GeneratorsOfGroup(W);

#theta := function (w)
#    local letters, perm;
#    
#    perm := [3, 2, 1];
#    
#    letters := GroupWordToLetters(w, W);
#    
#    letters := List(letters, n -> perm[n]);
#    
#    return GroupLettersToWord(letters, W);
#end;
theta := w -> w;

Print(TwistedInvolutionWeakOrdering(theta, S, W));

