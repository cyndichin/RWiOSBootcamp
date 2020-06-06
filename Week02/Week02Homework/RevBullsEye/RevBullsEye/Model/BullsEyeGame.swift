//
//  BullsEyeGame.swift
//  RevBullsEye
//
//  Created by cynber on 6/5/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import Foundation

class BullsEyeGame {
    var currentValue: Int
    var targetValue: Int
    var score: Int
    var round: Int
    var title: String
    var points: Int
    
    var difference: Int {
        return abs(targetValue - currentValue)
    }
    
    init () {
        self.currentValue = 0
        self.targetValue = 0
        self.score = 0
        self.round = 0
        self.title = ""
        self.points = 0
    }
    
    func updateScore() {
        points = 100 - difference
        if difference == 0 {
         title = "Perfect!"
         points += 100
       } else if difference < 5 {
         title = "You almost had it!"
         if difference == 1 {
           points += 50
         }
       } else if difference < 10 {
         title = "Pretty good!"
       } else {
         title = "Not even close..."
       }
        score += points
    }
    
    func updateCurrentValue(with value: Int) {
        currentValue = value
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound() {
      round += 1
      targetValue = Int.random(in: 1...100)
      currentValue = 50
    }
}
