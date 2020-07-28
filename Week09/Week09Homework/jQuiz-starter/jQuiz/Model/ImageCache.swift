//
//  ImageCache.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/19/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

extension UIImageView {
    public static var imageStore: [String: UIImageView] = [:]
    public class func retrieveImage(_ imageData: Data) ->
        UIImageView {
            let key = "\(imageData.description)"
            if let imageView = imageStore[key] {
                return imageView
            }
            
            let image = UIImage(data: imageData)
            let imageView = UIImageView(image: image)
            imageStore[key] = imageView
            return imageView
    }
}
