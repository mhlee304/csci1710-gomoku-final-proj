#lang forge/bsl

sig Board {
    position : pfunc Int -> Int -> Player,
    next: lone Board
    // prev_player: lone Player
    
}

abstract sig Player {}
one sig Black, White extends Player {}



//Wellformed Board
pred wellformed{
    all b:Board|{
        all row, col: Int | {
            (row < 0 or row  > 13 or col < 0 or col > 13) implies 
            no b.position[row][col]
        }
    }
}

pred Wturn[pre:Board] {
    #{row, col: Int | pre.position[row][col] = Black} = 
    #{row, col: Int | pre.position[row][col] = White}
}


pred Bturn[pre:Board] {
    -- same number of X and O on board
    #{row, col: Int | pre.position[row][col] = White} = 
    add[#{row, col: Int | pre.position[row][col] = Black}, 1]
}


pred balanced{
    all b: Board{
    Bturn[b] or Wturn[b]
    }
}

//Constraints to a Winner
pred winCol[b: Board, p: Player] {
    some row, col: Int | {
        row >= 0
        row <= 9
        col >= 0
        col <= 13
        b.position[add[row,0]][col] = p
        b.position[add[row,1]][col] = p
        b.position[add[row,2]][col] = p
        b.position[add[row,3]][col] = p
        b.position[add[row,4]][col] = p

       
    }
}

pred winRow[b: Board, p: Player] {
    some row, col: Int | {
        row >= 0
        row <= 13
        col >= 0
        col <= 9
        b.position[row][add[col,0]] = p
        b.position[row][add[col,1]] = p
        b.position[row][add[col,2]] = p
        b.position[row][add[col,3]] = p
        b.position[row][add[col,4]] = p
    }
}

pred winDiagnoalIncr[b: Board, p: Player] {
    some row, col: Int | {
        row >= 4
        row <= 13
        col >= 0
        col <= 9
        b.position[add[row,0]][add[col,0]] = p
        b.position[add[row,1]][add[col,1]] = p
        b.position[add[row,2]][add[col,2]] = p
        b.position[add[row,3]][add[col,3]] = p
        b.position[add[row,4]][add[col,4]] = p
    }
}

pred winDiagonalDecr[b: Board, p: Player] {
    some row, col: Int | {
        row >= 0
        row <= 9
        col >= 0
        col <= 9
        b.position[subtract[row,0]][subtract[col,0]] = p
        b.position[subtract[row,1]][subtract[col,1]] = p
        b.position[subtract[row,2]][subtract[col,2]] = p
        b.position[subtract[row,3]][subtract[col,3]] = p
        b.position[subtract[row,4]][subtract[col,4]] = p
    }
}

pred winner[b: Board, p: Player] {
    winRow[b, p]
    or 
    winCol[b, p]
    or 
    winDiagnoalIncr[b,p]
    or 
    winDiagonalDecr[b, p]
}

pred starting[b: Board] {
        //aka all boards don't have the first board in the next
    all non_start:Board | {
        non_start.next != b
    }
    //white pebbles and black pebbles should be 0
    #{row, col: Int | b.position[row][col] = White} = 24
    #{row, col: Int | b.position[row][col] = Black} = 24

    //SETUP


    //Defense
    not_five_row[b, White]
    not_five_row[b,Black]
    // defensive_plays[b]


    //Attack
    //4 in a row of player's stone --> should place their stone on the end
    //3 in a row of a player's stone --> should place their stone on one of the ends
}

pred defensive_plays[b:Board] {
    //Defense
    //4 in a row of opponenet's stone --> player should place thier stone on the end of the row
    // four_row[b,White]
    //2 + _ + 2 in a row of opponent's stone --> player needs to stop in
    //3 + _ + 1 in a row of opponenet's stone --> player needs to stop it
    //1 + _ 3 in a row of opponene't stone --> player needs to stop it
    //3 in a row of opponent's stone --> player should place their stone on the end of the row
}

pred not_five_row[b:Board, p:Player] {
    not five_vertical[b, p]
    not five_horizontal[b,p]
    not five_decr_diagonal[b,p]
    not five_incr_diagonal[b,p]
}



pred five_vertical[b:Board, p:Player] {
    some row,col:Int | {
        b.position[add[row,0]][col] = p
        b.position[add[row,1]][col] = p
        b.position[add[row,2]][col] = p
        b.position[add[row,3]][col] = p
        b.position[add[row,4]][col] = p
    }
}

pred five_horizontal[b:Board, p:Player] {
    some row, col:Int | {
        b.position[row][add[col,0]] = p
        b.position[row][add[col,1]] = p
        b.position[row][add[col,2]] = p
        b.position[row][add[col,3]] = p
        b.position[row][add[col,4]] = p
    }
}

pred five_decr_diagonal[b:Board, p:Player] {
    some row, col:Int | {
        b.position[add[row,0]][add[col,0]] = p
        b.position[add[row,1]][add[col,1]] = p
        b.position[add[row,2]][add[col,2]] = p
        b.position[add[row,3]][add[col,3]] = p
        b.position[add[row,4]][add[col,4]] = p
    }
}

pred five_incr_diagonal[b: Board, p: Player] {
    some row, col: Int | {
        b.position[subtract[row,0]][add[col,0]] = p
        b.position[subtract[row,1]][add[col,1]] = p
        b.position[subtract[row,2]][add[col,2]] = p
        b.position[subtract[row,3]][add[col,3]] = p
        b.position[subtract[row,4]][add[col,4]] = p
    }
}



//FOUR PREDICATES
pred four_horizontal[pre:Board, p:Player, row:Int, col:Int] {
    no pre.position[row][col]
    pre.position[row][add[col,1]] = p
    pre.position[row][add[col,2]] = p  
    pre.position[row][add[col,3]] = p  
    pre.position[row][add[col,4]] = p
}

pred four_vertical[pre:Board, p:Player, row:Int, col:Int] {
    no pre.position[row][col]
    pre.position[add[row,1]][col] = p
    pre.position[add[row,2]][col] = p
    pre.position[add[row,3]][col] = p
    pre.position[add[row,4]][col] = p
}

pred four_decr_diagonal[pre:Board, p:Player, row:Int, col:Int] {
    no pre.position[row][col]
    pre.position[add[row,1]][add[col,1]] = p
    pre.position[add[row,2]][add[col,2]] = p
    pre.position[add[row,3]][add[col,3]] = p
    pre.position[add[row,4]][add[col,4]] = p

}

pred four_incr_diagonal[pre:Board, p:Player, row:Int, col:Int] {
    no pre.position[row][col]
    pre.position[subtract[row,1]][add[col,1]] = p
    pre.position[subtract[row,2]][add[col,2]] = p
    pre.position[subtract[row,3]][add[col,3]] = p
    pre.position[subtract[row,4]][add[col,4]] = p
}

//2 + 2 -- vertical, horizontal, diag, diag
//1 + 3 -- vertical, horizontal, diag, diag
//3 + 1 -- vertical, horixonta, diag, diag


pred four_row_prior[pre:Board, p:Player] {
    some row,col:Int {
        four_horizontal[pre, p, row, col] or four_vertical[pre,p,row,col] or four_decr_diagonal[pre, p,row,col] or four_incr_diagonal[pre, p,row,col]
    }
}

pred four_in_a_row[pre:Board, p:Player, row:Int, col:Int] {
    four_horizontal[pre, p, row, col] or four_vertical[pre, p, row, col] or four_decr_diagonal[pre, p,row,col] or four_incr_diagonal[pre, p,row,col]
}

//first check if there are 4 in a row for the opponent's stones


pred prior_board[pre:Board, post:Board, row:Int, col:Int, p:Player] {
    no pre.position[row][col] -- nobody's moved there yet
    
    row <= 13 and row >= 0
    col <= 13  and col >= 0 
    p = Black implies Bturn[pre] -- appropriate turn
    p = White implies Wturn[pre]  

    all row2: Int, col2: Int | (row!=row2 or col!=col2) implies {                
        post.position[row2][col2] = pre.position[row2][col2]     
    } 

}


pred complete_four_set[b:Board, p:Player] {
    some row, col:Int {
        row >= 0
        row <= 13
        col >= 0
        col <= 13
        prior_board[b, b.next, row, col, p]
        four_in_a_row[b,p,row, col]
        b.next.position[row][col] = p
    }
}

pred test_set_up[pre:Board] {
    some row,col:Int {
        four_vertical[pre, White, row, col] or four_horizontal[pre, White, row, col] or four_decr_diagonal[pre, White,row,col]//#or four_incr_diagonal[pre, White,row,col]



    }
}




pred TransitionStates{
    some init,final: Board{
        starting[init]
        // ending[final]

        all b: Board | some b.next implies {

            //TESTS
            b.position[6][3] = White
            b.position[5][4] = White
            b.position[4][5] = White
            b.position[3][6] = White
            not test_set_up[b]

            //four in a row prior --> comlete the set
            four_row_prior[b, White] implies complete_four_set[b, White]
            // four_row_prior[b, Black] and not four_row_prior[b, White] implies complete_four_set[b,Black]
        }
    }
}

run { 
    wellformed
    TransitionStates 
    balanced 

    } for exactly 2 Board, 5 Int for {next is linear}