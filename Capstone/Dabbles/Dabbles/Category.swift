//
//  Section.swift
//  Dabbles
//
//  Created by cynber on 7/24/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import Foundation

import UIKit

class Category: Hashable {
    var id = UUID()
    var title: String
    var challenges: [Challenge]
    
    init(title: String, challenges: [Challenge]) {
        self.title = title
        self.challenges = challenges
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
}

extension Category {
    static var allCategories: [Category] = [
        Category(title: "Fitness", challenges: [
            Challenge(
                title: "Summertime Fine",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            ),
            Challenge(
                title: "Push Up",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            )
        ]),
        Category(title: "Creative", challenges: [
            Challenge(
                title: "Drawing",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            ),
            Challenge(
                title: "Painting",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            )
        ]),
    ]
}
