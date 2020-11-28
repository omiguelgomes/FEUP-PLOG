choose_move(GameState, Player, Level, X-Y) :- valid_moves(GameState, Player, ListOfMoves), length(ListOfMoves, ListLength), 
                                                choose_move(GameState, Player, Level, ListOfMoves,  X-Y).


/*TODO: TROCAR ORDEM, E ADICIONAR CUTS. QUANDO E LOGO NIVEL 1, ESCOLHE SIMPLESMENTE O PRIMEIRO*/

choose_move(_, _, _, [X-Y], X-Y).

choose_move(GameState, Player, 5, ListOfMoves, X-Y) :- getBestMove(GameState, Player, ListOfMoves, X-Y, [], 0).

choose_move(GameState, Player, Level, ListOfMoves, X-Y) :- getBestMove(GameState, Player, ListOfMoves, X1-Y1, [], 0),
                                                            delete(ListOfMoves, X1-Y1, NewListOfMoves),
                                                            Level1 is Level+1,
                                                            choose_move(GameState, Player, Level1, NewListOfMoves, X-Y).
                                                                      

getBestMove(GameState, Player, [X-Y|T], BestMove, _, BestMoveValue) :-   placePiece(GameState, Player, X, Y, NewGameState),                                                                                     
                                                                                    value(NewGameState, Player, Score),
                                                                                    Score >= BestMoveValue, 
                                                                                    getBestMove(GameState, Player, T, BestMove, X-Y, Score).

getBestMove(GameState, Player, [_|T], BestMove, BestMoveTemp, BestMoveValue) :- getBestMove(GameState, Player, T, BestMove, BestMoveTemp, BestMoveValue).

getBestMove(_, _, [], BestMove, BestMove, _).
