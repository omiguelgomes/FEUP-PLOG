display_game(GameState, Player) :- printScore(GameState), printCoordsBar, printBoard(GameState, 0).

printCoordsBar :- nl, write('      A   B   C   D   E   F   G   H   I   J  \n'),
                      write('    -----------------------------------------\n').

/*prints board, row by row*/

printBoard([H|T], RowNr) :- format('  ~d ', [RowNr]),
                            NextRowNr is RowNr + 1,
                            printRow(H),
                            nl,
                            write('    -----------------------------------------\n'),
                            printBoard(T, NextRowNr).

printBoard([], _).

/*prints row, cell by cell*/

printRow([H|T]) :- format('| ~s ', [H]), printRow(T). 
printRow([]) :- write('|').

/*prints current score*/
printScore(GameState) :- getScore(GameState, SP1, SP2),
                         write('\nSCORE: '), 
                         format('  White: ~d', [SP2]),
                         format('  Black: ~d\n', [SP1]).


/*INITIAL BOARD*/

initial([['#', '#', '#', 'J', '#', '#', 'J', '#', '#', '#'], 
         ['#', '#', ' ', 'P', ' ', 'P', ' ', ' ', '#', '#'], 
         ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', 'P', 'J'], 
         ['#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'], 
         ['#', 'P', '#', ' ', ' ', 'B', ' ', ' ', ' ', '#'], 
         ['J', ' ', ' ', ' ', ' ', 'W', ' ', ' ', ' ', '#'], 
         ['#', 'P', ' ', ' ', ' ', ' ', ' ', '#', 'P', 'J'], 
         ['#', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'], 
         ['#', '#', ' ', 'P', ' ', ' ', ' ', 'P', '#', '#'], 
         ['#', '#', '#', 'J', 'J', '#', '#', 'J', '#', '#']]).


/*MID BOARD*/
mid([['#', '#', '#', 'J', '#', '#', 'J', '#', '#', '#'], 
     ['#', '#', ' ', 'P', ' ', 'P', ' ', ' ', '#', '#'], 
     ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', 'J'], 
     ['#', ' ', ' ', ' ', ' ', 'W', 'B', ' ', 'P', '#'], 
     ['#', 'P', '#', ' ', 'W', 'B', 'B', ' ', 'B', '#'], 
     ['J', ' ', ' ', ' ', 'B', 'B', 'B', 'B', 'P', '#'], 
     ['#', 'P', ' ', ' ', ' ', ' ', 'B', '#', ' ', 'J'], 
     ['#', ' ', ' ', '#', ' ', ' ', 'B', ' ', ' ', '#'], 
     ['#', '#', ' ', 'P', ' ', ' ', ' ', 'P', '#', '#'], 
     ['#', '#', '#', 'J', 'J', '#', '#', 'J', '#', '#']]).

/*END BOARD*/
end([['#',  '#', '#', 'J', '#', '#', 'J', '#', '#', '#'], 
     ['#',  '#', 'W', 'P', 'W', 'P', 'B', 'W', '#', '#'], 
     ['#',  'W', 'W', 'W', 'W', 'W', '#', 'W', 'B', 'J'], 
     ['#',  'W', 'W', 'W', ' ', 'W', 'B', 'B', 'P', '#'], 
     ['#',  'P', '#', 'W', 'W', 'B', 'B', 'B', 'B', '#'], 
     ['J',  'W', 'W', 'B', 'B', 'B', 'B', 'B', 'P', '#'], 
     ['#',  'P', 'W', 'B', 'W', 'B', 'B', '#', 'B', 'J'], 
     ['#',  'W', 'W', '#', 'B', 'B', 'B', 'B', 'W', '#'], 
     ['#',  '#', 'W', 'P', 'B', 'W', 'B', 'P', '#', '#'], 
     ['#',  '#', '#', 'J', 'J', '#', '#', 'J', '#', '#']]).         

/*TEST BOARD*/
omega([['#', '#', '#', 'J', '#', '#', 'J', '#', '#', '#'], 
         ['#', '#', ' ', 'P', ' ', 'P', ' ', ' ', '#', '#'], 
         ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', 'P', 'J'], 
         ['#', ' ', 'W', 'B', ' ', ' ', ' ', 'B', ' ', '#'], 
         ['#', 'P', '#', ' ', 'W', 'W', 'W', 'W', 'B', '#'], 
         ['J', ' ', ' ', 'B', 'B', 'W', ' ', ' ', ' ', '#'], 
         ['#', 'P', ' ', 'W', ' ', ' ', ' ', '#', 'P', 'J'], 
         ['#', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'], 
         ['#', '#', ' ', 'P', ' ', ' ', ' ', 'P', '#', '#'], 
         ['#', '#', '#', 'J', 'J', '#', '#', 'J', '#', '#']]).    


teste([['#', '#', '#', 'J', '#', '#', 'J', '#', '#', '#'], 
       ['#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'], 
       ['#', 'W', 'W', ' ', 'W', ' ', 'W', ' ', 'W', 'J'], 
       ['#', 'B', 'W', ' ', 'W', ' ', 'W', ' ', 'W', '#'], 
       ['#', ' ', 'B', ' ', 'W', ' ', 'W', ' ', 'W', '#'], 
       ['J', ' ', ' ', ' ', 'W', ' ', 'W', ' ', 'W', '#'], 
       ['#', ' ', ' ', ' ', 'B', ' ', 'W', ' ', 'W', 'J'], 
       ['#', ' ', ' ', ' ', ' ', ' ', 'B', ' ', 'W', '#'], 
       ['#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'B', '#'], 
       ['#', '#', '#', 'J', 'J', '#', '#', 'J', '#', '#']]).