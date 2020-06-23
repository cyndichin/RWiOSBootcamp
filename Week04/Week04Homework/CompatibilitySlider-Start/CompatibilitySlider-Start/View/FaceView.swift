//
//  FaceView.swift
//  CompatibilitySlider-Start
//
//  Created by cynber on 6/22/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit

class FaceView: UIImageView {
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        setupTap()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        NotificationCenter.default.post(name: Notification.Name.init("tapOccurred"), object: nil, userInfo: ["tag" : tappedImage.tag as Int])
    }
    
    func setupTap() {
       let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
}
