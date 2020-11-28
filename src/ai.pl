choose_move(GameState, Player, Level, Move) :- valid_moves(GameState, Player, ListOfMoves), length(ListOfMoves, ListLength), 
                                                ListLength >= Level,
                                                choose_move(GameState, Player, Level, ListOfMoves, Move).

choose_move(GameState, Player, Level, Move) :- valid_moves(GameState, Player, ListOfMoves), length(ListOfMoves, ListLength), 
                                                ListLength < Level, 
                                                choose_move(GameState, Player, ListLength, ListOfMoves, Move).

choose_move(_, _, 1, [X-Y|T], [X-Y]).
choose_move(GameState, Player, Level, ListOfMoves, Move) :- getBestMove(GameState, Player, ListOfMoves, X-Y, [], 0),
                                                                      delete(ListOfMoves, X-Y, NewListOfMoves),
                                                                      Level1 is Level-1,
                                                                      choose_move(GameState, Player, Level1, NewListOfMoves, Move).
                                                                      


getBestMove(GameState, Player, [X-Y|T], BestMove, BestMoveTemp, BestMoveValue) :-   placePiece(GameState, Player, X, Y, NewGameState),                                                                                     
                                                                                    value(NewGameState, Player, Score),
                                                                                    Score >= BestMoveValue, 
                                                                                    getBestMove(GameState, Player, T, BestMove, X-Y, Score).

getBestMove(GameState, Player, [X-Y|T], BestMove, BestMoveTemp, BestMoveValue) :- getBestMove(GameState, Player, T, BestMove, BestMoveTemp, BestMoveValue).

getBestMove(_, _, [], BestMove, BestMove, _).
                                                    
tC :- initial(GameState), choose_move(GameState, 'B', 20, Move), write(Move).
