#lang forge/bsl

// Definitions
one sig Board {
    position : pfunc Int -> Int -> Player, 
    next: lone Board
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

run {
    some b: Board | wellformed[b]
} for exactly 1 Board

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

pred winDiagnoal[b: Board, p: Player] {
    some row, col: Int | {
        row >= 0
        row <= 10
        col >= 0
        col <= 10
        b.position[row + 0][col + 0] = p
        b.position[row + 1][col + 1] = p
        b.position[row + 2][col + 2] = p
        b.position[row + 3][col + 3] = p
        b.position[row + 4][col + 4] = p
    }
}