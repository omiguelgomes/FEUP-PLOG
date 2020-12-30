/*grids generated always have height>=width*/
generateRandomGrid(Height-Width, Diamonds) :- random(5, 10, Height), 
                                              random(5, Height, Width), 
                                              random(1, 10, DiamondNr),
                                              generateDiamondList(Height, Width, DiamondNr, [], Diamonds), !.

generateDiamondList(_, _, 0, Diamonds, Diamonds).
generateDiamondList(Height, Width, DiamondNr, Temp, Diamonds) :- random(0, Height, X), random(0, Width, Y),
                                                                 \+member(X-Y, Temp),
                                                                 append(Temp, [X-Y], NewTemp),
                                                                 DiamondNr1 is DiamondNr-1,
                                                                 generateDiamondList(Height, Width, DiamondNr1, NewTemp, Diamonds).

                                                                 
generateDiamondList(Height, Width, DiamondNr, Temp, Diamonds) :- generateDiamondList(Height, Width, DiamondNr, Temp, Diamonds).


/*known example with solution*/
example(7-7, [0-0, 0-3, 0-6, 2-3, 4-4, 5-6, 6-0, 6-4, 6-6]).