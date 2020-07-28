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
  let title: String
  let thumbnail: String
//  let imageItems: [ChallengeDetailItem]

  init(challengeTitle: String, challengeImage: String) {
    self.title = challengeTitle
    self.thumbnail = challengeImage
//    self.imageItems = imageItems
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }

  static func == (lhs: ChallengeItem, rhs: ChallengeItem) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  private let identifier = UUID()
}

