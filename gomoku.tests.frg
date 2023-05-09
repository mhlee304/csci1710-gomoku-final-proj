#lang forge/bsl 
open "gomoku.frg"

test suite for wellformed{
    // If you have tests for this predicate, put them here!
    example emptyBoard is wellformed for{
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
    }

    example edge_is_wellformed is wellformed for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0
        position = `B0 -> (0-> 1 -> `Black0 + 0 -> 2 -> `White0)

    }

    example fourteen_index_is_incorrect is not wellformed for{
        #Int = 5
        Black = `Black0
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = `B0 -> (14-> 1 -> `Black0)

    }
}

test suite for Wturn{
    // If you have tests for this predicate, put them here!
    example correctWTurn is {some pre: Board | Wturn[pre]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0
        position = `B0 -> (0-> 1 -> `Black0 + 0 -> 2 -> `White0)

    }
    
    example correctStartingTurn is {some pre: Board | Wturn[pre]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0
        position = `B0 -> (0-> 1 -> `Black0 + 0 -> 2 -> `White0)

    }

    example incorrectWTurn is not {some pre: Board | Wturn[pre]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0
        position = `B0 -> (0->3 -> `White0)
    }

    example emptyWTurn is {some pre: Board | Wturn[pre]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0
      
    }

}

test suite for Bturn {
    // If you have tests for this predicate, put them here!

    example correctBTurn is{some pre: Board | Bturn[pre]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0
        position = `B0 -> (0->3 -> `White0)
    }

    example emptyBTurn is not {some pre: Board | Bturn[pre]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0
      
    }
    
}
//add more once starting is completed 
test suite for starting{
    example incorrectstartingAmount is not {some b: Board | starting[b]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0
        position = `B0 ->
        (0 -> 1 -> `White0
        + 0 -> 2 -> `Black0 
        + 0->3 -> `White0 
        + 0-> 4-> `Black0
        + 0->5-> `White0
        + 0 -> 6 -> `Black0 
        + 0 -> 1 -> `White0
        + 0 -> 7 -> `Black0 
        + 0->8 -> `White0 
        + 0-> 9-> `Black0
        + 0->10-> `White0
        + 0 -> 11 -> `Black0
        + 1 -> 1 -> `White0
        + 1 -> 2 -> `Black0 
        + 1->3 -> `White0 
        + 1-> 4-> `Black0
        + 1->5-> `White0
        + 1 -> 6 -> `Black0
        + 1 -> 1 -> `White0
        + 1 -> 7 -> `Black0 
        + 1->8 -> `White0 
        + 1-> 9-> `Black0
        + 1->10-> `White0
        + 1 -> 11 -> `Black0
        + 2 -> 1 -> `White0
        + 2 -> 2 -> `Black0 
        + 2->3 -> `White0 
        + 2-> 4-> `Black0
        + 2->5-> `White0
        + 2 -> 6 -> `Black0
        + 2 -> 1 -> `White0
        + 2 -> 7 -> `Black0 
        + 2->8 -> `White0 
        + 2-> 9-> `Black0
        + 2->10-> `White0
        + 2 -> 11 -> `Black0
        )

    }

    example duplicateBoards is not {some b: Board | starting[b]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        next = `B0 -> `B0
    }

}

test suite for not_five_row{

//    example invalid_five_row is not {some b: Board, p: Player| not_five_row[b,p]} for {
//         #Int = 5
//         Black = `Black0 
//         White = `White0 
//         Player = `Black0 + `White0
//         Board = `B0 
//         position = 
//         `B0 -> 
//         (0 -> 1 -> `Black0 + 
//         0 -> 2 -> `Black0 + 
//         0 -> 3 -> `Black0 + 
//         0 -> 4 -> `Black0 + 
//         0 -> 5 -> `Black0)
//    }

      example valid_five_row is {some b: Board, p: Player| not_five_row[b,p]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (0 -> 1 -> `Black0 + 
        1 -> 2 -> `Black0 + 
        5 -> 3 -> `Black0 + 
        6 -> 4 -> `Black0 + 
        7 -> 5 -> `Black0)
   }

}

test suite for five_vertical{
    example correct_five_vertical is {some b: Board, p: Player | five_vertical[b,p]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (0 -> 1 -> `Black0 
        + 1 -> 1 -> `Black0 
        + 2 -> 1 -> `Black0 
        + 3 -> 1 -> `Black0 
        + 4 -> 1 -> `Black0)
    }

    example incorrect_five_vertical is not {some b: Board, p: Player | five_vertical[b,p]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (0 -> 1 -> `Black0 
        + 1 -> 2 -> `Black0 
        + 2 -> 1 -> `Black0 
        + 3 -> 1 -> `Black0 
        + 4 -> 1 -> `Black0)
    }
}

test suite for five_horizontal{
    example correct_five_horizontal is {some b: Board, p: Player | five_horizontal[b,p]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 1 -> 2 -> `White0 
        + 1 -> 3 -> `White0 
        + 1 -> 4 -> `White0 
        + 1 -> 5 -> `White0)
    }

    example incorrect_five_horizontal is not {some b: Board, p: Player | five_horizontal[b,p]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 1 -> 2 -> `White0 
        + 1 -> 3 -> `White0 
        + 1 -> 4 -> `White0 
        + 1 -> 8 -> `White0)
    }
}


test suite for five_decr_diagonal{
    example correct_five_decrdiagonal is {some b: Board, p: Player | five_decr_diagonal[b,p]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 

        position = 
        `B0 -> 
        (0 -> 0 -> `Black0 
        + 1 -> 1 -> `Black0 
        + 2 -> 2 -> `Black0 
        + 3 -> 3 -> `Black0 
        + 4 -> 4 -> `Black0)

    }

    example incorrect_five_decrdiagonal is not {some b: Board, p: Player | five_decr_diagonal[b,p]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 1 -> 2 -> `White0 
        + 1 -> 3 -> `White0 
        + 1 -> 4 -> `White0 
        + 1 -> 8 -> `White0)
    }
}

test suite for five_incr_diagonal{
    example correct_five_incrdiagonal is {some b: Board, p: Player | five_incr_diagonal[b,p]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 

        position = 
        `B0 -> 
        (5 -> 1-> `Black0 
        + 4 -> 2 -> `Black0 
        + 3 -> 3 -> `Black0 
        + 2 -> 4 -> `Black0 
        + 1 -> 5 -> `Black0)
    }

    example incorrect_five_incrdiagonal is not {some b: Board, p: Player | five_incr_diagonal[b,p]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 1 -> 2 -> `White0 
        + 1 -> 3 -> `White0 
        + 1 -> 4 -> `White0 
        + 1 -> 8 -> `White0)
    }
}


test suite for four_vertical{
    example correct_four_vertical is {some b: Board, p: Player, row: Int, col: Int | four_vertical[b,p, row, col]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (0 -> 1 -> `Black0 
        + 1 -> 1 -> `Black0 
        + 2 -> 1 -> `Black0 
        + 3 -> 1 -> `Black0 
       )
    }

    example incorrect_four_vertical is not {some b: Board, p: Player, row: Int, col: Int | four_vertical[b,p, row, col]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (0 -> 1 -> `Black0 
        + 1 -> 2 -> `Black0 
        + 2 -> 1 -> `Black0 
        + 3 -> 1 -> `Black0 
        + 4 -> 1 -> `Black0)
    }
}

test suite for four_horizontal{
    example correct_four_horizontal is {some b: Board, p: Player, row: Int, col: Int | four_horizontal[b,p, row, col]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 1 -> 2 -> `White0 
        + 1 -> 3 -> `White0 
        + 1 -> 4 -> `White0 
    )
    }

    example incorrect_four_horizontal is not {some b: Board, p: Player, col: Int, row: Int | four_horizontal[b,p, row, col]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 1 -> 2 -> `White0 
        + 1 -> 3 -> `White0 
        + 1 -> 5 -> `White0
       )
    }
}



test suite for four_decr_diagonal{
    example correct_four_decrdiagonal is {some b: Board, p: Player, row: Int, col: Int | four_decr_diagonal[b,p, row ,col]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 

        position = 
        `B0 -> 
        (0 -> 0 -> `Black0 
        + 1 -> 1 -> `Black0 
        + 2 -> 2 -> `Black0 
        + 3 -> 3 -> `Black0 
        )

    }

    example incorrect_four_decrdiagonal is not {some b: Board, p: Player, row: Int, col: Int | four_decr_diagonal[b,p, row, col]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 1 -> 2 -> `White0 
        + 1 -> 3 -> `White0  
        + 1 -> 8 -> `White0)
    }
}


test suite for four_incr_diagonal{
    example correct_four_incrdiagonal is {some b: Board, p: Player, row: Int, col: Int | four_incr_diagonal[b,p, row, col]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 

        position = 
        `B0 -> 
        (5 -> 1-> `Black0 
        + 4 -> 2 -> `Black0 
        + 3 -> 3 -> `Black0 
        + 2 -> 4 -> `Black0)
    }

    example incorrect_four_incrdiagonal is not {some b: Board, p: Player, row: Int, col: Int | four_incr_diagonal[b,p, row, col]} for{
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 1 -> 2 -> `White0 
        + 1 -> 3 -> `White0  
        + 1 -> 8 -> `White0)
    }
}

