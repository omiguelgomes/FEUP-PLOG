/*grids generated always have height>=width*/
generateRandomGrid(Height-Width, Diamonds) :- random(3, 15, Height),
                                              random(2, Height, Width), 
                                              max2([Height, Width], MaxDiamondNr),
                                              random(1, MaxDiamondNr, DiamondNr),
                                              generateDiamondList(Height, Width, DiamondNr, [], Diamonds), !.

generateDiamondList(_, _, 0, Diamonds, NewDiamonds) :- remove_dups(Diamonds, NewDiamonds).

generateDiamondList(Height, Width, DiamondNr, Temp, Diamonds) :- random(0, Height, Y), random(0, Width, X),
                                                                 append(Temp, [X-Y], NewTemp),
                                                                 DiamondNr1 is DiamondNr-1,
                                                                 generateDiamondList(Height, Width, DiamondNr1, NewTemp, Diamonds).

                                                                 

customDiamondList(_, _, 0, Diamonds, Diamonds).
customDiamondList(Height, Width, DiamondNr, Temp, Diamonds):-
    nl, write(DiamondNr),write(' diamond/s remaining'), nl,
    write('X: '), read(X), X<Width,
    write('Y: '), read(Y), Y<Height,
    \+member(X-Y, Temp),
    append(Temp, [X-Y], NewTemp),
    DiamondNr1 is DiamondNr - 1,
    customDiamondList(Height, Width, DiamondNr1, NewTemp, Diamonds).

customDiamondList(Height, Width, DiamondNr, Temp, Diamonds):-
    nl,write('New Diamond is either out of bounds or already exists in that position, try again.'),nl,
    customDiamondList(Height, Width, DiamondNr, Temp, Diamonds).
    

generateBoard(Length, Width, Diamonds, NewBoard) :-
    length(Row, Width),
    maplist(=([' ']), Row),         % A row of empty lists, forming an empty row
    length(Board, Length),
    maplist(=(Row), Board),      % A list of empty rows
    fillDiamonds(Board, Diamonds, _, NewBoard).


/*Places piece in position X, Y*/
placeChar([H|T], Char, X, 0, [H2|T]) :- placeChar(H, Char, X, -1, H2).
placeChar([H|T], Char, X, Y, [H|R]) :- Y > -1, Y1 is Y-1, placeChar(T, Char, X, Y1, R). 

placeChar([_|T], Char, 0, -1, [Char|T]).
placeChar([H|T], Char, X, -1, [H|R]) :- X > -1, X1 is X-1, placeChar(T, Char, X1, -1, R).  

fillDiamonds(Board, [], _, Board).

fillDiamonds(Board, [X-Y|Rest], NewBoard, FinalBoard):-
    placeChar(Board, '#', X, Y, NewBoard),
    fillDiamonds(NewBoard, Rest, _, FinalBoard).

makeAllSquares(Board, [], _, Board).
makeAllSquares(Board, [[X-Y,L]|Rest], 'z', FinalBoard) :- makeAllSquares(Board, [[X-Y,L]|Rest], 'a', FinalBoard).
makeAllSquares(Board, [[X-Y,L]|Rest], Square_Char, FinalBoard):-
    makeSquares(Board, [X-Y,L], L, Square_Char, SquareBoard),
    char_code(Square_Char, Code),
    Code1 is Code+1,
    char_code(New_Char, Code1),
    makeAllSquares(SquareBoard, Rest, New_Char, FinalBoard).

makeSquares(Board, _, 0, _, Board).

makeSquares(Board, [X-Y,L], Aux_L, Square_Char, FinalBoard):-
    makeRow(Board, [X-Y,L], L, Square_Char, RowBoard),
    Current_L is Aux_L - 1,
    Current_Y is Y + 1,
    makeSquares(RowBoard, [X-Current_Y, L], Current_L, Square_Char, FinalBoard).

makeRow(Board, _, 0, _, Board).

makeRow(Board, [X-Y,L], Counter, Square_Char, RowBoard):-
   /* nl, write('teste3'),
    nl, write('X: '), write(X), nl, write('Y: '), write(Y), nl, write('L: '), write(L), nl, 
    nl,write('teste6'),
    nl,write('Counter: '), write(Counter), */
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

        

getCell(X, Y, GameState, Value) :- X > -1, Y > -1, X < 100, Y < 100, getRow(Y, GameState, Row), getCellInRow(X, Row, Value).

getRow(0, [H|_], H).
getRow(Y, [_|T], Row) :- Y1 is Y-1, getRow(Y1, T, Row).
    
getCellInRow(0, [H|_], H).
getCellInRow(X, [_|T], Value) :- X1 is X-1, getCellInRow(X1, T, Value).



/*known example with solution*/
example1(7-7, [0-0, 3-0, 6-0, 3-2, 4-4, 6-5, 0-6, 4-6, 6-6]).
example2(18-15, [0-0, 9-0, 14-0, 7-2, 10-2, 5-4, 9-4, 3-6, 8-6, 7-8, 6-10, 0-17, 14-17]).

example3(33-33, [0-0, 11-0, 22-0, 0-11, 11-11, 22-11, 0-22, 11-22, 22-22]).

example4(32-32, [0-0, 4-0, 8-0, 12-0, 16-0, 20-0, 24-0, 28-0, 
                 0-4, 4-4, 8-4, 12-4, 16-4, 20-4, 24-4, 28-4, 
                 0-8, 4-8, 8-8, 12-8, 16-8, 20-8, 24-8, 28-8, 
                 0-12, 4-12, 8-12, 12-12, 16-12, 20-12, 24-12, 28-12, 
                 0-16, 4-16, 8-16, 12-16, 16-16, 20-16, 24-16, 28-16,
                 0-20, 4-20, 8-20, 12-20, 16-20, 20-20, 24-20, 28-20,
                 0-24, 4-24, 8-24, 12-24, 16-24, 20-24, 24-24, 28-24,
                 0-28, 4-28, 8-28, 12-28, 16-28, 20-28, 24-28, 28-28]).

example5(20-20, [0-0, 19-0, 6-0, 9-0, 11-0, 8-2, 8-3, 11-4, 9-7, 0-12, 11-12, 19-12, 0-19, 11-19, 19-19]).
example6(29-29, [0-0, 28-0, 14-1, 22-3, 17-6, 12-9, 20-11, 7-12, 22-16, 19-17, 16-18, 18-20, 20-22, 18-24, 22-24, 16-26, 24-26, 0-28, 14-28]).
example7(31-31, [0-0, 11-0, 19-0, 30-0, 9-7, 30-11, 0-15, 18-17, 23-18, 30-19, 14-20, 17-20, 18-20, 20-20, 12-22, 17-22, 0-30, 11-30, 19-30, 30-30]).

exampleSmall(6-6, [0-0, 0-3, 3-0, 3-3]).

exampleJulio(15-15, [0-9, 2-2, 7-2, 12-2, 5-9, 10-9, 13-9, 14-9, 10-8, 11-8, 13-8, 11-6, 13-6, 2-12, 7-12, 12-12]).


/*return min of two as a single element, and not a list*/
min2([First, Second], First) :- First =< Second.

min2([First, Second], Second).

/*return max of two as a single element, and not a list*/
max2([First, Second], First) :- First >= Second.

max2([First, Second], Second).


/*maplist with one more argument*/
maplist5(Pred, Xs, Ys, Zs, Ws) :-
          	(   foreach(X,Xs),
          	    foreach(Y,Ys),
          	    foreach(Z,Zs),
                foreach(W,Ws),
          	    param(Pred)
          	do  call(Pred, X, Y, Z, W)
          	).