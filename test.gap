Read("misc.gap");
Read("coxeter.gap");
Read("twistedinvolution.gap");

# By now we suppose, that W is finite
Print("Generating coxeter group... ");
W := CoxeterGroup_An(3);
S := GeneratorsOfGroup(W);
Print("Done.\n");

theta := w -> w;

Print("Calculating Wk(theta)...\n");
TwistedInvolutionCalculateWktheta(theta, S, W);
Print("Done.\n");

