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
//    static let reuseIdentifer = "ChallengeItemCellId"
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
//    contentView.addSubview(ChallengeItemPhotoView)
//    contentView.addSubview(contentContainer)
//
//    ChallengeItemPhotoView.translatesAutoresizingMaskIntoConstraints = false
//    if let featuredPhotoURL = featuredPhotoURL {
//      ChallengeItemPhotoView.image = UIImage(contentsOfFile: featuredPhotoURL.path)
//    }
//    ChallengeItemPhotoView.clipsToBounds = true
//    contentContainer.addSubview(ChallengeItemPhotoView)
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
//      ChallengeItemPhotoView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
//      ChallengeItemPhotoView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
//      ChallengeItemPhotoView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
//      ChallengeItemPhotoView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
//
//      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//    ])
//  }
//}
