Read("misc.gap");
Read("coxeter.gap");
Read("twistedinvolution.gap");

# A_1
Print("A_1, id\n");
W := CoxeterGroup_An(1);
S := GeneratorsOfGroup(W);
theta := w -> w;
wk := TwistedInvolutionWeakOrdering(theta, S, W);
LogWeakOrderingResult(Name(W), "id", wk);


# A_2
Print("A_2, id\n");
W := CoxeterGroup_An(2);
S := GeneratorsOfGroup(W);
theta := w -> w;
wk := TwistedInvolutionWeakOrdering(theta, S, W);
LogWeakOrderingResult(Name(W), "id", wk);

Print("A_2, (12)\n");
theta := GeneratorPermutatingMap([2, 1], W);
wk := TwistedInvolutionWeakOrdering(theta, S, W);
LogWeakOrderingResult(Name(W), "(12)", wk);


# A_3
Print("A_3, id\n");
W := CoxeterGroup_An(3);
S := GeneratorsOfGroup(W);
theta := w -> w;
wk := TwistedInvolutionWeakOrdering(theta, S, W);
LogWeakOrderingResult(Name(W), "id", wk);

Print("A_3, (13)\n");
theta := GeneratorPermutatingMap([3, 2, 1], W);
wk := TwistedInvolutionWeakOrdering(theta, S, W);
LogWeakOrderingResult(Name(W), "(13)", wk);


# A_4
Print("A_4, id\n");
W := CoxeterGroup_An(4);
S := GeneratorsOfGroup(W);
theta := w -> w;
wk := TwistedInvolutionWeakOrdering(theta, S, W);
LogWeakOrderingResult(Name(W), "id", wk);

Print("A_4, (14)(23)\n");
theta := GeneratorPermutatingMap([4, 3, 2, 1], W);
wk := TwistedInvolutionWeakOrdering(theta, S, W);
LogWeakOrderingResult(Name(W), "(14)(23)", wk);


# A_5
Print("A_5, id\n");
W := CoxeterGroup_An(5);
S := GeneratorsOfGroup(W);
theta := w -> w;
wk := TwistedInvolutionWeakOrdering(theta, S, W);
LogWeakOrderingResult(Name(W), "id", wk);

Print("A_5, (15)(24)\n");
theta := GeneratorPermutatingMap([5, 4, 3, 2, 1], W);
wk := TwistedInvolutionWeakOrdering(theta, S, W);
LogWeakOrderingResult(Name(W), "(15)(24)", wk);


# A_6
Print("A_6, id\n");
W := CoxeterGroup_An(6);
S := GeneratorsOfGroup(W);
theta := w -> w;
wk := TwistedInvolutionWeakOrdering(theta, S, W);
LogWeakOrderingResult(Name(W), "id", wk);

Print("A_6, (16)(25)(34)\n");
theta := GeneratorPermutatingMap([6, 5, 4, 3, 2, 1], W);
wk := TwistedInvolutionWeakOrdering(theta, S, W);
LogWeakOrderingResult(Name(W), "(16)(25)(34)", wk);

