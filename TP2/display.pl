displayGame(Height, Width, Diamonds) :- printCoordsBar(Width, 0), printVerticalLine(Width), printBoard(Height, Width), !.


/*prints vertical bar with coordinate indicators. starts by writing a '|', then writes all the numbers separated by*/
printCoordsBar(X, X) :- nl.
printCoordsBar(_, 0) :- write('|  '), fail.
printCoordsBar(Width, Nr) :- format('~d   ', [Nr]), NewNr is Nr+1, printCoordsBar(Width, NewNr).

/*prints vertical line, of size Length*/
printVerticalLine(0).
printVerticalLine(Length) :- write('----'), NewLength is Length-1, printVerticalLine(NewLength).