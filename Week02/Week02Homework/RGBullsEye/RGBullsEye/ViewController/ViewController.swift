/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var targetTextLabel: UILabel!
  @IBOutlet weak var guessLabel: UILabel!
  
  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var blueLabel: UILabel!
  
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
  
  @IBOutlet weak var roundLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  
  let game = BullsEyeGame()
  var rgb = RGB()
  
  @IBAction func aSliderMoved(sender: UISlider) {
    let redValue = Int(redSlider.value.rounded())
    let greenValue = Int(greenSlider.value.rounded())
    let blueValue = Int(blueSlider.value.rounded())
        
    redLabel.text = "R: \(redValue)"
    greenLabel.text = "G: \(greenValue)"
    blueLabel.text = "B: \(blueValue)"
    game.setCurrentValue(with: RGB(r: redValue, g: greenValue, b: blueValue))
    guessLabel.backgroundColor = UIColor(rgbStruct: game.currentValue)
 }
  
  @IBAction func showAlert(sender: AnyObject) {
    let (title, message) = game.updateScore()

    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

    let action = UIAlertAction(title: "OK", style: .default, handler: {
    action in
      self.game.startNewRound()
      self.targetTextLabel.text = "Match another color!"
      self.updateView()
    })

    alert.addAction(action)

    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func startOver(sender: AnyObject) {
    game.startNewGame()
    updateView()
  }
  
  func updateView() {
    redSlider.value = Float(game.currentValue.r)
    greenSlider.value = Float(game.currentValue.g)
    blueSlider.value = Float(game.currentValue.b)
    
    redLabel.text = String(Int(redSlider.value))
    blueLabel.text = String(Int(blueSlider.value))
    greenLabel.text = String(Int(greenSlider.value))
    
    guessLabel.backgroundColor = UIColor(rgbStruct: game.currentValue)
    targetLabel.backgroundColor = UIColor(rgbStruct: game.targetValue)
    
    roundLabel.text = String(game.round)
    scoreLabel.text = String(game.score)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    game.startNewGame()
    updateView()
  }
}

