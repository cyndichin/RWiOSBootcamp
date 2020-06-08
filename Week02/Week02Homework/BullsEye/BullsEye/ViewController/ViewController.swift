//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!

  let game = BullsEyeGame()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    let roundedValue = slider.value.rounded()
    game.setCurrentValue(with: Int(roundedValue))
    game.startNewGame()
    slider.minimumTrackTintColor =
        UIColor.blue.withAlphaComponent(CGFloat(game.difference)/100.0)
    updateViews()
  }

  @IBAction func showAlert() {
    let (title, message) = game.updateScore()
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default, handler: {
      action in
        self.game.startNewRound()
        self.updateViews()
    })
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func sliderMoved(_ slider: UISlider) {
    let roundedValue = slider.value.rounded()
    game.setCurrentValue(with: Int(roundedValue))
    slider.minimumTrackTintColor =
    UIColor.blue.withAlphaComponent(CGFloat(game.difference)/100.0)
  }

  func updateViews() {
    slider.value = Float(game.currentValue)
    slider.minimumTrackTintColor =
    UIColor.blue.withAlphaComponent(CGFloat(game.difference)/100.0)
    
    targetLabel.text = String(game.targetValue)
    scoreLabel.text = String(game.score)
    roundLabel.text = String(game.round)
  }
  
  @IBAction func startNewGame() {
    game.startNewGame()
    updateViews()
  }
}



