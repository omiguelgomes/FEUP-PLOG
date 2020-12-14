play :- printMainMenu, getInput(Mode), parseMode(Mode).

printMainMenu :- 
    nl,nl,
    write(' ______________________________________________________________________________________|\n'),
    write('|                                                                                      |\n'),
    write('|                                                                                      |\n'),
    write('|          |||||||   ||||||   |||||   |||    |||   ||||||   |||    ||  |||||||         |\n'),
    write('|          ||    ||    ||    ||   ||  ||||  ||||  ||    ||  ||||   ||  ||    ||        |\n'),
    write('|          ||    ||    ||    |||||||  || |||| ||  ||    ||  || ||  ||  ||    ||        |\n'),
    write('|          ||    ||    ||    ||   ||  ||  ||  ||  ||    ||  ||   ||||  ||    ||        |\n'),
    write('|          |||||||   ||||||  ||   ||  ||      ||   ||||||   ||    |||  |||||||         |\n'),
    write('|                                                                                      |\n'),
    write('|                   ||||||   ||    ||  |||||||  |||||||  ||      |||||||               |\n'),
    write('|                   ||   ||  ||    ||       ||       ||  ||      ||                    |\n'),
    write('|                   ||||||   ||    ||    |||      |||    ||      |||||                 |\n'),
    write('|                   ||       ||    ||  ||       ||       ||      ||                    |\n'),
    write('|                   ||        ||||||   |||||||  |||||||  ||||||| |||||||               |\n'),
    write('|                                                                                      |\n'),
    write('|                                                                                      |\n'),
    write('|                                                                                      |\n'),
    write('|                                     Miguel Gomes                                     |\n'),
    write('|                                    Pedro Teixeira                                    |\n'),
    write('|                       -----------------------------------------                      |\n'),
    write('|                                                                                      |\n'),
    write('|                                                                                      |\n'),
    write('|                            1. Random grid                                            |\n'),
    write('|                                                                                      |\n'),
    write('|                            2. Custom size                                            |\n'),
    write('|                                                                                      |\n'),
	write('|                            3. Custom size with custom diamonds                       |\n'),
    write('|                                                                                      |\n'),
    write('|                            0. Exit                                                   |\n'),
    write('|                                                                                      |\n'),
    write('|                                                                                      |\n'),
    write('|______________________________________________________________________________________|\n'),
    nl,nl.


getInput(Mode) :- write('What mode would you like to execute?'),
                  read(Mode).

parseMode(1) :- startRandom.
parseMode(2) :- startCustomSize.
parseMode(3) :- startCustomSizeDiamonds.
parseMode(_) :- write('Invalid mode\n').


