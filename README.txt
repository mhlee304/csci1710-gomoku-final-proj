Gomoku Introduction: 
Gomoku, also known as Five in a Row, is played on a 14 by 14 board by two players (traditionally represented as black and white stones). 
We have modeled the most optimal move a player can make based on a randomly generated board of Gomoku. The player who forms an unbroken line of
five stones of their color horizontally, vertically, or diagonally is the winner. If the board is completely filled and no one has won, it is 
considered a tie. In our model, we have a starting and final board which holds information about the location of all stones on the board. The final 
board shows the optimal move Player white will make based on the initial board. 

What tradeoffs did you make in choosing your representation? What else did you try that didn’t work as well?
When we began coding our project, we intended to model all steps from start to finish. Although it would have been helpful to see the game from start to 
finish and see how players make an optimal move based on each round, we realized after our conversation with Tim that the scope of this project would require
 us to run 225 possible boards in Forge. Instead we decided to create a randomly generated board and show the optimal move a player can make based on the given board.
This allowed us to reach our target goal of showing how players can make the most optimal move to win all while decreasing run-time on Forge. 

Furthermore, we initially wanted to create one comprehensive predicate that would figure out the optimal move to make for a player based on the previous board.
 However, we underestimated the amount of possibilities in terms of optimal moves and scenarios we must consider—our code did not work because there was no 
 consideration of the hierarchy in terms of prioritization for the type of optimal move to be made and therefore we had to break apart the code to outline each 
 situation furthermore. 

What assumptions did you make about scope? What are the limits of your model?
Scoping of the project
Optimal Moves: 
One area we underestimated in terms of solving was writing out the possible optimal moves that could be made based on the properties of the Board. Initially, we 
thought of four different possibilities (five in-a-row vertically, horizontally, increasing diagonally, decreasing diagonally); however, there were certainly more 
edge-cases that we had to think through for the four scenarios. For example, a player could win five in-a-row vertically if they put their stone in the 
first, second, third, fourth, or fifth spot of the row of stones depending on the situation. This means, we needed to model each scenario separately in Forge. 

Starting Board: 
Given that our starting Board is randomly generated, added constraints to ensure there was a valid starting state. In our project, a valid board is defined as one 
with 24 White and 24 Black Stones—neither having a five in-a-row.  

Limits: 
One limit of this model is that it does not always give the most optimal move if a player has more than one possibility on a given board. For example, it does 
not know the optimal move between “black _ white white white black” and  “black _ white white white _ black.” In a situation like this, our forge model would 
choose the first optimal move that fits the criteria instead of making a decision with regards to future moves. 


Did your goals change at all from your proposal? Did you realize anything you planned was unrealistic, or that anything you thought was unrealistic was doable?
Our proposed target goal was to have players make the most optimal move to win.  Thus, we would like to make the “player” check the properties of the current board 
pieces and based on those pieces make the most optimal move. We reached our target goal in our final hand-in; however, the way we chose to model this was different from 
our original plan. As mentioned above, instead of modeling all the steps from start to finish, we decided to model one previous Board of randomly generated stones (24 Black & 24 White) 
and show the most optimal move for a player based on one previous board. In retrospect, our reach goal was unrealistic for our project given our timeline. We truly believed that we would
 be able to work on our reach goal of modeling this game as four players; however, given the extensive number of edge cases we had to find to model the optimal moves for two players, 
 it would be difficult to work with two additional players. 


How should we understand an instance of your model and what your custom visualization shows?

Sig:
Board: Our representation of a gomoku board. This sig contains information on positions of the stones on that Board and what the next board would be.
The next board will contain all the stones (at the same positions) from the previous board. Our model contains two boards: start and finish. 
The finish board shows the optimal move the white player will make in consideration of the placement of the stones in the start board. 

Optimal Move based on Priority based on the Properties of the Board:
If there is a 4 in a row of player’s stones, the player should place their stone on the end of the row
If there is a 4 in a row of opponent’s stones, the player should place their stone on the end of that row. 
If there is a 3 in a row of the opponent’s stones, the player should place their stone on the end of that row.  
If there is a 3 in a row of the player’s stones, the player should place their stone on the end of that row. 
If there is a certain position that creates 2 different rows that are at least 3 in a row, the player should place their stone in that spot

Important Preds: 
wellformed: stones cannot be placed outside the determined boundaries of the board 

Wturn = Player white goes when there the number of black and white stones are the same 

Bturn  = Player black goes when there is one less black stone than the number of white stones on the board 

Balanced: for all boards, it is either Player black or Player white’s turn 

starting: Adding the constraints to create a valid initial board to work with. This means that the starting board’s next board is not themselves,
the number of black and white stones is 24 and that there is no five in a row for either player. 

not_five_row: this predicate is called in the starting board to ensure there are no variations of five in-a-row
(five_vertical, five_horizontal, five_decr_diagonal, five_incr_diagonal) 

prior_board: This predicate ensures that stones in the initial board are at the same position in the final board, ensures the number of black stones 
and white stones are the same in the initial board (as we are modeling the optimal move Player white is making in the final board) 

Randomly_place: This generates a random row and column within the board boundaries and then place a stone there in the final board: 

Defend_four_set: this predicate is used when Player white does not have any four-in-a-row and is at a disadvantage because player black
 has a four in-a-row. Such logic applies to defend_three_set, and defend_two_set. 

defend_three_set_optimized: this predicate is used when black would be in an optimal situation and therefore the white stone is placed in the row 
and col that would benefit black. The same logic is applied to defend_two_set_optimzied: 

TransitionStates: Pred that calls on helper functions related to the optimal move based on the positions of the stones on the initial board; 
furthermore, if there is no such optimal move, a white stone will be randomly placed onto the board. 
