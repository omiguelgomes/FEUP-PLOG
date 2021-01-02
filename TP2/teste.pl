omega:-
    generateBoard(9,9,Board),
   /* write('Height: '), write(Height), nl,
    write('Width: '), write(Width), nl,  
    write(Diamonds),nl,
    fillDiamonds(Board, Diamonds, NewBoard, Final), */
    printBoard(Board, 0),
    nl, nl, write('testing starts here'), nl, nl,
    makeAllSquares(Board, [(0-0,2),(3-3,2), (5-5,4)], '1', FinalBoard),
    printBoard(FinalBoard, 0).

