#Programming in Swift Fundamentals Homework

## Part 1: BullsEyeGame
### Tasks
* Refactor BullsEye by using the Model-View-Controller design pattern
* Move game logic out of view controller
* Use a class instead of struct to build the model

### Why do we use a class instead of a struct?
* Classes are reference types and structures are value types. Originally, I started using a structure by default, but I realize that we had a model 

## Part 2: RGBullsEye
### Tasks
* Using same game model as **Part 1** to create a 3-slider variation of BullsEye
* Modify values to use RGB struct over Int
* Implement a BullsEye Hint where the slider's tint color fades to white as the slide thumb gers closer to the correction position

## Part 3: RevBullsEye

### Tasks
* Using same game model as **Part 1** to reverse the BullsEye game
* User enters a guess for the slider value