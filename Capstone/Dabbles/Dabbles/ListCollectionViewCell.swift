//
//  ListCollectionViewCell.swift
//  Dabbles
//
//  Created by cynber on 8/5/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: ListCollectionViewCell.self)
    
    @IBOutlet weak var challengeItemTitleLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func calendarTapped(_ sender: Any) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
