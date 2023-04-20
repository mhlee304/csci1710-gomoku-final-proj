#lang forge/bsl

// Definitions
one sig Board {
    position : pfunc Int -> Int -> Player
    next: lone Board
}

abstract sig Player {}

one sig Black extends Player {}
one sig White extends Player {}


//Wellformed Board
pred wellformed[b: Board] {
    all row, col: Int | {
        (row < 0 or row 15 or col < 0 or col > 15) implies
        no b.board[row][col]
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
        b.board[row + 0][col] = p
        b.board[row + 1][col] = p
        b.board[row + 2][col] = p
        b.board[row + 3][col] = p
        b.board[row + 4][col] = p
    }
}

pred winRow[b: Board, p: Player] {
    some row, col: Int | {
        row >= 0
        row <= 15
        col >= 0
        col <= 10
        b.board[row][col + 0] = p
        b.board[row][col + 1] = p
        b.board[row][col + 2] = p
        b.board[row][col + 3] = p
        b.board[row][col + 4] = p
    }
}

pred winDiagnoal[b: Board, p: Player] {
    some row, col: Int | {
        row >= 0
        row <= 10
        col >= 0
        col <= 10
        b.board[row + 0][col + 0] = p
        b.board[row + 1][col + 1] = p
        b.board[row + 2][col + 2] = p
        b.board[row + 3][col + 3] = p
        b.board[row + 4][col + 4] = p
    }
}