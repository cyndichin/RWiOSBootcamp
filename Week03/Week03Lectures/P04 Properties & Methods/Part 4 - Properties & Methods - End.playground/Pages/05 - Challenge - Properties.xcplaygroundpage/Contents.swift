//: [⇐ Previous: 04 - Lazy Properties](@previous)
//: ## Episode 05: Challenge - Properties

/*:
 ## Challenge 1
 Create a struct named `Temperature` with properties for degrees in both Celsius and Fahrenheit, as `Double`s.
 * _Hint 1_: One property must be stored, but the other can be computed. They should always stay in sync.
 * _Hint 2_: To convert from Fahrenheit to Celsius, subtract 32, then divide by 1.8.
*/

// TODO: Write enumeration here
struct Temperature {
  var degreesF: Double {
    didSet {
      if degreesF > 100 {
        print("It's \(degreesF) degrees Fahrenheit! I had fun coding in Swift with you before I melted.")
      }
    }
  }
  
  var degreesC: Double {
    get { return (degreesF - 32) / 1.8 }
    set { degreesF = newValue * 1.8 + 32 }
  }
}

var temperature = Temperature(degreesF: 32)
temperature.degreesC = 75


/*:
 ## Challenge 2
 Modify the Fahrenheit property to print out a warning message if it is set to above 100 degrees.
*/


/*:
 ## Challenge 3
 Make the `monthsUntilJingleBells` and `season` functions into computed properties of `Month`.
 - Computed properties must be variable
 - To refer to an enum instance inside of a computed property, use `self`
*/

// --------------------------------------
enum Season: String, CaseIterable {
  case winter, spring, summer, autumn
}
// --------------------------------------


enum Month: Int {
  case january = 1, february, march, april, may, june, july, august, september, october, november, december
  
  // TODO: Write solution here
  var monthsUntilJingleBells: Int {
    Month.december.rawValue - rawValue
  }
  
  var season: Season {
    switch self {
    case .december, .january, .february:
      return .winter
    case .march, .april, .may:
      return .spring
    case .june, .july, .august:
      return .summer
    case .september, .october, .november:
      return .autumn
    }
  }
}

Month.august.monthsUntilJingleBells
Month.august.season


// --------------------------------------
func monthsUntilJingleBells(from month: Month) -> Int {
  Month.december.rawValue - month.rawValue
}

func season(for month: Month) -> Season {
  switch month {
  case .december, .january, .february:
    return .winter
  case .march, .april, .may:
    return .spring
  case .june, .july, .august:
    return .summer
  case .september, .october, .november:
    return .autumn
  }
}
// --------------------------------------

//: [⇒ Next: 06 - Methods](@next)

