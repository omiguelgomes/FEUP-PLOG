play :- printMainMenu, getInput(Mode), parseMode(Mode), !.

printMainMenu :- 
    nl,nl,
    write(' ______________________________________________________________________________________ \n'),
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
    write('|                            2. Custom size with random diamonds                       |\n'),
    write('|                                                                                      |\n'),
	write('|                            3. Custom size with custom diamonds                       |\n'),
    write('|                                                                                      |\n'),
    write('|                            4-7. Quick Example                                        |\n'),
    write('|                                                                                      |\n'),
    write('|                            0. Exit                                                   |\n'),
    write('|______________________________________________________________________________________|\n'),
    nl,nl.

/*TODO: fazer com que input nao rebente quando recebe um ponto (.)*/
getInput(Mode) :- write('What mode would you like to execute?'),
                  read(Mode).

parseMode(1) :- statistics(walltime, [Start,_]), !,
                startRandom, !,
                statistics(walltime, [End,_]),
                Duration is End - Start,
                format('The program took ~4d s to run\n', [Duration]).


parseMode(2) :- statistics(walltime, [Start,_]), !,
                startCustomSize, !,
                statistics(walltime, [End,_]),
                Duration is End - Start,
                format('The program took ~4d s to run\n', [Duration]).

parseMode(Val) :- (Val > 7 ; Val < 1), write('Invalid mode\n').


parseMode(3) :- startCustomSizeDiamonds.

parseMode(Nr) :- Nr > 3, statistics(walltime, [Start,_]), !,
                         startExample(Nr), !,
                         statistics(walltime, [End,_]),
                         Duration is End - Start,
                         format('The program took ~4d s to run\n', [Duration]).

startExample(4) :- startExample1.

startExample(5) :- startExample2.

startExample(6) :- startExample3.

startExample(7) :- startExample4.

startExample(Val) :- (Val > 7 ; Val < 1), write('Invalid mode\n').