#lang forge/bsl

// Definitions
// one sig Game {
//     initialState: one Board,
//     next: pfunc Board -> Board
// }

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
            (row < 0 or row  > 14 or col < 0 or col > 14) implies 
            no b.position[row][col]
        }
    }
}

// run {
//     some b: Board | wellformed[b]

// } for exactly 1 Board

pred Bturn[pre:Board, post: Board] {
    -- same number of X and O on board
    #{row, col: Int | post.position[row][col] = Black} = 
    #{row, col: Int | post.position[row][col] = White}

    add[#{row, col: Int | pre.position[row][col] = Black}, 1] = 
    #{row, col: Int | pre.position[row][col] = White}

    #{row, col: Int | pre.position[row][col] = White} = #{row, col: Int | post.position[row][col] = White}

    add[#{row, col: Int | pre.position[row][col] = Black}, 1] = 
    #{row, col: Int | post.position[row][col] = Black}



}

pred Wturn[pre:Board, post: Board] {
    add[#{row, col: Int | post.position[row][col] = Black},1] = 
    #{row, col: Int | post.position[row][col] = White}

    // #{row, col: Int | pre.position[row][col] = Black} = 
    // #{row, col: Int | pre.position[row][col] = White}

    // add[#{row, col: Int | pre.position[row][col] = White}, 1] = #{row, col: Int | post.position[row][col] = White}

    // #{row, col: Int | pre.position[row][col] = Black} = 
    // #{row, col: Int | post.position[row][col] = Black}



}

pred balanced{
    all b: Board{
    Bturn[b, b.next] or Wturn[b, b.next]
    }
}

//Constraint to ensure next Board has one one more piece than last board 
// pred nextBoard[b:Board]{
//     all b: Board|{

//     }
// }
//Constraints to Determine the Player Move


//Constraints to a Winner
pred winCol[b: Board, p: Player] {
    some row, col: Int | {
        row >= 0
        row <= 10
        col >= 0
        col <= 14
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
        row <= 14
        col >= 0
        col <= 10
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
        row <= 14
        col >= 0
        col <= 10
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
        row <= 10
        col >= 0
        col <= 10
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
    all row, col: Int | {
       no b.position[row][col] 
    }
    
    //akk tge boards don't have the first board in the next
    all non_start:Board | {
        non_start.next != b
    }

    //white pebbles and black pebbles should be 0
    #{row, col: Int | b.position[row][col] = White} = 0
    #{row, col: Int | b.position[row][col] = Black} = 0
}

pred move[pre: Board, row: Int, col: Int, p: Player, post: Board] {
  -- guard:
//   #Int = 14 
  no pre.position[row][col]   -- nobody's moved there yet

  //case 1: pre have the same black and white; post has white + 1
  //case 2: pre have white = black + 1. post has white = black
  p = Black implies Bturn[pre, post] -- appropriate turn
  p = White implies Wturn[pre, post]  
  row <= 14 and row >= 0
  col <= 14  and col >= 0 

  all p:Player | not winner[pre,p]
  
  -- action:
  post.position[row][col] = p
  all row2: Int, col2: Int | (row!=row2 and col!=col2) implies {        
        post.position[row2][col2] = pre.position[row2][col2]     
  }  
}

pred doNothing[pre: Board, post: Board]{
    some p: Player | winner[pre, p]

    all row2: Int, col2: Int|{
        post.position[row2][col2] = pre.position[row2][col2]
    }

    
}

pred ending[final: Board] {
    winner[final, Black] or winner[final, White]
    final.next = none 
}

pred TransitionStates{
    some init,final: Board{
        //possible error 
        // init.position = none 
        // init.next != none 

        starting[init]
        // final.position != none 
        ending[final]

        all b: Board | some b.next implies {
            some row, col: Int, p: Player|
            {
                move[b, row, col, p, b.next] 
            }
            // or
            // {
            //     doNothing[b, b.next]
            // } 
        }
    }
}

// pred testingBoardVisualization[b:Board]{
//     b.position[4][4] = Black
//     b.position[3][4] = Black
//     b.position[2][4] = Black

//     b.position[1][3] = White
//     b.position[1][1] = White
//     b.position[1][2] = White
// }

// run { all b: Board | testingBoardVisualization[b]} for exactly 1 Board
run { 
    wellformed
    TransitionStates 
    balanced 
    } for exactly 5 Board, 5 Int for {next is linear}