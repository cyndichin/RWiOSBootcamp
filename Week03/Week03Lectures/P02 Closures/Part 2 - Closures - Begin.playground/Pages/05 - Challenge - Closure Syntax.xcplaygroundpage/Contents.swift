//: [⇐ Previous: 04 - Closure Syntax](@previous)
//: ## Episode 05: Challenge - Closure Syntax

/*:
 ## Challenge 1
 Rewrite the long closure with the following syntax:
  * No parameter types
  * No parameter or return types
  * No parameter names
 Try passing the same values into each closure. Their printed results should match!
*/
typealias Copy = (String, Int) -> Void
// --------------------------------------
let copyLines = { (offense: String, repeatCount: Int) -> Void in
  print( String(repeating: "I must not \(offense).", count: repeatCount) )
}
// --------------------------------------

// TODO: Write solution here

// No parameter types
let copyLines2: Copy = { (offense, repeatCount) -> Void in
  print( String(repeating: "I must not \(offense).", count: repeatCount) )
}

// No parameter or return types
let copyLines3: Copy = {
  print( String(repeating: "I must not \($0).", count: $1) )
}

//No parameter names



//: [⇒ Next: 06 - forEach and map](@next)
