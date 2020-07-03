import UIKit

// Variables
var str = "Hello, playground"
str = "Goodbye"

// Strings and Integers
// Swift is a type-safe language (so every variable must be of a specific type)
// Strings and integers are different types, and they can’t be mixed.
var age = 38
var population = 8_000_000 // underscores as thousant separators
 
// Multi-line strings (three double quote marks)
// \ to avoid line breaks
var str1 = """
This goes \
over multiple
lines
"""

// Doubles and Booleans
// “Double” is short for “double-precision floating-point number”, and it’s a fancy way of saying it holds fractional values such as 38.1, or 3.141592654.
// Whenever you create a variable with a fractional number, Swift automatically gives that variable the type Double.
// Bool hold true or false
var pi = 3.141
var awesome = true

// String interpolation
// the ability to place variables inside your strings to make them more useful
// As you’ll see later on, string interpolation isn’t just limited to placing variables – you can actually run code inside there.
var score = 85
var str2 = "Your score was \(score)"
var results = "The test results are here: \(str)"

// Constants
// The let keyword creates constants, which are values that can be set once and never again.
let taylor = "swift"

// Type annotations
// Swift assigns each variable and constant a type based on what value it’s given when it’s created.
// type inference: Swift is able to infer the type of something based on how you created it.
let str3 = "Hello, playground"
// Being explicit
let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let taylorRocks: Bool = true

// SUMMARY - Simple Types
/*
1. You make variables using var and constants using let. It’s preferable to use constants as often as possible.
 
2. Strings start and end with double quotes, but if you want them to run across multiple lines you should use three sets of double quotes.
 
3. Integers hold whole numbers, doubles hold fractional numbers, and booleans hold true or false.
 
4. String interpolation allows you to create strings from other variables and constants, placing their values inside your string.
 
5. Swift uses type inference to assign each variable or constant a type, but you can provide explicit types if you want.
*/
