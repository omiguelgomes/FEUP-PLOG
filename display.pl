display_game(GameState, Player) :- printBoard(GameState).

%INITIAL BOARD
initial([[#, #, #, #,  #,   #,  #, #, #, #],
         [#, o, o, o,  o,   o,  o, o, o, #],
         [#, o, o, o,  o,   o,  o, o, o, #],
         [#, o, o, o,  o,   o,  o, o, o, #],
         [#, o, o, o, 'W', 'B', o, o, o, #],
         [#, o, o, o, 'B', 'W', o, o, o, #],
         [#, o, o, o,  o,   o,  o, o, o, #],
         [#, o, o, o,  o,   o,  o, o, o, #],
         [#, o, o, o,  o,   o,  o, o, o, #],
         [#, #, #, #,  #,   #,  #, #, #, #]]).

%prints board, row by row

printBoard([H|T]) :- write(' -----------------------------------------'),
                     nl,
                     printRow(H),
                     nl,
                     printBoard(T).

printBoard([]) :-    write(' -----------------------------------------'), nl.

%prints row, cell by cell

printRow(['o'|T]) :- write(' | '), write(' '), printRow(T). %special case, doesnt print anything in an empty cell
printRow([H|T]) :- write(' | '), write(H), printRow(T). 
printRow([]) :- write(' |').

