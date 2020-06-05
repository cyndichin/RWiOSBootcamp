//: [⇐ Previous: 05 - Structures](@previous)
//: ## Episode 06: Challenge - Structures

/*:
 # Challenge 1

1. Create a structure named `Student` with three properties: first name, last name and grade.
2. Create a structure named `Classroom` with two properties: the subject, and an array of students.
3. Create a method that returns the highest grade in the classroom.
*/
struct Student {
    let firstName: String
    let lastName: String
    let grade: Int
}

struct Classroom {
    let subject: String
    var students: [Student]
    
    // optional if students was an array
    func highestGrade() -> Int? {
        var max = 0
        for student in students {
            if student.grade > max {
                max = student.grade
            }
        }
        return max
    }
}


/*:
 # Challenge 2

 1. Create an instance of a `Classroom`
 2. Use the `getHighestGrade` method
*/
let john = Student(firstName: "John", lastName: "doe", grade: 76)
let jane = Student(firstName: "Jane", lastName: "Smith", grade: 96)
let catie = Student(firstName: "Catie", lastName: "Cheese", grade: 2)
let math = Classroom(subject: "Math", students: [john, jane])

math.highestGrade()


//: [⇒ Next: 07 - Classes](@next)
