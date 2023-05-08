#lang forge/bsl

sig Board {
    position : pfunc Int -> Int -> Player,
    next: lone Board
    // prev_player: lone Player
    
}

// one sig initBoard, finalBoard extends Board{}

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



pred starting[b: Board] {
        //aka all boards don't have the first board in the next
    all non_start:Board | {
        non_start.next != b
    }
    //white pebbles and black pebbles should be 0
    #{row, col: Int | b.position[row][col] = White} = 24
    #{row, col: Int | b.position[row][col] = Black} = 24

    //SETUP
    not_five_row[b, White]
    not_five_row[b,Black]

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
//1 + 4
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

//4 + 1

pred four_horizontal_two[pre:Board, p:Player, row:Int, col:Int] {
    no pre.position[row][col]
    pre.position[row][subtract[col,1]] = p
    pre.position[row][subtract[col,2]] = p  
    pre.position[row][subtract[col,3]] = p  
    pre.position[row][subtract[col,4]] = p
}

pred four_vertical_two[pre:Board, p:Player, row:Int, col:Int] {
    no pre.position[row][col]
    pre.position[subtract[row,1]][col] = p
    pre.position[subtract[row,2]][col] = p
    pre.position[subtract[row,3]][col] = p
    pre.position[subtract[row,4]][col] = p
}

pred four_decr_diagonal_two[pre:Board, p:Player, row:Int, col:Int] {
    no pre.position[row][col]
    pre.position[subtract[row,1]][subtract[col,1]] = p
    pre.position[subtract[row,2]][subtract[col,2]] = p
    pre.position[subtract[row,3]][subtract[col,3]] = p
    pre.position[subtract[row,4]][subtract[col,4]] = p
}

pred four_incr_diagonal_two[pre:Board, p:Player, row:Int, col:Int] {
    no pre.position[row][col]
    pre.position[add[row,1]][subtract[col,1]] = p
    pre.position[add[row,2]][subtract[col,2]] = p
    pre.position[add[row,3]][subtract[col,3]] = p
    pre.position[add[row,4]][subtract[col,4]] = p
}



//2 + 2 -- vertical, horizontal, diag, diag
pred two_twos_vertical[pre:Board, p:Player, row:Int, col:Int] { 
    pre.position[subtract[row,2]][col] = p
    pre.position[subtract[row,1]][col] = p
    no pre.position[row][col]
    pre.position[add[row,1]][col] = p
    pre.position[add[row,2]][col] = p
}

pred two_twos_horizontal[pre:Board, p:Player, row:Int, col:Int] { 
    pre.position[row][subtract[col, 2]] = p
    pre.position[row][subtract[col, 1]] = p
    no pre.position[row][col]
    pre.position[row][add[col, 1]] = p
    pre.position[row][add[col, 2]] = p
}

pred two_twos_decr_diag[pre:Board, p:Player, row:Int, col:Int] { 
    pre.position[subtract[row,2]][subtract[col,2]] = p
    pre.position[subtract[row,1]][subtract[col,1]] = p
    no pre.position[row][col]
    pre.position[add[row,1]][add[col,1]] = p
    pre.position[add[row,2]][add[col,2]] = p
}

pred two_twos_incr_diag[pre:Board, p:Player, row:Int, col:Int] { 
    pre.position[add[row,2]][subtract[col,2]] = p
    pre.position[add[row,1]][subtract[col,1]] = p
    no pre.position[row][col]
    pre.position[subtract[row,1]][add[col,1]] = p
    pre.position[subtract[row,2]][add[col,2]] = p
}


//1 + 3 -- vertical, horizontal, diag, diag
pred one_three_vertical[pre:Board, p:Player, row:Int, col:Int] { 
    pre.position[subtract[row,1]][col] = p
    no pre.position[row][col]
    pre.position[add[row,1]][col] = p
    pre.position[add[row,2]][col] = p
    pre.position[add[row,3]][col] = p
    
}

pred one_three_horizontal[pre:Board, p:Player, row:Int, col:Int] { 
    pre.position[row][subtract[col, 1]] = p
    no pre.position[row][col]
    pre.position[row][add[col, 1]] = p
    pre.position[row][add[col, 2]] = p
    pre.position[row][add[col, 3]] = p
}

pred one_three_decr_diag[pre:Board, p:Player, row:Int, col:Int] { 
    pre.position[subtract[row,1]][subtract[col,1]] = p
    no pre.position[row][col]
    pre.position[add[row,1]][add[col,1]] = p
    pre.position[add[row,2]][add[col,2]] = p
    pre.position[add[row,3]][add[col,3]] = p
}

pred one_three_incr_diag[pre:Board, p:Player, row:Int, col:Int] { 
    pre.position[add[row,1]][subtract[col,1]] = p
    no pre.position[row][col]
    pre.position[subtract[row,1]][add[col,1]] = p
    pre.position[subtract[row,2]][add[col,2]] = p
    pre.position[subtract[row,3]][add[col,3]] = p
}

//3 + 1 -- vertical, horixonta, diag, diag
pred three_one_vertical[pre:Board, p:Player, row:Int, col:Int] { 
    pre.position[subtract[row,3]][col] = p
    pre.position[subtract[row,2]][col] = p
    pre.position[subtract[row,1]][col] = p
    no pre.position[row][col]
    pre.position[add[row,1]][col] = p
    
}

pred three_one_horizontal[pre:Board, p:Player, row:Int, col:Int] { 
    pre.position[row][subtract[col, 3]] = p
    pre.position[row][subtract[col, 2]] = p
    pre.position[row][subtract[col, 1]] = p
    no pre.position[row][col]
    pre.position[row][add[col, 1]] = p
}

pred three_one_decr_diag[pre:Board, p:Player, row:Int, col:Int] { 
    pre.position[subtract[row,3]][subtract[col,3]] = p
    pre.position[subtract[row,2]][subtract[col,2]] = p
    pre.position[subtract[row,1]][subtract[col,1]] = p
    no pre.position[row][col]
    pre.position[add[row,1]][add[col,1]] = p
}

pred three_one_incr_diag[pre:Board, p:Player, row:Int, col:Int] { 
    pre.position[add[row,3]][subtract[col,3]] = p
    pre.position[add[row,2]][subtract[col,2]] = p
    pre.position[add[row,1]][subtract[col,1]] = p
    no pre.position[row][col]
    pre.position[subtract[row,1]][add[col,1]] = p
}


pred four_row_prior[pre:Board, p:Player] {
    some row,col:Int {
        four_in_a_row[pre, p, row, col]
    }
}

pred four_in_a_row[pre:Board, p:Player, row:Int, col:Int] {
    four_horizontal[pre, p, row, col] or four_vertical[pre, p, row, col] or four_decr_diagonal[pre, p,row,col] or four_incr_diagonal[pre, p,row,col] or 
    four_horizontal_two[pre, p, row, col] or four_vertical_two[pre, p, row, col] or four_decr_diagonal_two[pre, p,row,col] or four_incr_diagonal_two[pre, p,row,col] or 
    two_twos_vertical[pre, p, row, col] or two_twos_horizontal[pre, p, row, col] or two_twos_decr_diag[pre, p, row, col] or two_twos_incr_diag[pre, p, row, col] or 
    one_three_vertical[pre, p, row, col] or one_three_horizontal[pre, p, row, col] or one_three_decr_diag[pre, p, row, col] or one_three_incr_diag[pre, p, row, col] or 
    three_one_vertical[pre, p, row, col] or three_one_horizontal[pre, p, row, col] or three_one_decr_diag[pre, p, row, col] or three_one_incr_diag[pre, p, row, col]
    
}


pred prior_board[pre:Board, post:Board, row:Int, col:Int] {
    no pre.position[row][col] -- nobody's moved there yet
    
    row <= 13 and row >= 0
    col <= 13  and col >= 0 
    // p = Black implies Bturn[pre] -- appropriate turn
    // p = White implies 

    #{row, col: Int | pre.position[row][col] = Black} = #{row, col: Int | pre.position[row][col] = White}
    
    Wturn[pre]  

    all row2: Int, col2: Int | (row!=row2 or col!=col2) implies {                
        post.position[row2][col2] = pre.position[row2][col2]     
    } 

}


pred complete_four_set[b:Board] {
    some row, col:Int {
        row >= 0
        row <= 13
        col >= 0
        col <= 13
        prior_board[b, b.next, row, col]
        four_in_a_row[b,White,row, col]
        b.next.position[row][col] = White
    }
}

pred randomly_place[b:Board, p:Player] {
    some row, col:Int {
        row >= 0
        row <= 13
        col >= 0
        col <= 13
        prior_board[b, b.next, row, col]
        
        b.position[add[row,1]][col] = p or b.position[row][add[col, 1]] = p or b.position[subtract[row,1]][col] = p or b.position[row][subtract[col, 1]] = p
        b.next.position[row][col] = p
    }
}

pred test_restrictions[pre:Board, p:Player] {
    some row,col:Int {
        four_horizontal[pre, p, row, col] or four_vertical[pre, p, row, col] or four_decr_diagonal[pre, p,row,col] or four_incr_diagonal[pre, p,row,col] or 
        four_horizontal_two[pre, p, row, col] or four_vertical_two[pre, p, row, col] or four_decr_diagonal_two[pre, p,row,col] or four_incr_diagonal_two[pre, p,row,col] or 
        two_twos_vertical[pre, p, row, col] or two_twos_horizontal[pre, p, row, col] or two_twos_decr_diag[pre, p, row, col] or two_twos_incr_diag[pre, p, row, col] or 
        one_three_vertical[pre, p, row, col] or one_three_horizontal[pre, p, row, col] or one_three_decr_diag[pre, p, row, col] or one_three_incr_diag[pre, p, row, col] 

    }
}

pred allowed[pre:Board, p:Player] {
    some row, col:Int {
         three_one_vertical[pre, p, row, col] or three_one_horizontal[pre, p, row, col] or three_one_decr_diag[pre, p, row, col] or three_one_incr_diag[pre, p, row, col]
    }
}

pred black_test[pre:Board] {
    pre.next.position[0][0] = Black
    pre.next.position[1][1] = Black
    pre.next.position[2][2] = Black
    pre.next.position[3][3] = Black
    pre.next.position[4][4] = Black
    pre.next.position[5][5] = Black
}

pred defend_four_set[b:Board] {
    some row, col:Int {
        row >= 0
        row <= 13
        col >= 0
        col <= 13
        prior_board[b, b.next, row, col]
        four_in_a_row[b,Black,row, col]
        b.next.position[row][col] = White
    }
}




pred TransitionStates{
    
    
    some init,final: Board{
        starting[init]
        // ending[final]

        all b: Board | some b.next implies {

            //TESTS
            // not test_restrictions[b, White]
            // allowed[b, White]

            //four in a row prior --> comlete the set
            four_row_prior[b, White] implies complete_four_set[b]
            four_row_prior[b,Black] implies defend_four_set[b]
            // four_row_prior[b, Black] and not four_row_prior[b, White] implies complete_four_set[b,Black]

            //default case
            // not four_row_prior[b,Black] implies randomly_place[b, White]
        }
    }
}

run { 
    wellformed
    TransitionStates 
    balanced 

    } for exactly 2 Board, 5 Int for {next is linear}