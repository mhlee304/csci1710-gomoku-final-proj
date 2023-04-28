#lang forge/bsl

// Definitions
one sig Board {
    position : pfunc Int -> Int -> Player,
    next: lone Board
    // prev_player: lone Player
    
}
    

abstract sig Player {}
one sig Black, White extends Player {}



//Wellformed Board
pred wellformed[b: Board] {
    all row, col: Int | {
        (row < 0 or row  >15 or col < 0 or col > 15) implies 
        no b.position[row][col]
    }
}

// run {
//     some b: Board | wellformed[b]

// } for exactly 1 Board

pred Bturn[b: Board] {
    -- same number of X and O on board
    #{row, col: Int | b.position[row][col] = Black} = 
    #{row, col: Int | b.position[row][col] = White}
}

pred Wturn[b: Board] {
    #{row, col: Int | b.position[row][col] = Black} = 
    add[#{row, col: Int | b.position[row][col] = White}, 1]
}

pred balanced[b: Board] {
    Bturn[b] or Wturn[b]
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
        col <= 15
        b.position[row + 0][col] = p
        b.position[row + 1][col] = p
        b.position[row + 2][col] = p
        b.position[row + 3][col] = p
        b.position[row + 4][col] = p
    }
}

pred winRow[b: Board, p: Player] {
    some row, col: Int | {
        row >= 0
        row <= 15
        col >= 0
        col <= 10
        b.position[row][col + 0] = p
        b.position[row][col + 1] = p
        b.position[row][col + 2] = p
        b.position[row][col + 3] = p
        b.position[row][col + 4] = p
    }
}

pred winDiagnoalIncr[b: Board, p: Player] {
    some row, col: Int | {
        row >= 4
        row <= 14
        col >= 0
        col <= 10
        b.position[row + 0][col + 0] = p
        b.position[row + 1][col + 1] = p
        b.position[row + 2][col + 2] = p
        b.position[row + 3][col + 3] = p
        b.position[row + 4][col + 4] = p
    }
}

pred winDiagonalDecr[b: Board, p: Player] {
    some row, col: Int | {
        row >= 0
        row <= 10
        col >= 0
        col <= 10
        b.position[row - 0][col - 0] = p
        b.position[row - 1][col - 1] = p
        b.position[row - 2][col - 2] = p
        b.position[row - 3][col - 3] = p
        b.position[row - 4][col - 4] = p
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
    all row, col: Int | 
        no b.position[row][col]
}

pred move[pre: Board, row: Int, col: Int, p: Player, post: Board] {
  -- guard:
  no pre.position[row][col]   -- nobody's moved there yet
  p = Black implies Bturn[pre] -- appropriate turn
  p = White implies Wturn[pre]  
  
  -- action:
  post.position[row][col] = p
  all row2: Int, col2: Int | (row!=row2 and col!=col2) implies {        
        post.position[row2][col2] = pre.position[row2][col2]     
  }  
}

run { all b: Board | wellformed[b] and balanced[b]} 