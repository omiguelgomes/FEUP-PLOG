startRandom :- generateRandomGrid(Height-Width, Diamonds), 
               displayGame(Height, Width, Diamonds), 
               getSolutions(Height-Width, Diamonds, Squares).


startCustomSize :- statistics(walltime, [Start,_]),
                   example(Height-Width, Diamonds), 
                   displayGame(Height, Width, Diamonds), 
                   getSolutions(Height-Width, Diamonds, Squares),
                   statistics(walltime, [End,_]),
                   Duration is End-Start,
                   format('The program took ~4ds to run\n', [Duration]).

startCustomSizeDiamonds :- write('Gonna execute custom size with custom diamonds\n').


/*all_distinct(Squares)*/
/*HeadDiamond, TailDiamond, HeadSquare, TailSquare*/
getSolutions(GridHeight-GridWidth, [DiamondX-DiamondY|Td], [[SquareX-SquareY, SquareWidth]|Ts]) :- 
    getSquareForDiamond(GridHeight-GridWidth, DiamondX-DiamondY, [SquareX-SquareY, SquareWidth]),
    format('Found a square at x:~d, y:~d with ~d width\n', [SquareX, SquareY, SquareWidth]).


/*SquareX and SquareY are the coords for the square's top left corner*/
getSquareForDiamond(GridHeight-GridWidth, DiamondX-DiamondY, [SquareX-SquareY, SquareWidth]) :- 
    domain([SquareX], 0, GridWidth),
    domain([SquareY], 0, GridHeight),
    domain([SquareWidth], 1, GridWidth),
    SquareX + SquareWidth #=< GridWidth,
    SquareY + SquareHeight #=< GridHeight,
    DiamondX #>= SquareX,
    DiamondX #=< SquareX+SquareWidth,
    DiamondY #>= SquareY,
    DiamondY #=< SquareY+SquareWidth,
    labeling([], [SquareX, SquareY, SquareWidth]).                      