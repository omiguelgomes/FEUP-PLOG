/*initial function, shows menu, and asks for user input for the game mode*/

play :- printMainMenu, 
       write('What mode would you like to play?'),
       read(Input),
       manageInput(Input).

/*parse input for game mode*/

manageInput(1) :-  startGame.
manageInput(2) :-  startGamePvsC.
manageInput(3) :-  StartGameCvsC.
manageInput(Else) :- write('Invalid mode!').
/*manageInput(0) :- exit program, there should be a built-in function*/


printMainMenu :- 
    nl,nl,
    write(' _______________________________________________________________________ \n'),
    write('|                                                                       |\n'),
    write('|                                                                       |\n'),
    write('|      |||    |||  |||||  ||||||  ||||||| ||      ||       ||||||       |\n'),
    write('|      ||||  |||| ||   || ||   || ||      ||      ||      ||    ||      |\n'),
    write('|      || |||| || ||||||| ||||||  |||||   ||      ||      ||    ||      |\n'),
    write('|      ||  ||  || ||   || ||      ||      ||      ||      ||    ||      |\n'),
    write('|      ||      || ||   || ||      ||||||| ||||||| |||||||  ||||||       |\n'),
    write('|                                                                       |\n'),
    write('|                                                                       |\n'),
    write('|                             Miguel Gomes                              |\n'),
    write('|                            Pedro Teixeira                             |\n'),
    write('|               -----------------------------------------               |\n'),
    write('|                                                                       |\n'),
    write('|                                                                       |\n'),
    write('|                          1. Player vs Player                          |\n'),
    write('|                                                                       |\n'),
    write('|                          2. Player vs Computer                        |\n'),
    write('|                                                                       |\n'),
	write('|                          3. Computer vs Computer                      |\n'),
    write('|                                                                       |\n'),
    write('|                          0. Exit                                      |\n'),
    write('|                                                                       |\n'),
    write('|                                                                       |\n'),
    write('|_______________________________________________________________________|\n'),
    nl,nl.