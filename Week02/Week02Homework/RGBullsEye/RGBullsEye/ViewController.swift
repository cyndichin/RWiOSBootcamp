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

    // shouldn't this be in model?
    var quickDiff: (r: Int, g: Int, b:Int) {
        let redDiff = abs(game.currentValue.r - game.targetValue.r)
        let blueDiff = abs(game.currentValue.b - game.targetValue.b)
        let greenDiff = abs(game.currentValue.g - game.targetValue.g)
        return (redDiff, blueDiff, greenDiff)
    }

    @IBAction func aSliderMoved(sender: UISlider) {
        let redValue = Int(redSlider.value.rounded())
        let greenValue = Int(greenSlider.value.rounded())
        let blueValue = Int(blueSlider.value.rounded())
            
        redLabel.text = "R: \(redValue)"
        greenLabel.text = "G: \(greenValue)"
        blueLabel.text = "B: \(blueValue)"
        game.updateCurrentValue(with: RGB(r: redValue, g: greenValue, b: blueValue))
        guessLabel.backgroundColor = UIColor(rgbStruct: game.currentValue)
        sender.minimumTrackTintColor =  UIColor.blue.withAlphaComponent(CGFloat(quickDiff.r)/100.0)
        greenSlider.minimumTrackTintColor =  UIColor.blue.withAlphaComponent(CGFloat(quickDiff.g)/100.0)
        blueSlider.minimumTrackTintColor =  UIColor.blue.withAlphaComponent(CGFloat(quickDiff.b)/100.0)
    }

    @IBAction func showAlert(sender: AnyObject) {
        game.updateScore()
           
        let title = game.title

        let message = "You scored \(Int(game.points.rounded())) points"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default, handler: {
         action in
           self.game.startNewRound()
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
        roundLabel.text = String(game.round)
        scoreLabel.text = Int(game.score.rounded()).description
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        game.startNewGame()
        updateView()
    }
    
    func updateSlider() {
        redSlider.value = 128
        greenSlider.value = 128
        blueSlider.value = 128
        redSlider.minimumTrackTintColor =  UIColor.blue.withAlphaComponent(CGFloat(quickDiff.r)/100.0)
        greenSlider.minimumTrackTintColor =  UIColor.blue.withAlphaComponent(CGFloat(quickDiff.g)/100.0)
        blueSlider.minimumTrackTintColor =  UIColor.blue.withAlphaComponent(CGFloat(quickDiff.b)/100.0)
        
//        redSlider.minimumTrackTintColor = UIColor.red.withAlphaComponent(CGFloat(quickDiff)/100.0)
//        greenSlider.minimumTrackTintColor = UIColor.green.withAlphaComponent(CGFloat(quickDiff)/100.0)
//        blueSlider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100.0)
    }
}

