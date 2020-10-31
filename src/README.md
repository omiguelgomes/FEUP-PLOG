# FEUP-PLOG

Mapello_4

Turma 1

Miguel Rodrigues Gomes up201605908

Pedro Miguel Afonso Teixeira  up201505916


## The game
Mapello is a board game based on Reversi designed by Simon M. Lucas. The objective is to have the highest ammount of pieces of the same colour (the one player chose) when there's no longer any valid move available. 

https://nestorgames.com/#mapello_detail

## The pieces
 - White piece
 - Black piece
 - Walls: They act like normal walls (same as the outer part of the board)
 - Bonuses: They count as extra points when captured (+3 for each)
 - Jokers: They act as normal pieces of the player in turn


## Setup
The players can choose between playing an original board setup or create their own by choosing where the walls, bonuses and jokers go.

Note that only jokers can be put in the outer part of the board.

## Playing phase
The players alternate turns having to place a piece adjacent to an opponent's piece (vertically, horizontally or diagonally). The player then captures all pieces contigous in a straight line between the newly placed piece and a player's piece or joker turning them into their own pieces. If a player is unable to capture a piece in his move he passes.

At the end the player with the most points wins.

## Representation of the gamestate

initialBoard([['#',   '#',   '#',   'J',   '#',   '#',   'J',   '#',   '#', '#'], 

         ['#', '#', ' ', 'P', ' ', 'P', ' ', ' ', '#', '#'], 
         
         ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', 'P', 'J'], 
         
         ['#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'], 
         
         ['#', 'P', '#', ' ', 'W', 'B', ' ', ' ', ' ', '#'],
         
         ['J', ' ', ' ', ' ', 'B', 'W', ' ', ' ', ' ', '#'], 
         
         ['#', 'P', ' ', ' ', ' ', ' ', ' ', '#', 'P', 'J'], 
         
         ['#', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'], 
         
         ['#', '#', ' ', 'P', ' ', ' ', ' ', 'P', '#', '#'], 
         
         ['#',   '#',   '#',   'J',   'J',   '#',   '#',   'J',   '#', '#']]).
         
         
         
midBoard([['#',   '#',   '#',   'J',   '#',   '#',   'J',   '#',   '#', '#'], 
         ['#', '#', ' ', 'P', ' ', 'P', ' ', ' ', '#', '#'], 
         ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', 'J'], 
         ['#', ' ', ' ', ' ', ' ', 'W', 'B', ' ', 'P', '#'], 
         ['#', 'P', '#', ' ', 'W', 'B', 'B', ' ', 'B', '#'], 
         ['J', ' ', ' ', ' ', 'B', 'B', 'B', 'B', 'P', '#'], 
         ['#', 'P', ' ', ' ', ' ', ' ', 'B', '#', ' ', 'J'], 
         ['#', ' ', ' ', '#', ' ', ' ', 'B', ' ', ' ', '#'], 
         ['#', '#', ' ', 'P', ' ', ' ', ' ', 'P', '#', '#'], 
         ['#',   '#',   '#',   'J',   'J',   '#',   '#',   'J',   '#', '#']]).       
         
      
endBoard([['#',   '#',   '#',   'J',   '#',   '#',   'J',   '#',   '#', '#'], 
         ['#', '#', 'W', 'P', 'W', 'P', 'B', 'W', '#', '#'], 
         ['#', 'W', 'W', 'B', 'W', 'B', '#', 'W', 'B', 'J'], 
         ['#', 'W', 'W', 'B', 'B', 'W', 'B', 'B', 'P', '#'], 
         ['#', 'P', '#', 'W', 'W', 'B', 'B', 'B', 'B', '#'], 
         ['J', 'W', 'B', 'B', 'B', 'B', 'B', 'B', 'P', '#'], 
         ['#', 'P', 'B', 'B', 'W', 'B', 'B', '#', 'B', 'J'], 
         ['#', 'W', 'B', '#', 'B', 'B', 'B', 'B', 'W', '#'], 
         ['#', '#', 'W', 'P', 'B', 'W', 'B', 'P', '#', '#'], 
         ['#',   '#',   '#',   'J',   'J',   '#',   '#',   'J',   '#', '#']]).      
         
         

## Gamestate display

![Code to print board](https://raw.githubusercontent.com/omiguelgomes/FEUP-PLOG/master/TI/printingtheboard.PNG)




