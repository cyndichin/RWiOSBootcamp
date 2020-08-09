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
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    
    private var isSettingAnimations = false
    var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateObject.alpha = 0
        view.bringSubviewToFront(centerButton)
        animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut)
    }
    
    @IBAction func playTapped(_ sender: Any) {
        isSettingAnimations.toggle()
        
        if isSettingAnimations {
            showSetting(with: topButton, and: (x: 0, y: -(self.centerButton.frame.height + 20)))
            showSetting(with: leftButton, and: (x: -(self.centerButton.frame.width + 20), y: 0))
            showSetting(with: rightButton, and: (x: self.centerButton.frame.width + 20, y: 0))
        } else {
            hideSettings()
            animator.startAnimation()
        }
    }
    @IBAction func rightTapped(_ sender: Any) {
        animator.addAnimations {
            UIView.animate(
                withDuration: 1, delay: 0,
                options: .curveEaseOut,
                animations: { self.animateObject.layer.shadowColor = UIColor.red.cgColor
                    self.animateObject.layer.shadowRadius = 5
                    self.animateObject.layer.shadowOpacity = 1
            }
            )
        }
    }
    
    @IBAction func leftTapped(_ sender: Any) {
        animator.addAnimations {
            self.animateObject.alpha = 1
        }
    }
    
    @IBAction func topTapped(_ sender: Any) {
        animator.addAnimations {
            UIView.animate(
                withDuration: 1,
                animations: { self.animateObject.frame.origin.y -= 50
                    
            }){_ in
                UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.autoreverse, .repeat], animations: { self.animateObject.frame.origin.y += 50
                    
                })
            }
        }
    }
    
    func showSetting(with settingView: UIButton, and distance: (x: CGFloat, y: CGFloat)) {
        UIView.animate(
            withDuration: 0.5, delay: 0,
            options: .allowUserInteraction,
            animations: {
                settingView.transform = .init(translationX: distance.x, y: distance.y)
                self.view.layoutIfNeeded()
        }
        )
    }
    
    
    func hideSettings() {
        UIView.animate(
            withDuration: 0.5, delay: 0,
            options: .allowUserInteraction,
            animations: {
                self.topButton.transform = .init(translationX: 0, y: 0)
                self.rightButton.transform = .init(translationX: 0, y: 0)
                self.leftButton.transform = .init(translationX: 0, y: 0)
                self.view.layoutIfNeeded()
        }
        )
    }
}

