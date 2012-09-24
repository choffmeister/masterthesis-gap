Read("twistedinvolutionweakordering.gap");

tasks := [
    rec(system := CoxeterGroup_An(1), thetas := [ "id" ]),
    rec(system := CoxeterGroup_An(2), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_An(3), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_An(4), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_An(5), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_An(6), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_An(7), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_An(8), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_An(9), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_An(10), thetas := [ "id", "-id" ]),
    #rec(system := CoxeterGroup_An(11), thetas := [ "id", "-id" ]),
    #rec(system := CoxeterGroup_An(10), thetas := [ "id" ]),
    #rec(system := CoxeterGroup_An(12), thetas := [ "id", "-id" ]),
    #rec(system := CoxeterGroup_An(13), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_BCn(2), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_BCn(3), thetas := [ "id" ]),
    rec(system := CoxeterGroup_BCn(4), thetas := [ "id" ]),
    rec(system := CoxeterGroup_BCn(5), thetas := [ "id" ]),
    rec(system := CoxeterGroup_BCn(6), thetas := [ "id" ]),
    rec(system := CoxeterGroup_BCn(7), thetas := [ "id" ]),
    rec(system := CoxeterGroup_Dn(4), thetas := [ "id" ]),
    rec(system := CoxeterGroup_Dn(5), thetas := [ "id" ]),
    rec(system := CoxeterGroup_Dn(6), thetas := [ "id" ]),
    rec(system := CoxeterGroup_E6(), thetas := [ "id", [6,5,3,4,2,1] ]),
    rec(system := CoxeterGroup_E7(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_E8(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_F4(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_H3(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_H4(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_I2m(3), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_I2m(4), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_I2m(5), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_I2m(6), thetas := [ "id", "-id" ]),
    rec(system := CoxeterGroup_A1xA1(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_A2xA2(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_A3xA3(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_A1xA1xA1(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_A2xA2xA2(), thetas := [ "id" ]),
    rec(system := CoxeterGroup_A3xA3xA3(), thetas := [ "id" ]),
];

for task in tasks do
    W := task.system.group;
    matrix := task.system.matrix;
    
    for theta in task.thetas do
        theta := GroupAutomorphismByPermutation(W, theta);
        
        Print(Name(W), " ", Name(theta), "\n");
        TwistedInvolutionWeakOrdering3(StringToFilename(Concatenation(Name(W), "-", Name(theta))), W, matrix, theta);
    od;
od;
