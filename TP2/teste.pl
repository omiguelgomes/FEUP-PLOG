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


segundoteste:-
    write('Custom Height: '), read(Height),
    write('Custom Widtht: '), read(Width),
    random(1, 10, DiamondNr),
    generateDiamondList(Height, Width, DiamondNr, [], Diamonds),
    generateBoard(Height, Width, Board),
    fillDiamonds(Board, Diamonds, Aux, NewBoard),
    displayGame(Height, Width, Diamonds, NewBoard).

terceiroteste:-
    write('Custom Height: '), read(Height),
                   write('Custom Widtht: '), read(Width),
                   write('Custom no. of diamonds: '), read(DiamondNr),
                   generateDiamondList(Height, Width, DiamondNr, [], Diamonds),
                   generateBoard(Height, Width, Board),
                   fillDiamonds(Board, Diamonds, Aux, NewBoard),
                   displayGame(Height, Width, Diamonds, NewBoard).