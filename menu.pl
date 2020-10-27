%initial function, shows menu, and asks for user input for the game mode

play :- printMainMenu, 
       write('What mode would you like to play?'),
       read(Input),
       manageInput(Input).

%parse input for game mode

manageInput(1) :-  initial(GameState), display_game(GameState, 'P1').
manageInput(2) :-  write('Mode not implemented yet!').
manageInput(3) :-  write('Mode not implemented yet!').
manageInput(Else) :- write('Invalid mode!').
%manageInput(0) :- exit program, there should be a built-in function


printMainMenu :- 
    nl,nl,
    write(' _______________________________________________________________________ '),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|      |||    |||  |||||  ||||||  ||||||| ||      ||       ||||||       |'),nl,
    write('|      ||||  |||| ||   || ||   || ||      ||      ||      ||    ||      |'),nl,
    write('|      || |||| || ||||||| ||||||  |||||   ||      ||      ||    ||      |'),nl,
    write('|      ||  ||  || ||   || ||      ||      ||      ||      ||    ||      |'),nl,
    write('|      ||      || ||   || ||      ||||||| ||||||| |||||||  ||||||       |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                             Miguel Gomes                              |'),nl,
    write('|                            Pedro Teixeira                             |'),nl,
    write('|               -----------------------------------------               |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                          1. Player vs Player                          |'),nl,
    write('|                                                                       |'),nl,
    write('|                          2. Player vs Computer                        |'),nl,
    write('|                                                                       |'),nl,
	write('|                          3. Computer vs Computer                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                          0. Exit                                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|_______________________________________________________________________|'),nl,
    nl,nl.

p :- initial(GameState), display_game(GameState, 'P1').