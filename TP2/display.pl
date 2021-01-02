displayGame(Height, Width, Diamonds, Board) :- printBoard(Board, 0), nl,!.


/*prints vertical bar with coordinate indicators. starts by writing a '|', then writes all the numbers separated by*/
printCoordsBar(X, X) :- write('|\n').
printCoordsBar(_, 0) :- write('|'), fail.
printCoordsBar(Width, Nr) :- format(' ~d ', [Nr]), NewNr is Nr+1, printCoordsBar(Width, NewNr).

/*prints vertical line, of size Length*/
printVerticalLine(0) :- nl.
printVerticalLine(Length) :- write('---'), NewLength is Length-1, printVerticalLine(NewLength).

            /*PRINT BOARD*/
printBoard([H|T], RowNr) :- 
    format('  ~d ', [RowNr]),
    NextRowNr is RowNr + 1,
    printRow(H),
    nl,
    printBoard(T, NextRowNr).
            
printBoard([], _).
            
/*prints row, cell by cell*/
            
printRow([H|T]) :- format('| ~s ', [H]), printRow(T). 
printRow([]) :- write('|').


/*helper func to write cell, will check if x-y is in diamonds, and if a square must be drawn*/
writeCell(Height, Y, Width, X, Diamonds) :- write(' a ').

/*
writeCell(Height, Y, Width, X, 0).

writeCell(Height, Y, Width, X, []):-
    write(' a ').

writeCell(Height, Y, Width, X, [Dab_X-Dab_Y|Rest]) :- 
    X==Dab_X,
    Y==Dab_Y,
    write(' # '),
    writeCell(Height, Y, Width, X, 0).

writeCell(Height, Y, Width, X, [_|Rest]):-
    writeCell(Height, Y, Width, X, Rest).

*/