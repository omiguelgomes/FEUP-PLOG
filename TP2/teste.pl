omega:-
    generateRandomGrid(Height-Width, Diamonds),
    generateBoard(Height,Width,Board),
    write('Height: '), write(Height), nl,
    write('Width: '), write(Width), nl,  
    write(Diamonds),nl,
    fillDiamonds(Board, Diamonds, NewBoard, Final),
    printBoard(Final, 0).
