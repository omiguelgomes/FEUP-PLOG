choose_move(GameState, Player, Level, Move) :- choose_move(GameState, Player, Level, Move, MoveTemp).

choose_move(GameState, Player, Level, Move, MoveTemp) :- valid_moves(GameState, Player, ListOfMoves),
                                                         


getBestMove(_, _, [], BestMove, BestMove, _).

tC :- initial(GameState), choose_move(GameState, 'B', 0, Move).
