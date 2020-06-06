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
    
    let game = BullsEyeGame()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        game.startNewGame()
        slider.value = Float(game.targetValue)
        slider.isUserInteractionEnabled = false
        hitMeButton.isUserInteractionEnabled = false
        guessTextField.delegate = self
        guessTextField.addTarget(self, action: #selector(self.editingChanged), for: .editingChanged)
        
    }
    
    @IBAction func showAlert() {
        game.updateScore()
        let title = game.title
        
        let message = """
        Guess: \(guessTextField.text ?? "")
        Slider Value: \(slider.value)
        You scored \(game.points) points
        """
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.game.startNewRound()
        })
        
        alertVC.addAction(action)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if (textField.text!.count >= 100
            && !string.isEmpty) {
            return false
        }
        let invalidCharacters
            = CharacterSet(charactersIn: "0123456789").inverted
        return (string.rangeOfCharacter(from: invalidCharacters) == nil) }
    
    private var lastValue = ""
    @objc private func editingChanged(_ textField: UITextField) {
        let guess = guessTextField.text
        if let guess = guess {
            guessTextField.text = "\(guess)"
            hitMeButton.isUserInteractionEnabled = true

        } else {
            guessTextField.text = ""
        }
    }


}

