displayGame(Height, Width, Diamonds) :- format('I got a ~d x ~d\n', [Height, Width]), printBoard(Height, Width, Diamonds), !.


/*prints vertical bar with coordinate indicators. starts by writing a '|', then writes all the numbers separated by*/
printCoordsBar(X, X) :- write('|\n').
printCoordsBar(_, 0) :- write('|'), fail.
printCoordsBar(Width, Nr) :- format(' ~d ', [Nr]), NewNr is Nr+1, printCoordsBar(Width, NewNr).

/*prints vertical line, of size Length*/
printVerticalLine(0) :- nl.
printVerticalLine(Length) :- write('---'), NewLength is Length-1, printVerticalLine(NewLength).

            /*PRINT BOARD*/

/*wrapper for printBoard*/
printBoard(Height, Width, Diamonds) :- printBoard(Height, 1, Width, 1, Diamonds).

/*at the end of the board, stop*/
printBoard(Height, Height, Width, Width, Diamonds) :- writeCell(Height, Height, Width, Width, Diamonds).

/*at the end of the line, draw next line*/
printBoard(Height, _, Width, Width, Diamonds) :- Height1 is Height-1, writeCell(Height, _, Width, Width, Diamonds), nl, printBoard(Height1, 1, Width, 1, _).

/*at the start of each row, print a column bar*/
printBoard(Height, Y, Width, 1, Diamonds) :- writeCell(Height, Y, Width, 1, Diamonds), printBoard(Height, Y, Width, 2, Diamonds).

/*write normal cell*/
printBoard(Height, Y, Width, X, Diamonds) :- writeCell(Height, Y, Width, X, Diamonds), X1 is X+1, printBoard(Height, Y, Width, X1, Diamonds).

writeCell(Height, Y, Width, X, Diamonds) :- write(' a ').