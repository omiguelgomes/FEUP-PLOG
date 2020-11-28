getCell(X, Y, GameState, Value) :- X > -1, Y > -1, X < 10, Y < 10, getRow(Y, GameState, Row), getCellInRow(X, Row, Value).

getRow(0, [H|_], H).
getRow(Y, [_|T], Row) :- Y1 is Y-1, getRow(Y1, T, Row).

getCellInRow(0, [H|_], H).
getCellInRow(X, [_|T], Value) :- X1 is X-1, getCellInRow(X1, T, Value).

getOpponent('B', 'W').
getOpponent('W', 'B').

/*Converts x position from letter to number*/
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


/*Used to iterate through board, left to right, top to bottom*/

/*If we reached the last cell, return 0,0*/
nextCell(8, 8, 0, 0).
/*If we reached the last cell in the row, move to next row*/
nextCell(8, Y, 1, NextY) :-  NextY is Y + 1.
nextCell(X, Y, NextX, Y) :-  NextX is X + 1.