/*grids generated always have height>=width*/
generateRandomGrid(Height-Width, Diamonds) :- random(3, 5, Height),
                                              random(3, Height, Width), 
                                              random(1, 10, DiamondNr),
                                              generateDiamondList(Height, Width, DiamondNr, [], Diamonds), !.

generateDiamondList(_, _, 0, Diamonds, Diamonds).
generateDiamondList(Height, Width, DiamondNr, Temp, Diamonds) :- Aux1 is Height - 1, Aux2 is Width - 1,
                                                                 random(0, Aux1, Y), random(0, Aux2, X),
                                                                 \+member(X-Y, Temp),
                                                                 append(Temp, [X-Y], NewTemp),
                                                                 DiamondNr1 is DiamondNr-1,
                                                                 generateDiamondList(Height, Width, DiamondNr1, NewTemp, Diamonds).

                                                                 
generateDiamondList(Height, Width, DiamondNr, Temp, Diamonds) :- generateDiamondList(Height, Width, DiamondNr, Temp, Diamonds).

generateBoard(Length, Width, Board) :-
    length(Row, Width),
    maplist(=([' ']), Row),         % A row of empty lists, forming an empty row
    length(Board, Length),
    maplist(=(Row), Board).      % A list of empty rows


/*Places piece in position X, Y*/
placeChar([H|T], Char, X, 0, [H2|T]) :- placeChar(H, Char, X, -1, H2).
placeChar([H|T], Char, X, Y, [H|R]) :- Y > -1, Y1 is Y-1, placeChar(T, Char, X, Y1, R). 

placeChar([_|T], Char, 0, -1, [Char|T]).
placeChar([H|T], Char, X, -1, [H|R]) :- X > -1, X1 is X-1, placeChar(T, Char, X1, -1, R).  

fillDiamonds(Board, [], _, Board).

fillDiamonds(Board, [X-Y|Rest], NewBoard, FinalBoard):-
    placeChar(Board, '#', X, Y, NewBoard),
    fillDiamonds(NewBoard, Rest, Ultra, FinalBoard).

makeAllSquares(Board, [], New_True_Char, Board).

makeAllSquares(Board, [[X-Y,L]|Rest], Square_Char, FinalBoard):-
    makeSquares(Board, [X-Y,L], L, Square_Char, SquareBoard),
    char_code(Square_Char, Code),
    Code1 is Code+1,
    char_code(New_Char, Code1),
    makeAllSquares(SquareBoard, Rest, New_Char, FinalBoard).

makeSquares(Board, _, 0, Square_Char, Board).

makeSquares(Board, [X-Y,L], Aux_L, Square_Char, FinalBoard):-
    makeRow(Board, [X-Y,L], L, Square_Char, RowBoard),
    Current_L is Aux_L - 1,
    Current_Y is Y + 1,
    makeSquares(RowBoard, [X-Current_Y, L], Current_L, Square_Char, FinalBoard).

makeRow(Board, _, 0, Square_Char, Board).

makeRow(Board, [X-Y,L], Counter, Square_Char, RowBoard):-
   /* nl, write('teste3'),
    nl, write('X: '), write(X), nl, write('Y: '), write(Y), nl, write('L: '), write(L), nl, */
    New_Counter is Counter - 1,
    New_X is X + 1,
    getCell(X,Y,Board, Value),
    (
            Value == '#' -> makeRow(Board, [New_X-Y,L], New_Counter, Square_Char, RowBoard)
        ;
            placeChar(Board, Square_Char, X, Y, NewBoard),
            makeRow(NewBoard, [New_X-Y,L], New_Counter, Square_Char, RowBoard)
        ).


    /* Squarelist is of type (X-Y, L)|Rest
        where X-Y is position at top left corner and L is side size*/

        

getCell(X, Y, GameState, Value) :- X > -1, Y > -1, X < 10, Y < 10, getRow(Y, GameState, Row), getCellInRow(X, Row, Value).

getRow(0, [H|_], H).
getRow(Y, [_|T], Row) :- Y1 is Y-1, getRow(Y1, T, Row).
    
getCellInRow(0, [H|_], H).
getCellInRow(X, [_|T], Value) :- X1 is X-1, getCellInRow(X1, T, Value).



/*known example with solution*/
example(7-7, [0-0, 3-0, 6-0, 3-2, 4-4, 6-5, 0-6, 4-6, 6-6]).

exampleSmall(9-3, [0-0, 0-3, 0-6]).


/*return max of two as a single element, and not a list*/
min2([First, Second], First) :- First =< Second.

min2([First, Second], Second) :- First > Second.


/*maplist with one more argument*/
maplist5(Pred, Xs, Ys, Zs, Wz) :-
          	(   foreach(X,Xs),
          	    foreach(Y,Ys),
          	    foreach(Z,Zs),
                foreach(W,Ws),
          	    param(Pred)
          	do  call(Pred, X, Y, Z, W)
          	).