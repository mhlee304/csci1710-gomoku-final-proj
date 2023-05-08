#lang forge/bsl "csci1720-gomoku-final-proj/gomoku.tests" "anonymous email here"

-- Uncomment only one of these at a time!
-- Open vs. the obfuscated solution:
// open "bridge_crossing.wheat"
-- Open vs. your solution:
open "gomoku.frg"

test suite for ValidStates {
    // If you have tests for this predicate, put them here!
}

test suite for initState {
    // If you have tests for this predicate, put them here!
}

test suite for finalState {
    // If you have tests for this predicate, put them here!
}

test suite for canTransition {
    // TODO: Write 1 example of a valid transition
    example validTransition is {some pre, post: State | canTransition[pre, post]} for {
        // State = `S0 + `S1 -- only two states for simplicity
        // Person = `A + `B + `C + `D
        // A = `A
        // B = `B
        // C = `C
        // D = `D    
        // Near = `Near
        // Far = `Far
        // Position = Near + Far
        // -- constrain <next>, <shore>, <torch>, and <spent>
       
        // next = `S0 -> `S1

        // shore =
        //     `A -> `S0 -> `Near +
        //     `B -> `S0 -> `Near + 
        //     `C -> `S0 -> `Near +
        //     `D -> `S0 -> `Near +
        //     `A -> `S1 -> `Far +
        //     `B -> `S1 -> `Far + 
        //     `C -> `S1 -> `Near +
        //     `D -> `S1 -> `Near 
        
        // torch = `S0 -> `Near + `S1 -> `Far

        // time = `A -> 1 + `B -> 2 + `C -> 5 + `D -> 3

        // spent = `S0 -> 3 + `S1 -> 5

        // #Int = 5

    }
    // TODO: Write 2 examples of a invalid transition (give them better names!)
    example invalidTransitionTakesFastestTime is not {some pre, post: State | canTransition[pre, post]} for {
        -- FILL ME IN!
        // State = `S0 + `S1 -- only two states for simplicity
        // Person = `A + `B + `C + `D
        // A = `A
        // B = `B
        // C = `C
        // D = `D    
        // Near = `Near
        // Far = `Far
        // Position = Near + Far
        // -- constrain <next>, <shore>, <torch>, and <spent>

       
        // next = `S0 -> `S1

        // shore =
        //     `A -> `S0 -> `Near +
        //     `B -> `S0 -> `Near + 
        //     `C -> `S0 -> `Near +
        //     `D -> `S0 -> `Near +
        //     `A -> `S1 -> `Far +
        //     `B -> `S1 -> `Far + 
        //     `C -> `S1 -> `Near +
        //     `D -> `S1 -> `Near 
        
        // torch = `S0 -> `Near + `S1 -> `Far

        // time = `A -> 1 + `B -> 2 + `C -> 5 + `D -> 3

        // spent = `S0 -> 3 + `S1 -> 4

        // #Int = 5
    }
    example invalidTransition2 is not {some pre, post: State | canTransition[pre, post]} for {
        -- FILL ME IN!
    //     State = `S0 + `S1 -- only two states for simplicity
    //     Person = `A + `B + `C + `D
    //     A = `A
    //     B = `B
    //     C = `C
    //     D = `D    
    //     Near = `Near
    //     Far = `Far
    //     Position = Near + Far
    //     -- constrain <next>, <shore>, <torch>, and <spent>

       
    //     next = `S0 -> `S1

    //     shore =
    //         `A -> `S0 -> `Near +
    //         `B -> `S0 -> `Near + 
    //         `C -> `S0 -> `Near +
    //         `D -> `S0 -> `Near +
    //         `A -> `S1 -> `Far +
    //         `B -> `S1 -> `Far + 
    //         `C -> `S1 -> `Far +
    //         `D -> `S1 -> `Near 
        
    //     torch = `S0 -> `Near + `S1 -> `Far

    //     time = `A -> 1 + `B -> 2 + `C -> 5 + `D -> 3

    //     spent = `S0 -> 3+ `S1 -> 8

    //     #Int = 5
    }
    // If you have tests for this predicate, put them here!
}