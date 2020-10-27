display_game(GameState, Player) :- printBoard(GameState).

%INITIAL BOARD
initial([[#,   #,   #,   #,   #,   #,   #,   #,   #, #], 
         [#, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', #], 
         [#, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', #], 
         [#, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', #], 
         [#, ' ', ' ', ' ', 'W', 'B', ' ', ' ', ' ', #], 
         [#, ' ', ' ', ' ', 'B', 'W', ' ', ' ', ' ', #], 
         [#, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', #], 
         [#, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', #], 
         [#, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', #], 
         [#,   #,   #,   #,   #,   #,   #,   #,   #, #]]).

%prints board, row by row

printBoard([H|T]) :- write(' -----------------------------------------'),
                     nl,
                     printRow(H),
                     nl,
                     printBoard(T).

printBoard([]) :-    write(' -----------------------------------------'), nl.

%prints row, cell by cell

printRow([H|T]) :- write(' | '), write(H), printRow(T). 
printRow([]) :- write(' |').

