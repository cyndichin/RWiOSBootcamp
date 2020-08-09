//
//  ViewController.swift
//  AnimationsHomeworl
//
//  Created by cynber on 8/9/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var animateObject: UIImageView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var centerButton: UIButton!
    private var isSettingAnimations = false
    private var isTopTapped = false
    private var isLeftTapped = false
    private var isRightTapped = false
    override func viewDidLoad() {
        super.viewDidLoad()
        animateObject.alpha = 0
         hideSetting(with: leftButton)
                    hideSetting(with: rightButton)
                    hideSetting(with: topButton)
    }
    
    @IBAction func playTapped(_ sender: Any) {
        isSettingAnimations.toggle()
        
        if isSettingAnimations {
            // show settings
            showSetting(with: leftButton, and: -(self.centerButton.frame.width + 20), false)
            showSetting(with: rightButton, and: self.centerButton.frame.width + 20, false)
            showSetting(with: topButton, and: self.centerButton.frame.height + 20, true)

//            showItem()
        } else {
            hideSetting(with: leftButton)
            hideSetting(with: rightButton)
            hideSetting(with: topButton)
            // hides and play settings
//            if isLeftTapped {
//               showDragon()
//            }
//            
//            if isTopTapped {
//               upAndDown()
//            }
//            
//            if isRightTapped {
//               glowRed()
//            }
            
        }
    }
    @IBAction func rightTapped(_ sender: Any) {
        isRightTapped = true
    }
    
    @IBAction func leftTapped(_ sender: Any) {
        isLeftTapped = true
    }
    
    @IBAction func topTapped(_ sender: Any) {
        isTopTapped = true
    }
    
    func showDragon() {
        UIView.animate(
            withDuration: 1, delay: 0,
            options: .curveEaseOut,
            animations: { self.animateObject.alpha = 1 }
        )
    }
    
    func upAndDown() {
        UIView.animate(
            withDuration: 1,
            animations: { self.animateObject.frame.origin.y -= 50
                
        }){_ in
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.autoreverse, .repeat], animations: { self.animateObject.frame.origin.y += 50
                
            })
        }
    }
    
    func glowRed() {
        UIView.animate(
                   withDuration: 1, delay: 0,
                   options: .curveEaseOut,
                   animations: { self.animateObject.layer.shadowColor = UIColor.red.cgColor
                    self.animateObject.layer.shadowRadius = 20
        }
               )
    }
    
    func depart() {
        let originalCenter = animateObject.center
        UIView.animateKeyframes(
            withDuration: 1.5, delay: 0,
            animations: { [animateObject = self.animateObject!] in
                // Move animateObject right & up
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                    animateObject.center.x += 80
                    animateObject.center.y -= 10
                }
                
                // Rotate animateObject
                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4) {
                    animateObject.transform = .init(rotationAngle: -.pi / 8)
                }
                
                // Move animateObject right and up off screen, while fading out
                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                    animateObject.center.x += 100
                    animateObject.center.y -= 50
                    animateObject.alpha = 0
                }
                
                // Move animateObject just off left side, reset transform and height
                UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01) {
                    animateObject.transform = .identity
                    animateObject.center = .init(x: 0, y: originalCenter.y)
                }
                
                //          // Move animateObject back to original position & fade in
                //          UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45) {
                //            animateObject.alpha = 1
                //            animateObject.center = originalCenter
                //          }
            }
        )
    }
    
//    func showSettings() {
//        UIView.animate(
//            withDuration: 1,
//            animations: { self.animateObject.frame.origin.y -= 50
//
//        }){_ in
//            UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.autoreverse, .repeat], animations: { self.animateObject.frame.origin.y += 50
//
//            })
//        }
//    }
    
    func showSetting(with settingView: UIButton, and distance: CGFloat, _ isTop: Bool) {
            settingView.translatesAutoresizingMaskIntoConstraints = false
          let widthConstraint =  settingView.centerXAnchor.constraint(equalTo: centerButton.centerXAnchor, constant: 0)
        
          let topConstraint =  settingView.topAnchor.constraint(equalTo: centerButton.topAnchor, constant: 0)
          
          NSLayoutConstraint.activate([
            settingView.bottomAnchor.constraint(
            equalTo: centerButton.bottomAnchor),
            topConstraint,
            widthConstraint,
            settingView.heightAnchor.constraint(equalToConstant: 64.0),
            settingView.widthAnchor.constraint(equalTo: settingView.heightAnchor),
          ])

          view.layoutIfNeeded()

        UIView.animate(
            withDuration: 0.8, delay: 0,
            usingSpringWithDamping: 0.6, initialSpringVelocity: 10,
            animations: {
                if isTop {
                    topConstraint.constant = distance
                } else {
                    widthConstraint.constant = distance
                }
              self.view.layoutIfNeeded()
            }
          )
        }
    
    
    
    func hideSetting(with settingView: UIButton) {
        settingView.translatesAutoresizingMaskIntoConstraints = false
         let widthConstraint =  settingView.centerXAnchor.constraint(equalTo: centerButton.centerXAnchor, constant: 0)
              
                let topConstraint =  settingView.topAnchor.constraint(equalTo: centerButton.topAnchor, constant: 0)
                
                NSLayoutConstraint.activate([
                  settingView.bottomAnchor.constraint(
                  equalTo: centerButton.bottomAnchor),
                  topConstraint,
                  widthConstraint,
                  settingView.heightAnchor.constraint(equalToConstant: 64.0),
                  settingView.widthAnchor.constraint(equalTo: settingView.heightAnchor),
                ])
        
        UIView.animate(
          withDuration: 0.8, delay: 0,
          usingSpringWithDamping: 0.6, initialSpringVelocity: 10,
          animations: {
            self.view.layoutIfNeeded()
          }
        )
    }
    private func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
      DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
    }

    
}

