/*initial function, shows menu, and asks for user input for the game mode*/

play :- printMainMenu, 
       write('What mode would you like to play?'),
       read(Input),
       manageInput(Input).

/*parse input for game mode*/

manageInput(1) :-  startGame.
manageInput(2) :-   write('What should the AI difficulty be? (1-5)\n'),
                    read(Level),
                    startGamePvsC(Level).

manageInput(3) :-   !, write('What should the black AI difficulty be? (1-5)\n'),
                       read(LevelBlack),
                       write('What should the white AI difficulty be? (1-5)\n'),
                       read(LevelWhite),
                       startGameCvsC(LevelBlack, LevelWhite).

manageInput(_) :- write('Invalid mode!').
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