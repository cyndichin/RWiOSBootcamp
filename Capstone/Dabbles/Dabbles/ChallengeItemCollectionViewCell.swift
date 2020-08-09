//
//  ChallengeItemCollectionViewCell.swift
//  Dabbles
//
//  Created by cynber on 7/24/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import UIKit

class ChallengeItemCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: ChallengeItemCollectionViewCell.self)
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var imageView: UIImageView?
    
    var ChallengeItem: ChallengeItem? {
      didSet {
//        imageView.image = UIImage(named: s)
//        print(titleLabel)
//        print(ChallengeItem?.title)
        guard let ChallengeItem = ChallengeItem else { return }
        titleLabel?.text = ChallengeItem.title
//        subtitleLabel.text = "\(video?.lessonCount ?? 0) lessons"
      }
    }
}
