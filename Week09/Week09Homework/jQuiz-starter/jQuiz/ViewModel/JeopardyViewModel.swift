//
//  JeopardyViewModel.swift
//  jQuiz
//
//  Created by cynber on 7/27/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct JeopardyViewModel {
    let game: GameManager
    
    public init(with game: GameManager) {
        self.game = game
    }
    
    public var points: String {
      return "\(game.points)"
    }
    
    public var category: String? {
        return game.correctAnswerClue?.category.title
    }
    
    public var question: String? {
        return game.correctAnswerClue?.question
    }

    public var correctInfo: (title: String, message: String) {
        return ("Correct Answer!", "You scored \(game.correctAnswerClue?.value ?? 1) point!")
    }

    public var wrongInfo: (title: String, message: String) {
        guard let correctClue = game.correctAnswerClue else { return ("","")}
        return ("Wrong Answer!", "The correct answer was \(String(describing: correctClue.answer)). Try Again!")
    }
}
