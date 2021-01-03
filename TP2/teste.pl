omega:-
    generateBoard(15,15,Board),
   /* write('Height: '), write(Height), nl,
    write('Width: '), write(Width), nl,  
    write(Diamonds),nl,
    fillDiamonds(Board, Diamonds, NewBoard, Final), */
    placeChar(Board, '#', 1, 1, NewBoard),
    printBoard(NewBoard, 0),
    nl, nl, write('testing starts here'), nl, nl,
    makeAllSquares(NewBoard, [[0-0,2],[3-3,2],[9-9,2]], 'a', FinalBoard),
    printBoard(FinalBoard, 0).


omegadois:-
    generateBoard(19,17,Board),
   /* write('Height: '), write(Height), nl,
    write('Width: '), write(Width), nl,  
    write(Diamonds),nl,
    fillDiamonds(Board, Diamonds, NewBoard, Final), */
    placeChar(Board, '#', 1, 1, NewBoard),
    printBoard(NewBoard, 0),
    nl, nl, write('testing starts here'), nl, nl,
    makeAllSquares(NewBoard, [[0-0,3],[0-3,3],[0-6,3],[0-9,3],[0-12,3],[0-15,3]], 'a', FinalBoard),
    printBoard(FinalBoard, 0).

omegatres:-
    write('Custom Height: '), read(Height), Height < 50,
    write('Custom Widtht: '), read(Width), Width < 50,
    write('Custom no. of diamonds: '), read(DiamondNr),
    customDiamondList(Height, Width, DiamondNr, [], Diamonds),
    generateBoard(Height, Width, Board),
    fillDiamonds(Board, Diamonds, _, NewBoard),
    displayGame(Height, Width, Diamonds, NewBoard).