startRandom :- generateRandomGrid(Height-Width, Diamonds),
               generateBoard(Height, Width, Board),
               fillDiamonds(Board, Diamonds, Aux, NewBoard),
               displayGame(Height, Width, Diamonds, NewBoard), !,
               getSolutions(Height-Width, Diamonds, Squares).


startCustomSize :- exampleSmall(Height-Width, Diamonds), 
                   generateBoard(Height, Width, Board),
                   fillDiamonds(Board, Diamonds, Aux, NewBoard),
                   displayGame(Height, Width, Diamonds, NewBoard), !,
                   getSolutions(Height-Width, Diamonds, Squares).
                   

startCustomSizeDiamonds :- write('Gonna execute custom size with custom diamonds\n').


/*all_distinct(Squares)*/
/*HeadDiamond, TailDiamond, HeadSquare, TailSquare*/
/*    getSquareForDiamond(GridHeight-GridWidth, DiamondX-DiamondY, [SquareX-SquareY, SquareWidth]),*/
/*format('Found a square at x:~d, y:~d with ~d width\n', [SquareX, SquareY, SquareWidth]).*/

getSolutions(GridHeight-GridWidth, Diamonds, Squares) :- 
    /*generate lists for the solutions*/
    length(Diamonds, NrSquares),
    length(SquaresX, NrSquares),
    length(SquaresY, NrSquares),
    length(SquaresLength, NrSquares),
    /*
    max values for the square's parameters 
    */
    MaxSquareX is GridWidth-1,
    MaxSquareY is GridHeight-1,
    max2([GridHeight, GridWidth], MaxLength),
    /*
    variable domains
    */

    domain(SquaresX, 0, MaxSquareX),
    domain(SquaresY, 0, MaxSquareY),
    domain(SquaresLength, 1, MaxLength),

    findall([X-Y, Length], (nth0(Index, SquaresX, X), nth0(Index, SquaresY, Y), nth0(Index, SquaresLength, Length)), Squares),

    maplist(squareFitsDiamond(GridHeight-GridWidth), Diamonds, Squares),

    GridArea is GridHeight*GridWidth,
    sum_areas(Squares, GridArea),
    no_overlap(Squares),
    
    labeling([], SquaresX),
    labeling([], SquaresY),
    labeling([], SquaresLength),
    write(Squares).


/*SquareX and SquareY are the coords for the square's top left corner*/
/*getSquareForDiamond(3-3, 2-2, [SquareX-SquareY, SquareWidth]).*/
squareFitsDiamond(GridHeight-GridWidth, DiamondX-DiamondY, [SquareX-SquareY, SquareWidth]) :- 

    /*square is inside the grid limits*/
    SquareX + SquareWidth #=< GridWidth,
    SquareY + SquareWidth #=< GridHeight,

    /*diamond is inside the square*/
    DiamondX #>= SquareX,
    DiamondX #< SquareX+SquareWidth,
    DiamondY #>= SquareY,
    DiamondY #< SquareY+SquareWidth.


sum_areas(Squares, GridArea) :- sum_areas(Squares, GridArea, 0).

sum_areas([], Area, Area).

sum_areas([[SquareX-SquareY, SquareWidth]|Rest], GridArea, Temp) :- Area #= SquareWidth*SquareWidth,
                                                                    NewTemp #= Temp + Area,
                                                                    sum_areas(Rest, GridArea, NewTemp).

no_overlap(List) :- length(List, 1).

no_overlap([Square|Tail]) :- \+overlaps_any(Square, Tail), no_overlap(Tail).

/*true if first argument overlaps any of the squares in the second argument*/
overlaps_any(Square1, Rest) :- member(Square2, Rest), overlaps(Square1, Square2).

/*true if first square overlaps second*/
overlaps([X1-Y1, Length1], [X2-Y2, Length2]) :- X1+Length1 #> X2, X2+Length2 #> X1, Y1+Length1 #> Y2, Y2+Length2 #> Y1.


test :- statistics(walltime, [Start,_]), !,
                sleep(10),
                statistics(walltime, [End,_]),
                Duration is (End - Start)*10,
                format('The program took ~4d s to run\n', [Duration]).