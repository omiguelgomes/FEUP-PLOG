getCell(X, Y, GameState, Value) :- X > -1, Y > -1, X < 10, Y < 10, getRow(Y, GameState, Row), getCellInRow(X, Row, Value).

getRow(0, [H|T], H).
getRow(Y, [H|T], Row) :- Y1 is Y-1, getRow(Y1, T, Row).

getCellInRow(0, [H|T], H).
getCellInRow(X, [H|T], Value) :- X1 is X-1, getCellInRow(X1, T, Value).

getOpponent('B', 'W').
getOpponent('W', 'B').

/*Converts x position from letter to number*/
convertX('A', 0).
convertX('B', 1).
convertX('C', 2).
convertX('D', 3).
convertX('E', 4).
convertX('F', 5).
convertX('G', 6).
convertX('H', 7).
convertX('I', 8).
convertX('J', 9).

convertX('a', 0).
convertX('b', 1).
convertX('c', 2).
convertX('d', 3).
convertX('e', 4).
convertX('f', 5).
convertX('g', 6).
convertX('h', 7).
convertX('i', 8).
convertX('j', 9).

