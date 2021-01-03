

/*prints vertical bar with coordinate indicators. starts by writing a '|', then writes all the numbers separated by*/
printCoordsBar(X, X) :- write('|\n').
printCoordsBar(_, 0) :- write('|'), fail.
printCoordsBar(Width, Nr) :- format(' ~d ', [Nr]), NewNr is Nr+1, printCoordsBar(Width, NewNr).

/*prints vertical line, of size Length*/
printVerticalLine(0) :- nl.
printVerticalLine(Length) :- write('---'), NewLength is Length-1, printVerticalLine(NewLength).

            /*PRINT BOARD*/
displayGame([H|T], RowNr) :- 
    NextRowNr is RowNr + 1,
    printRow(H),
    nl,
    displayGame(T, NextRowNr),!.
            
displayGame([], _).
            
/*prints row, cell by cell*/
            
printRow([H|T]) :- format('| ~s ', [H]), printRow(T). 
printRow([]) :- write('|').