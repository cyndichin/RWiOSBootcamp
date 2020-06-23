//
//  CompatibilityModel.swift
//  CompatibilitySlider-Start
//
//  Created by cynber on 6/22/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class CompatibilityModel {
    var person1 = Person(id: 1, items: [:])
    var person2 = Person(id: 2, items: [:])
    var currentPerson: Person?
    var compatibilityItems: [String] = []
    var currentItemIndex = 0
    
    var currentItem: String {
        return compatibilityItems[currentItemIndex]
    }
    
    init(items: [String]) {
        self.compatibilityItems = items
        self.person1.setupObjects(with: compatibilityItems)
        self.person2.setupObjects(with: compatibilityItems)
    }
    
    func resetGame() {
       currentPerson = person1
       currentItemIndex = 0
    }

    func calculateCompatibility() -> String {
         // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
         var percentagesForAllItems: [Double] = []

         for (key, person1Rating) in person1.items {
             let person2Rating = person2.items[key] ?? 0
             let difference = abs(person1Rating - person2Rating)/4.0
             percentagesForAllItems.append(Double(difference))
         }

         let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
         let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
         let matchString = 100 - (matchPercentage * 100).rounded()
         return "\(matchString)%"
     }

}
