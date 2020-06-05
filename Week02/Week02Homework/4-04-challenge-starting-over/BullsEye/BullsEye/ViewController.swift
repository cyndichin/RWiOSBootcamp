//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  let game = BullsEyeGame()
    
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    let roundedValue = slider.value.rounded()
    game.updateCurrentValue(with: Int(roundedValue))
    game.startNewGame()
    updateViews()
  }

  @IBAction func showAlert() {
    game.updateScore()
    
    let title = game.title
    
    let message = "You scored \(game.points) points"
    
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
    game.updateCurrentValue(with: Int(roundedValue))
  }

  func updateViews() {
    slider.value = Float(game.currentValue)
    targetLabel.text = String(game.targetValue)
    scoreLabel.text = String(game.score)
    roundLabel.text = String(game.round)
  }
  
  @IBAction func startNewGame() {
    game.startNewGame()
    updateViews()
  }
}



