//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Clue: Decodable {
    var id: Int
    var answer: String
    var question: String
    var value: Int?
    var airdate: String
    var createdAt: String
    var updatedAt: String
    var categoryId: Int
    var gameId: Int?
    var invalidCount: Int?
    var category: Category
    
    enum CodingKeys: String, CodingKey {
        case id
        case answer
        case question
        case value
        case airdate
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case categoryId = "category_id"
        case gameId = "game_id"
        case invalidCount = "invalid_count"
        case category
    }
}

struct Category: Decodable {
    var id: Int
    var title: String
    var createdAt: String
    var updatedAt: String
    var numOfClues: Int
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case numOfClues = "clues_count"
    }
}
