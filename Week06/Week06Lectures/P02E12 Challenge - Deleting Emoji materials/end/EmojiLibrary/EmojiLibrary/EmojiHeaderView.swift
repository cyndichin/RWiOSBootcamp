//
//  EmojiHeaderView.swift
//  EmojiLibrary
//
//  Created by Pasan Premaratne on 10/23/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit

class EmojiHeaderView: UICollectionReusableView {
  static let reuseIdentifier = String(describing: EmojiHeaderView.self)
  
  @IBOutlet weak var textLabel: UILabel!
}
