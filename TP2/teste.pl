omega:-
    generateBoard(9,9,Board),
   /* write('Height: '), write(Height), nl,
    write('Width: '), write(Width), nl,  
    write(Diamonds),nl,
    fillDiamonds(Board, Diamonds, NewBoard, Final), */
    placeChar(Board, '#', 1, 1, NewBoard),
    printBoard(NewBoard, 0),
    nl, nl, write('testing starts here'), nl, nl,
    makeAllSquares(NewBoard, [[0-0,2],[3-3,2], [5-5,4]], 'a', FinalBoard),
    printBoard(FinalBoard, 0).

