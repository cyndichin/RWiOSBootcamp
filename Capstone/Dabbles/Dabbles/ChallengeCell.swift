//
//  ChallengeItemCell.swift
//  Dabbles
//
//  Created by cynber on 7/23/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import Foundation
import UIKit
//
//class ChallengeItemCell: UICollectionViewCell {
//    static let reuseIdentifer = "challengeItemCellId"
//    let title: UILabel
//    let thumbnail: UIImageView
//    let contentContainer: UIView
//
//}

//  var title: String? {
//    didSet {
//      configure()
//    }
//  }
//
//  var featuredPhotoURL: URL? {
//    didSet {
//      configure()
//    }
//  }
//
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//    configure()
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//}
//
//extension ChallengeItemCell {
//  func configure() {
//    contentContainer.translatesAutoresizingMaskIntoConstraints = false
//
//    contentView.addSubview(challengePhotoView)
//    contentView.addSubview(contentContainer)
//
//    challengePhotoView.translatesAutoresizingMaskIntoConstraints = false
//    if let featuredPhotoURL = featuredPhotoURL {
//      challengePhotoView.image = UIImage(contentsOfFile: featuredPhotoURL.path)
//    }
//    challengePhotoView.clipsToBounds = true
//    contentContainer.addSubview(challengePhotoView)
//
//    titleLabel.translatesAutoresizingMaskIntoConstraints = false
//    titleLabel.text = title
//    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
//    titleLabel.adjustsFontForContentSizeCategory = true
//    titleLabel.textColor = .white
//    titleLabel.textAlignment = .center
//    titleLabel.layer.shadowColor = UIColor.black.cgColor
//    titleLabel.layer.shadowRadius = 3.0
//    titleLabel.layer.shadowOpacity = 1.0
//    titleLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
//    titleLabel.layer.masksToBounds = false
//    contentContainer.addSubview(titleLabel)
//
//    NSLayoutConstraint.activate([
//      contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//      contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//      contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
//      contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//
//      challengePhotoView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
//      challengePhotoView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
//      challengePhotoView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
//      challengePhotoView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
//
//      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//    ])
//  }
//}
