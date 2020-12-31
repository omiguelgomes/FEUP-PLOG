/*grids generated always have height>=width*/
generateRandomGrid(Height-Width, Diamonds) :- random(5, 10, Height),
                                              random(5, Height, Width), 
                                              random(1, 10, DiamondNr),
                                              generateDiamondList(Height, Width, DiamondNr, [], Diamonds), !.

generateDiamondList(_, _, 0, Diamonds, Diamonds).
generateDiamondList(Height, Width, DiamondNr, Temp, Diamonds) :- Aux1 is Height - 1, Aux2 is Width - 1,
                                                                 random(0, Aux1, Y), random(0, Aux2, X),
                                                                 \+member(X-Y, Temp),
                                                                 append(Temp, [X-Y], NewTemp),
                                                                 DiamondNr1 is DiamondNr-1,
                                                                 generateDiamondList(Height, Width, DiamondNr1, NewTemp, Diamonds).

                                                                 
generateDiamondList(Height, Width, DiamondNr, Temp, Diamonds) :- generateDiamondList(Height, Width, DiamondNr, Temp, Diamonds).

generateBoard(Length, Width, Board) :-
    length(Row, Width),
    maplist(=([]), Row),         % A row of empty lists, forming an empty row
    length(Board, Length),
    maplist(=(Row), Board).      % A list of empty rows

/*Places piece in position X, Y*/
placeDiamond([H|T], '#', X, 0, [H2|T]) :- placeDiamond(H, '#', X, -1, H2).
placeDiamond([H|T], '#', X, Y, [H|R]) :- Y > -1, Y1 is Y-1, placeDiamond(T, '#', X, Y1, R). 

placeDiamond([_|T], '#', 0, -1, ['#'|T]).
placeDiamond([H|T], '#', X, -1, [H|R]) :- X > -1, X1 is X-1, placeDiamond(T, '#', X1, -1, R).  

fillDiamonds(Board, [], _, Board).

fillDiamonds(Board, [X-Y|Rest], NewBoard, FinalBoard):-
    placeDiamond(Board, '#', X, Y, NewBoard),
    fillDiamonds(NewBoard, Rest, Ultra, FinalBoard).


/*known example with solution*/
example(7-7, [0-0, 0-3, 0-6, 2-3, 4-4, 5-6, 6-0, 6-4, 6-6]).