//
//  ViewController.swift
//  RevBullsEye
//
//  Created by cynber on 6/5/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var hitMeButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    let game = BullsEyeGame()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        game.startNewGame()
        slider.isUserInteractionEnabled = false
        hitMeButton.isUserInteractionEnabled = false
        guessTextField.delegate = self
        guessTextField.addTarget(self, action: #selector(self.textFieldFilter), for: .editingChanged)
        updateView()
    }
    
    @IBAction func showAlert() {
        game.updateScore()
        let title = game.title
        let guess = guessTextField.text ?? ""
    
        let message = """
        Guess: \(guess)
        Slider Value: \(slider.value)
        You scored \(game.points) points
        """
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.game.startNewRound()
            self.updateView()
        })
        
        alertVC.addAction(action)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let text = guessTextField.text else { return false }
        let inputStr = text + string
        if (text.count >= 3 && !string.isEmpty) {
            return false
        } else if let inputInt = Int(inputStr), !(inputInt >= 0 && inputInt <= 100) {
            return false
        }

        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return (string.rangeOfCharacter(from: invalidCharacters) == nil)
    }
    
    @objc private func textFieldFilter(_ textField: UITextField) {
      if let text = guessTextField.text, let intText = Int(text) {
        textField.text = "\(intText)"
        hitMeButton.isUserInteractionEnabled = true
      } else {
        textField.text = ""
      }
    }
    
    func updateView() {
        scoreLabel.text = game.score.description
        roundLabel.text = game.round.description
        slider.value = Float(game.targetValue)
    }
    
    
    @IBAction func reset() {
        game.startNewGame()
    }
}

