getCell(X, Y, GameState, Value) :- getRow(Y, GameState, Row), getCellInRow(X, Row, Value).

getRow(0, [H|T], H).
getRow(Y, [H|T], Row) :- Y1 is Y-1, getRow(Y1, T, Row).

getCellInRow(0, [H|T], H).
getCellInRow(X, [H|T], Value) :- X1 is X-1, getCellInRow(X1, T, Value).