display_game(GameState, Player) :- printBoard(GameState).

initial([[w, w, w, w, w, w, w, w, w, w],
         [w, o, o, o, o, o, o, o, o, w],
         [w, o, o, o, o, o, o, o, o, w],
         [w, o, o, o, o, o, o, o, o, w],
         [w, o, o, o, o, o, o, o, o, w],
         [w, o, o, o, o, o, o, o, o, w],
         [w, o, o, o, o, o, o, o, o, w],
         [w, o, o, o, o, o, o, o, o, w],
         [w, o, o, o, o, o, o, o, o, w],
         [w, w, w, w, w, w, w, w, w, w]]).

printBoard([H|T]) :- write(' __________________________________________'),nl,
                     printRow(H),
                     printBoard(T).
printBoard([]) :-    write(' _________________________________________ '),nl.

printRow([H|T]) :- write(' | '), write(H), printRow(T). 
printRow([]) :- write(' |'), nl.

%reconsult('game.pl').