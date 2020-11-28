choose_move(GameState, Player, Level, Move) :- choose_move(GameState, Player, Level, Move, MoveTemp).

choose_move(GameState, Player, Level, Move, MoveTemp) :- valid_moves(GameState, Player, ListOfMoves),
                                                         getBestMove(GameState, Player, ListOfMoves, MoveTemp, [], 0),
                                                         [X-Y] is MoveTemp,
                                                         placePiece(GameState, Player, X, Y, NewGameState),
                                                         getOpponent(Player, Opponent),
                                                         valid_moves(NewGameState, Opponent, ListOfMovesOpponent),
                                                         getBestMove(NewGameState, Opponent, ListOfMovesOpponent, MoveOpponent, [], 0),
                                                         [X1-Y1] is MoveOpponent,
                                                         placePiece(NewGameState, Opponent, X1, Y1, NewNewGameState),
                                                         Level1 is Level-1,
                                                         choose_move(NewNewGameState, Player, Level1, Move, MoveTemp).

getBestMove(GameState, Player, [X-Y|T], BestMove, BestMoveTemp, BestMoveValue) :-   placePiece(GameState, Player, X, Y, NewGameState),                                                                                     
                                                                                    value(NewGameState, Player, Score),
                                                                                    Score >= BestMoveValue, 
                                                                                    getBestMove(GameState, Player, T, BestMove, [X-Y], Score).

getBestMove(GameState, Player, [X-Y|T], BestMove, BestMoveTemp, BestMoveValue) :- getBestMove(GameState, Player, T, BestMove, BestMoveTemp, BestMoveValue).

getBestMove(_, _, [], BestMove, BestMove, _).
                                                    


getBestMove(_, _, [], BestMove, BestMove, _).

tC :- initial(GameState), choose_move(GameState, 'B', 0, Move).
