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
    var ChallengeItems: [ChallengeItem]
    
    init(title: String, ChallengeItems: [ChallengeItem]) {
        self.title = title
        self.ChallengeItems = ChallengeItems
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
        Category(title: "Fitness", ChallengeItems: [
            ChallengeItem(
                title: "Summertime Fine",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            ),
            ChallengeItem(
                title: "Push Up",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            )
        ]),
        Category(title: "Creative", ChallengeItems: [
            ChallengeItem(
                title: "Drawing",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            ),
            ChallengeItem(
                title: "Painting",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            ),
            ChallengeItem(
                title: "Knitting",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            ),
            ChallengeItem(
                title: "Digital Drawing",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            )
        ]),
        Category(title: "Programming", ChallengeItems: [
            ChallengeItem(
                title: "100 Days of SwiftUI",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            ),
            ChallengeItem(
                title: "30 Days of Leetcode",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            )
        ]),
        Category(title: "Other", ChallengeItems: [
            ChallengeItem(
                title: "100 Days of FIRE",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            ),
            ChallengeItem(
                title: "30 Days without Boba",
                thumbnail: "arkit"
                //        lessonCount: 37,
                //        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
            )
        ])
    ]
}
