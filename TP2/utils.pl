generateRandomGrid(Height-Width, Diamonds) :- random(1, 10, Height), 
                                              random(1, 10, Width), 
                                              random(1, 10, DiamondNr),
                                              generateDiamondList(Height, Width, DiamondNr, [], Diamonds), !.

generateDiamondList(_, _, 0, Diamonds, Diamonds).
generateDiamondList(Height, Width, DiamondNr, Temp, Diamonds) :- random(0, Height, X), random(0, Width, Y),
                                                                 \+member(X-Y, Temp),
                                                                 append(Temp, [X-Y], NewTemp),
                                                                 DiamondNr1 is DiamondNr-1,
                                                                 generateDiamondList(Height, Width, DiamondNr1, NewTemp, Diamonds).

                                                                 
generateDiamondList(Height, Width, DiamondNr, Temp, Diamonds) :- generateDiamondList(Height, Width, DiamondNr, Temp, Diamonds).