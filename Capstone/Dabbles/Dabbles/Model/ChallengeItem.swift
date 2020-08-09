//
//  ChallengeItem.swift
//  Dabbles
//
//  Created by cynber on 7/23/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import Foundation
import UIKit

class ChallengeItem: Hashable, Decodable {
    private let identifier = UUID()
    let title: String
    let thumbnail: String?
    //  let imageItems: [ChallengeItemDetailItem]
    
    init(title: String, thumbnail: String) {
        self.title = title
        self.thumbnail = thumbnail
        //    self.imageItems = imageItems
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: ChallengeItem, rhs: ChallengeItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

