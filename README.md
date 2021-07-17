### Things needed for custom ships
1. Modify dialog for the player to account for each ship
2. Turn player.player_ships method into a loop that exits when player is done
 and verifies placement of every ship
3. An array to store the ships for easy access?
4. Modify computer.com_placement to copy each ship over from the player instead
 of generating the 2 base ships
5. Modify game.display_board(player) to contain information about each ship
 created
6. Modify game.win_condition to account for each ship in the game
7. Ensure presets for 4x4 and Traditional games




### Things needed for smarter computer(computer.turns)
1. Computer shot results will be recorded in an array
2. First shot is fine being randomized, but will need a new loop for if a
 random shot hits a ship
3. When the computer hits a ship the loop will go clockwise through non
 fired_upon cells directly above, to the right of, below, and to the left of
 the hit
4. The computer will continue in this direction until a ship is sunk, a miss is
 recorded, or it reaches an invalid coord
5. If the computer reaches a miss or an invalid square it will continue in the
 opposite direction until a ship is sunk, a miss is recorded, or it reaches an
 invalid coordinate
6. The computer will then return to random shots until another hit is recorded
