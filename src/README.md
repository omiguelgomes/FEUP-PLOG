# FEUP-PLOG

Mapello_4

Turma 1

Miguel Rodrigues Gomes up201605908

Pedro Miguel Afonso Teixeira  up201505916


## The game
Mapello is a board game based on Reversi designed by Simon M. Lucas. The objective is to have the highest ammount of pieces of the same colour (the one player chose) when there's no longer any valid move available. 

Full set of rules on https://nestorgames.com/#mapello_detail

## The pieces
 - White piece ('W')
 - Black piece ('B')
 - Walls: They act like normal walls (same as the outer part of the board) ('#')
 - Bonuses: They count as extra points when captured (+3 for each) ('P')
 - Jokers: They act as normal pieces of the player in turn ('J')


## Setup
The players can choose between playing an original board setup or create their own by choosing where the walls, bonuses and jokers go.

Note that only jokers can be put in the outer part of the board.

## Playing phase
The players alternate turns having to place a piece adjacent to an opponent's piece (vertically, horizontally or diagonally). The player then captures all pieces contigous in a straight line between the newly placed piece and a player's piece or joker turning them into their own pieces. If a player is unable to capture a piece in his move he passes.

At the end the player with the most points wins.

## Representation of the gamestate

![All boardsd](https://github.com/omiguelgomes/FEUP-PLOG/blob/master/TI/allboardsinone.png?raw=true)
         
         

## Gamestate display

![Code to print board](https://raw.githubusercontent.com/omiguelgomes/FEUP-PLOG/master/TI/printingtheboard.PNG)



