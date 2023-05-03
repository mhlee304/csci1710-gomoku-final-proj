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
    all row, col: Int | {
       no b.position[row][col] 
    }
    
    //aka all boards don't have the first board in the next
    all non_start:Board | {
        non_start.next != b
    }

    //white pebbles and black pebbles should be 0
    #{row, col: Int | b.position[row][col] = White} = 0
    #{row, col: Int | b.position[row][col] = Black} = 0

}

pred move[pre: Board, post:Board, row: Int, col: Int, p: Player] {
  -- guard:
//   #Int = 14 
  no pre.position[row][col] -- nobody's moved there yet
  
  row <= 13 and row >= 0
  col <= 13  and col >= 0 

  //Pre conditions
  p = Black implies Bturn[pre] -- appropriate turn
  p = White implies Wturn[pre]  


  all p:Player | not winner[pre,p]
  
  -- action:(what does the post-state then look like?)
  post.position[row][col] = p

  all row2: Int, col2: Int | (row!=row2 or col!=col2) implies {                
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
    // winner[final, Black] or winner[final, White] //commented for the time being
    final.next = none 
}

pred TransitionStates{
    some init,final: Board{
        // starting[init]
        // ending[final]

        #{row, col: Int | init.next.position[row][col] = White} = 5
        #{row, col: Int | init.next.position[row][col] = Black} = 5

        // #{row, col: Int | init.next.position[row][col] = White} = 1
        // #{row, col: Int | init.next.position[row][col] = Black} = 0

        all b: Board | some b.next implies {
            some row, col: Int, p: Player | {
                move[b, b.next, row, col, p]            
            }
            or
                doNothing[b, b.next]
        }
    }
}

// run { all b: Board | testingBoardVisualization[b]} for exactly 1 Board
run { 
    wellformed
    TransitionStates 
    balanced 
    } for exactly 2 Board, 5 Int for {next is linear}