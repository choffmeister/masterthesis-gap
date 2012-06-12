Read("twistedinvolutionweakordering.gap");

CalculateTwistedWeakOrderings := function()
    local tasks, task, theta, W, matrix;

    tasks := [
        rec(system := CoxeterGroup_An(1), thetas := [ "id" ]),
        rec(system := CoxeterGroup_An(2), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_An(3), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_An(4), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_An(5), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_An(6), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_An(7), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_An(8), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_BCn(2), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_BCn(3), thetas := [ "id" ]),
        rec(system := CoxeterGroup_BCn(4), thetas := [ "id" ]),
        rec(system := CoxeterGroup_BCn(5), thetas := [ "id" ]),
        rec(system := CoxeterGroup_Dn(4), thetas := [ "id" ]),
        rec(system := CoxeterGroup_Dn(5), thetas := [ "id" ]),
        rec(system := CoxeterGroup_Dn(6), thetas := [ "id" ]),
        rec(system := CoxeterGroup_E6(), thetas := [ "id", [6,5,3,4,2,1] ]),
        #rec(system := CoxeterGroup_E7(), thetas := [ "id" ]),
        #rec(system := CoxeterGroup_E8(), thetas := [ "id" ]),
        rec(system := CoxeterGroup_H3(), thetas := [ "id" ]),
        rec(system := CoxeterGroup_H4(), thetas := [ "id" ]),
        rec(system := CoxeterGroup_I2m(3), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_I2m(4), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_I2m(5), thetas := [ "id", "-id" ]),
        rec(system := CoxeterGroup_I2m(6), thetas := [ "id", "-id" ]),
    ];

    for task in tasks do
        W := task.system.group;
        matrix := task.system.matrix;
        
        for theta in List(task.thetas, t -> GroupAutomorphismByPermutation(W, t)) do
            Print(Name(W), " ", Name(theta), "\n");
            TwistedInvolutionWeakOrdering(StringToFilename(Concatenation(Name(W), "-", Name(theta))), W, matrix, theta);
        od;
    od;
end;

