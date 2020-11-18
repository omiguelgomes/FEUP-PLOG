getCell(X, Y, GameState, Value) :- X > -1, Y > -1, X < 10, Y < 10, getRow(Y, GameState, Row), getCellInRow(X, Row, Value).

getRow(0, [H|T], H).
getRow(Y, [H|T], Row) :- Y1 is Y-1, getRow(Y1, T, Row).

getCellInRow(0, [H|T], H).
getCellInRow(X, [H|T], Value) :- X1 is X-1, getCellInRow(X1, T, Value).

changePlayer('B', 'W').
changePlayer('W', 'B').

/*Finds the diagonal '/' that goes through X, Y, places it in L*/
getMainDiagonal(GameState, X, Y, L) :- 1==1.