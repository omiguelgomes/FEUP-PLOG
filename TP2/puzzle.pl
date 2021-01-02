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
    length(SquaresWidth, NrSquares),
    /*
    max values for the square's parameters 
    */
    MaxSquareX is GridWidth-1,
    MaxSquareY is GridHeight-1,
    min2([GridHeight, GridWidth], MaxLength),
    /*
    variable domains
    */

    domain(SquaresX, 0, MaxSquareX),
    domain(SquaresY, 0, MaxSquareY),
    domain(SquaresWidth, 1, MaxLength),


    GridArea is GridHeight*GridWidth,
    sum_areas(SquaresWidth, GridArea),
    no_overlap(SquaresX, SquaresY, SquaresWidth),

    maplist5(squareFitsDiamond(GridHeight-GridWidth), Diamonds, SquaresX, SquaresY, SquaresWidth),
    
    labeling([], SquaresX),
    labeling([], SquaresY),
    labeling([], SquaresWidth),

    /*findall([X-Y, Width], (nth0(Index, SquaresX, X), nth0(Index, SquaresY, Y), nth0(Index, SquaresWidth, Width)), Squares),*/

    write(SquaresX), nl,
    write(SquaresY), nl,
    write(SquaresWidth), nl.


/*SquareX and SquareY are the coords for the square's top left corner*/
squareFitsDiamond(GridHeight-GridWidth, DiamondX-DiamondY, SquareX, SquareY, SquareWidth) :- 

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

sum_areas([SquareWidth|Rest], GridArea, Temp) :- Area #= SquareWidth*SquareWidth,
                                                                    NewTemp #= Temp + Area,
                                                                    sum_areas(Rest, GridArea, NewTemp).


 no_overlap(SquaresX, _, _) :- length(SquaresX, 1).

 no_overlap([SquareX|TailX], [SquareY|TailY], [SquareWidth|TailWidth]) :- \+overlaps_any(SquareX, SquareY, SquareWidth, TailX, TailY, TailWidth), no_overlap(TailX, TailY, TailWidth).

 /*true if first argument overlaps any of the squares in the second argument*/
 overlaps_any(_, _, _, [], [], []) :- fail.
 overlaps_any(SquareX, SquareY, SquareWidth, [Square2X|RestX], [Square2Y|RestY], [Square2Width|RestWidth]) :- overlaps(SquareX, SquareY, SquareWidth, Square2X, Square2Y, Square2Width).

 overlaps_any(SquareX, SquareY, SquareWidth, [Square2X|RestX], [Square2Y|RestY], [Square2Width|RestWidth]) :- \+overlaps(SquareX, SquareY, SquareWidth, Square2X, Square2Y, Square2Width),
                                                                                                                 overlaps_any(Square2X, Square2Y, Square2Width, RestX, RestY, RestWidth).

*/
/*true if first square overlaps second*/
overlaps(X1, Y1, Length1, X2, Y2, Length2) :- X1+Length1 #> X2, X2+Length2 #> X1, Y1+Length1 #> Y2, Y2+Length2 #> Y1.

/*no_overlap([0,0,0], [0, 2, 6], [3, 3, 3]).*/