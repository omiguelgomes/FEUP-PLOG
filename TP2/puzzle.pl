startRandom :- generateRandomGrid(Height-Width, Diamonds),
               generateBoard(Height, Width, Board),
               fillDiamonds(Board, Diamonds, Aux, NewBoard),
               displayGame(Height, Width, Diamonds, NewBoard), !,
               getSolutions(Height-Width, Diamonds, Squares),!,
               makeAllSquares(Board, Squares, 'a', FinalBoard).


startCustomSize :- 
                   write('Custom Height: '), read(Height),
                   write('Custom Widtht: '), read(Width),
                   random(1, 10, DiamondNr),
                   generateDiamondList(Height, Width, DiamondNr, [], Diamonds),
                   generateBoard(Height, Width, Board),
                   fillDiamonds(Board, Diamonds, Aux, NewBoard),
                   displayGame(Height, Width, Diamonds, NewBoard), !,
                   getSolutions(Height-Width, Diamonds, Squares), !.
                   /*makeAllSquares(NewBoard, Squares, 'a', FinalBoard)*/
                   /*displayGame(Height, Width, Diamonds, FinalBoard).*/
                   

startCustomSizeDiamonds :- 
                   write('Custom Height: '), read(Height),
                   write('Custom Widtht: '), read(Width),
                   write('Custom no. of diamonds: '), read(DiamondNr),
                   generateDiamondList(Height, Width, DiamondNr, [], Diamonds),
                   generateBoard(Height, Width, Board),
                   fillDiamonds(Board, Diamonds, Aux, NewBoard),
                   displayGame(Height, Width, Diamonds, NewBoard), !,
                   getSolutions(Height-Width, Diamonds, Squares), !,
                   makeAllSquares(NewBoard, Squares, 'a', FinalBoard),
                   displayGame(Height, Width, Diamonds, FinalBoard).

startExample :- example2(Height-Width, Diamonds),
                generateBoard(Height, Width, Board),
                fillDiamonds(Board, Diamonds, Aux, NewBoard),
                displayGame(Height, Width, Diamonds, NewBoard), !,
                getSolutions(Height-Width, Diamonds, Squares),
                makeAllSquares(NewBoard, Squares, 'a', FinalBoard),
                displayGame(Height, Width, Diamonds, FinalBoard).


getSolutions(GridHeight-GridWidth, Diamonds, Squares) :- 
    /*generate lists for the solutions*/
    length(Diamonds, NrSquares),
    length(SquaresX, NrSquares),
    length(SquaresY, NrSquares),
    length(SquaresWidth, NrSquares),
    /*
        max values for the square's parameters 
    */
    min2([GridHeight, GridWidth], MaxLength),
    /*
        variable domains
    */ 
    domain(SquaresWidth, 1, MaxLength),
    setDomain(SquaresX, SquaresY, Diamonds),

    /*
        variable constraints
    */
    getRectangles(SquaresX, SquaresY, SquaresWidth, Rectangles),
    GridArea is GridHeight*GridWidth,
    sum_areas(SquaresWidth, GridArea),
    maplist5(squareFitsDiamond(GridHeight-GridWidth), Diamonds, SquaresX, SquaresY, SquaresWidth),
    disjoint2(Rectangles, []),
    
    /*down searches from the max value to the bottom*/
    /*bisect makes binary choice between > median or < median. in contrast, the default (step) starts with the largest or smallest possibility, which usuallt dont work here*/
    labeling([down, bisect], SquaresWidth),
    labeling([bisect], SquaresX),
    labeling([bisect], SquaresY),

    findall([X-Y, Width], (nth0(Index, SquaresX, X), nth0(Index, SquaresY, Y), nth0(Index, SquaresWidth, Width)), Squares).

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


getRectangles(X, Y, Width, Rectangles) :- getRectangles(X, Y, Width, [], Rectangles).
getRectangles([], _, _, Rectangles, Rectangles).

getRectangles([X|XTail], [Y|YTail], [Width|WidthTail], Temp, Rectangles) :- append(Temp, [functor(X, Width, Y, Width)], NewTemp),
                                                    getRectangles(XTail, YTail, WidthTail, NewTemp, Rectangles).

setDomain([], [], []).
setDomain([X|XTail], [Y|YTail], [DX-DY|DTail]) :- domain([X], 0, DX), domain([Y], 0, DY),
                                                    setDomain(XTail, YTail, DTail).
