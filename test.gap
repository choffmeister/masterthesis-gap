Read("misc.gap");
Read("coxeter.gap");
Read("twistedinvolution.gap");

# By now we suppose, that W is finite
Print("Generating coxeter group... ");
W := CoxeterGroup_An(3);
S := GeneratorsOfGroup(W);
s1 := W.1;
s2 := W.2;
s3 := W.3;
Print("Done.\n");

theta := function (w)
    local letters, perm;
    
    perm := [3, 2, 1];
    
    letters := GroupWordToLetters(w, W);
    
    letters := List(letters, n -> perm[n]);
    
    return GroupLettersToWord(letters, W);
end;
theta := w -> w;

Print("Calculating Wk(theta)...\n");
TwistedInvolutionCalculateWktheta(theta, S, W);
Print("Done.\n");