test suite for two_twos_vertical{
    example correct_two_twos_vertical is {some pre: Board, p: Player, row: Int, col: Int | two_twos_vertical[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 2 -> 1 -> `White0 
        + 4-> 1 -> `White0  
        + 5 -> 1 -> `White0)
    }

     example incorrect_two_twos_vertical is not {some pre: Board, p: Player, row: Int, col: Int | two_twos_vertical[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 2 -> 1 -> `White0 
        + 3-> 1 -> `White0  
        + 4 -> 1 -> `White0)
    }
}

test suite for two_twos_horizontal{
    example correct_two_twos_horizontal is {some pre: Board, p: Player, row: Int, col: Int | two_twos_horizontal[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (5 -> 3 -> `White0 
        + 5 -> 4 -> `White0 
        + 5-> 6 -> `White0  
        + 5 -> 7 -> `White0)
    }

     example incorrect_two_twos_horizontal is not {some pre: Board, p: Player, row: Int, col: Int | two_twos_horizontal[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (6 -> 7 -> `White0 
        + 6 -> 8 -> `White0 
        + 6-> 9 -> `White0  
        + 6 -> 10 -> `White0)
    }
}

test suite for two_twos_incr_diag{
     example correct_two_twos_incr is {some pre: Board, p: Player, row: Int, col: Int | two_twos_incr_diag[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (9 -> 1-> `White0 
        + 8 -> 2 -> `White0 
        + 6 -> 4->  `White0  
        + 5 -> 5 -> `White0)
    }

     example incorrect_two_twos_incr is not {some pre: Board, p: Player, row: Int, col: Int | two_twos_incr_diag[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (6 -> 7 -> `White0 
        + 6 -> 8 -> `White0 
        + 6-> 9 -> `White0  
        + 6 -> 10 -> `White0)
    }
}

test suite for two_twos_decr_diag{
     example correct_two_twos_decr is {some pre: Board, p: Player, row: Int, col: Int | two_twos_decr_diag[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (5 -> 3 -> `White0 
        + 6 -> 4 -> `White0 
        + 8-> 6 ->  `White0  
        + 9 -> 7 -> `White0)
    }

     example incorrect_two_twos_decr is not {some pre: Board, p: Player, row: Int, col: Int | two_twos_decr_diag[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (6 -> 7 -> `White0 
        + 6 -> 8 -> `White0 
        + 6-> 9 -> `White0  
        + 6 -> 10 -> `White0)
    }
}

test suite for one_three_vertical{
    example correct_one_three_vertical is {some pre: Board, p: Player, row: Int, col: Int | one_three_vertical[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 3 -> 1 -> `White0 
        + 4-> 1 -> `White0  
        + 5 -> 1 -> `White0)
    }

     example incorrect_one_three_vertical is not {some pre: Board, p: Player, row: Int, col: Int | one_three_vertical[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 2 -> 1 -> `White0 
        + 3-> 1 -> `White0  
        + 4 -> 1 -> `White0)
    }
}

test suite for one_three_horizontal{
    example correct_one_three_horizontal is {some pre: Board, p: Player, row: Int, col: Int | one_three_horizontal[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (4 -> 1 -> `White0 
        + 4 -> 3 -> `White0 
        + 4-> 4 -> `White0  
        + 4 -> 5 -> `White0)
    }

     example incorrect_one_three_horizontal is not {some pre: Board, p: Player, row: Int, col: Int | one_three_horizontal[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (2 -> 1 -> `White0 
        + 2 -> 2 -> `White0 
        + 2-> 3 -> `White0  
        + 2-> 4 -> `White0)
    }
}


test suite for one_three_decr_diag{
    example correct_one_three_decr_diag is {some pre: Board, p: Player, row: Int, col: Int | one_three_decr_diag[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (4 -> 1 -> `White0 
        + 6-> 3 -> `White0 
        + 7-> 4 -> `White0  
        + 8 -> 5 -> `White0)
    }

     example incorrect_one_three_decr_diag is not {some pre: Board, p: Player, row: Int, col: Int | one_three_decr_diag[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (4 -> 1 -> `White0 
        + 5 -> 2 -> `White0 
        + 6 -> 3 -> `White0  
        + 7-> 4 -> `White0)
    }
}

test suite for one_three_incr_diag{
    example correct_one_three_incr_diag is {some pre: Board, p: Player, row: Int, col: Int | one_three_incr_diag[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (6 -> 2 -> `White0 
        +4  -> 4 -> `White0 
        + 3 -> 5 -> `White0  
        + 2 -> 6 -> `White0)
    }

     example incorrect_one_three_incr_diag is not {some pre: Board, p: Player, row: Int, col: Int | one_three_incr_diag[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (4 -> 1 -> `White0 
        + 6-> 3 -> `White0 
        + 7-> 4 -> `White0  
        + 8 -> 5 -> `White0)
    }
}

test suite for three_one_vertical{
    example correct_three_one_vertical is {some pre: Board, p: Player, row: Int, col: Int | three_one_vertical[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 2 -> 1 -> `White0 
        + 3-> 1 -> `White0  
        + 5 -> 1 -> `White0)
    }

     example incorrect_three_one_vertical is not {some pre: Board, p: Player, row: Int, col: Int | three_one_vertical[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (1 -> 1 -> `White0 
        + 2 -> 1 -> `White0 
        + 3-> 1 -> `White0  
        + 4 -> 1 -> `White0)
    }
}

test suite for one_three_horizontal{
    example correct_three_one_horizontal is {some pre: Board, p: Player, row: Int, col: Int | three_one_horizontal[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (4 -> 1 -> `White0 
        + 4 -> 2 -> `White0 
        + 4-> 3 -> `White0  
        + 4 -> 5-> `White0)
    }

     example incorrect_three_one_horizontal is not {some pre: Board, p: Player, row: Int, col: Int | three_one_horizontal[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (2 -> 1 -> `White0 
        + 2 -> 2 -> `White0 
        + 2-> 3 -> `White0  
        + 2-> 4 -> `White0)
    }
}


test suite for three_one_decr_diag{
    example correct_three_one_decr_diag is {some pre: Board, p: Player, row: Int, col: Int | three_one_decr_diag[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (2-> 2 -> `White0 
        + 3 -> 3 -> `White0 
        + 4-> 4 -> `White0  
        + 6 -> 6 -> `White0)
    }

     example incorrect_three_one_decr_diag is not {some pre: Board, p: Player, row: Int, col: Int | three_one_decr_diag[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (4 -> 1 -> `White0 
        + 5 -> 2 -> `White0 
        + 6 -> 3 -> `White0  
        + 7-> 4 -> `White0)
    }
}

test suite for three_one_incr_diag{
    example correct_three_one_incr_diag is {some pre: Board, p: Player, row: Int, col: Int | three_one_incr_diag[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (9 -> 3-> `White0 
        +8  -> 4 -> `White0 
        + 7 -> 5 -> `White0  
        + 5 -> 7 -> `White0)
    }

     example incorrect_three_one_incr_diag is not {some pre: Board, p: Player, row: Int, col: Int | three_one_incr_diag[pre, p, row, col]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = 
        `B0 -> 
        (4 -> 1 -> `White0 
        + 6-> 3 -> `White0 
        + 7-> 4 -> `White0  
        + 8 -> 5 -> `White0)
    }
}




test suite for four_row_prior{
    example correct_four_row_prior is {some pre: Board, p: Player | four_row_prior[pre,p]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = `B0 -> (1 -> 1 -> `White0 + 1 -> 2 -> `White0 + 1 -> 3 -> `White0 + 1 -> 4 -> `White0 )
    }
    
    example incorrect_four_row_prior is not {some pre: Board, p: Player | four_row_prior[pre,p]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 
        position = `B0 -> (1 -> 1 -> `White0 + 1 -> 2 -> `White0 + 1 -> 3 -> `White0 + 1 -> 7 -> `White0 )
    }
}

test suite for prior_board{
    example correct_turns_prior_board is {some pre: Board, post: Board, row: Int, col: Int, p:Player | prior_board[pre,post,row,col,p]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 + `B1 
        next = `B0 -> `B1 + `B1 -> none 
        position = `B0 -> (1 -> 1 -> `White0 + 1 -> 2 -> `Black0 + 1 -> 3 -> `White0 + 1 -> 7 -> `Black0 ) + `B1 -> (1 -> 1 -> `White0 + 1 -> 2 -> `Black0 + 1 -> 3 -> `White0 + 1 -> 7 -> `Black0 + 2 -> 3 -> `White0 )
    }

    example incorrect_prior_board_no_turns is not {some pre: Board, post: Board, row: Int, col: Int, p:Player | prior_board[pre,post,row,col,p]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 + `B1 
        next = `B0 -> `B1 
        position = `B0 -> (1 -> 1 -> `White0 + 1 -> 2 -> `White0 + 1 -> 3 -> `White0 + 1 -> 7 -> `White0 ) + `B1 -> (1 -> 1 -> `White0 + 1 -> 2 -> `White0 + 1 -> 3 -> `White0 + 1 -> 7 -> `White0 + 2 -> 3 -> `White0 )
    }

    // example incorrect_prior_board is not {some pre: Board, post: Board, row: Int, col: Int, p:Player | prior_board[pre,post,row,col,p]} for {
    //     #Int = 5
    //     Black = `Black0 
    //     White = `White0 
    //     Player = `Black0 + `White0
    //     Board = `B0 + `B1 
    //     next = `B0 -> `B1 + `B1 -> none 
    //     position = `B0 -> (1 -> 1 -> `White0 + 1 -> 2 -> `Black0 + 1 -> 3 -> `White0 + 1 -> 7 -> `Black0 ) + `B1 -> (1 -> 1 -> `White0 + 1 -> 2 -> `Black0 + 1 -> 3 -> `White0 + 2 -> 3 -> `Black0 )
    // }
}

test suite for complete_four_set{
    // example correct_complete_four_set is {some b: Board, p: Player | complete_four_set[b,p]} for {
    //     #Int = 5
    //     Black = `Black0 
    //     White = `White0 
    //     Player = `Black0 + `White0
    //     Board = `B0 + `B1 
    //     next = `B0 -> `B1 
    //     position = 
    //     `B0 ->
    //     (1 -> 1 -> `White0 +
    //     0 -> 1 -> `Black0 + 
    //     1 -> 2 -> `White0 +
    //     3 -> 3 -> `Black0 +
    //     1 -> 3 -> `White0 +
    //     6 -> 7 -> `Black0 + 
    //     1 -> 4 -> `White0 +
    //     8 -> 8 -> `Black0) 
    //     + 
    //     `B1 -> 
    //     (1 -> 1 -> `White0 +
    //     0 -> 1 -> `Black0 + 
    //     1 -> 2 -> `White0 +
    //     3 -> 3 -> `Black0 +
    //     1 -> 3 -> `White0 +
    //     6 -> 7 -> `Black0 + 
    //     1 -> 4 -> `White0 +
    //     8 -> 8 -> `Black0 +
    //     1 -> 5 -> `White0)
    // }
}

test suite for randomly_place{
    example correct_randomly_place is {some b: Board, p: Player | randomly_place[b, p]} for
    {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 + `B1 
        next = `B0 -> `B1 
        position = `B0 -> (1 -> 1 -> `White0 + 1 -> 2 -> `Black0 + 1 -> 3 -> `White0 + 1 -> 7 -> `Black0 ) + `B1 -> (1 -> 1 -> `White0 + 1 -> 2 -> `Black0 + 1 -> 3 -> `White0 + 1 -> 7 -> `Black0 + 2 -> 3 -> `White0)
    }

    example incorrect_randomly_place is not {some b: Board, p: Player | randomly_place[b, p]} for
    {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 + `B1 
        next = `B0 -> `B1 
        position = 
        `B0 -> (1 -> 1 -> `White0 + 1 -> 2 -> `Black0 + 1 -> 3 -> `White0 + 1 -> 7 -> `Black0 ) 
        + `B1 -> (1 -> 1 -> `White0 + 1 -> 2 -> `Black0 + 1 -> 3 -> `White0 + 2 -> 7 -> `Black0 + 1 -> 7 -> `White0)
    }
}

test suite for allowed {
    example correctly_allowed is {some pre:Board, p: Player | allowed[pre, p]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 + `B1 
        next = `B0 -> `B1 
        position = `B0 -> (1 -> 1 -> `White0 + 2 -> 1 -> `White0 + 3 -> 1 -> `White0 + 5 -> 1 ->`White0)
    }

    example not_correctly_allowed is {some pre:Board, p: Player | allowed[pre, p]} for {
        #Int = 5
        Black = `Black0 
        White = `White0 
        Player = `Black0 + `White0
        Board = `B0 + `B1 
        next = `B0 -> `B1 
        position = `B0 -> (1 -> 1 -> `White0 + 2 -> 1 -> `White0 + 3 -> 1 -> `White0 + 5 -> 1 ->`White0)
    }
}

test suite for TransitionStates {
    // example correct_transition_state is TransitionStates for {
    //     #Int = 5
    //     Black = `Black0 
    //     White = `White0 
    //     Player = `Black0 + `White0
    //     Board = `B0 + `B1 
    //     next = `B0 -> `B1 
    //     position = `B0 -> (1 -> 1 -> `White0 + 2 -> 1 -> `White0 + 3 -> 1 -> `White0 + 5 -> 1 ->`White0) + 
    //     `B1 -> (1 -> 1 -> `White0 + 2 -> 1 -> `White0 + 3 -> 1 -> `White0 + 5 -> 1 ->`White0 + 4 -> 1 -> `White0)

    // }
}