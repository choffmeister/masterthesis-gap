Read("misc.gap");
Read("coxeter.gap");
Read("twistedinvolution.gap");

# By now we suppose, that W is finite
W := CoxeterGroup_An(5);
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

file := OutputTextFile("result_Wk_A5_id", true);
SetPrintFormattingStatus(file, false);
PrintTo(file, TwistedInvolutionWeakOrdering(theta, S, W));
PrintTo(file, "\n\n\n");
CloseStream(file);

