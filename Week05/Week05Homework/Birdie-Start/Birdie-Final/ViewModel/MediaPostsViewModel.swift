//
//  MediaPostsViewModel.swift
//  Birdie-Final
//
//  Created by cynber on 6/28/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit

class MediaPostsViewModel {
    let post: MediaPost
    
    public init(with post: MediaPost) {
        self.post = post
    }
    
    public var name: String {
      return post.userName
    }
    
    public var timestamp: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, HH:mm"
        return dateFormatter.string(from: post.timestamp)
    }
    
    public var text: String {
        return post.textBody ?? ""
    }
    
    public var image: UIImage? {
        guard let imagePost = post as? ImagePost else { return nil}
        return imagePost.image
    }
}

extension MediaPostsViewModel {
  public func configure(_ cell: MediaPostTableViewCell) {
    cell.nameLabel.text = name
    cell.timestampLabel.text = timestamp
    cell.bodyLabel.text = text
    cell.bodyImageView?.image = image
  }
}
