//
//  Game.swift
//  jQuiz
//
//  Created by cynber on 7/27/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class GameManager {
    var clues: [Clue] = []
    var correctAnswerClue: Clue?
    var points: Int = 0
    
    func addPoints(_ score: Int) {
        points += score
    }
    
    func setAnswer() {
        let randomInt = Int.random(in: 0...3)
        correctAnswerClue = clues[randomInt]
    }
    
}
