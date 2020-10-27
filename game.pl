getCell(X, Y, GameState, Value) :- getRow(Y, GameState, Row), getCell(X, Row, Value), write(Value).

getRow(0, [H|T], H).
getRow(Y, [H|T], Row) :- Y1 is Y-1, getRow(Y1, T, Row).

getCell(0, [H|T], H).
getCell(X, [H|T], Value) :- X1 is X-1, getCell(X1, T, Value).
