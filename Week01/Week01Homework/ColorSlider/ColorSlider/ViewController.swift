//
//  ViewController.swift
//  ColorSlider
//
//  Created by cynber on 5/28/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var firstValueLabel: UILabel!
    @IBOutlet weak var secondValueLabel: UILabel!
    @IBOutlet weak var thirdValueLabel: UILabel!
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var thirdTitleLabel: UILabel!
    @IBOutlet weak var firstSlider: UISlider!
    @IBOutlet weak var secondSlider: UISlider!
    @IBOutlet weak var thirdSlider: UISlider!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var previewView: UIView!
    
    var segmentIndex: Int {
        return segmentControl.selectedSegmentIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewView.layer.borderWidth = 5.0
        reset()
    }
    
    @IBAction func reset() {
        colorNameLabel.text = "Color Name"
        colorNameLabel.textColor = .white
        resetSlider(firstSlider, firstValueLabel)
        resetSlider(secondSlider, secondValueLabel)
        resetSlider(thirdSlider, thirdValueLabel)
        previewView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)
        backgroundView.backgroundColor = .black
    }
    
    func resetSlider(_ colorSlider: UISlider, _ colorLabel: UILabel) {
        colorSlider.value = 0
        colorLabel.text = "0"
    }
    
    @IBAction func sliderMoved(_ sender: AnyObject) {
        updateColor(previewView)
    }
    
    @IBAction func setColor() {
        let alertVC = UIAlertController(title: "Set Color", message: "Please Enter a Color Name", preferredStyle: .alert)
        alertVC.addTextField { textField in
            textField.text = ""
            textField.placeholder = "i.e. Blue"
        }
        let action = UIAlertAction(title: "Enter", style: .default) { alert in
            let textField = alertVC.textFields![0]
            self.updateColor(with: textField.text ?? "Color Name", self.backgroundView)
        }
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    
    func updateColor(with name: String = "Set Color", _ colorView: UIView) {
        let valueOne = firstSlider.value.rounded()
        let valueTwo = secondSlider.value.rounded()
        let valueThree = thirdSlider.value.rounded()
        let nameColor: UIColor
        let bgColor: UIColor
        
        if segmentIndex == 0 {
            nameColor = UIColor(red: CGFloat((255 - valueOne)/255.0), green: CGFloat((255 - valueTwo)/255.0), blue: CGFloat((255 - valueThree)/255.0), alpha: 1.0)
            bgColor = UIColor(red: CGFloat(valueOne/255.0), green: CGFloat(valueTwo/255.0), blue: CGFloat(valueThree/255.0), alpha: 1.0)
        } else {
            bgColor = UIColor(hue: CGFloat(valueOne/360), saturation: CGFloat(valueTwo/100), brightness: CGFloat(valueThree/100), alpha: 1.0)
            nameColor = CGFloat((100 - valueThree)/100) > 0.5 ? .white : .black
        }
        
        firstValueLabel.text = String(Int(valueOne))
        secondValueLabel.text = String(Int(valueTwo))
        thirdValueLabel.text = String(Int(valueThree))
        
        if colorView == backgroundView {
            colorNameLabel.text = name
            colorNameLabel.textColor = nameColor
            colorView.backgroundColor = bgColor
        } else {
            colorView.layer.borderColor = bgColor.cgColor
        }
    }
    
    @IBAction func modeChanged(_ sender: Any) {
        if segmentIndex == 0 {
            setTitleLabels("Red", "Green", "Blue")
            setSliderMaximum(255.0, 255.0, 255.0)
        } else {
            setTitleLabels("Hue", "Saturation", "Brightness")
            setSliderMaximum(360.0, 100.0, 100.0)
        }
        reset()
    }
    
    func setSliderMaximum(_ firstMax: Float, _ secondMax: Float, _ thirdMax: Float) {
        firstSlider.maximumValue = firstMax
        secondSlider.maximumValue = secondMax
        thirdSlider.maximumValue = thirdMax
    }
    
    func setTitleLabels(_ firstLabel: String, _ secondLabel: String, _ thirdLabel: String) {
        firstTitleLabel.text = firstLabel
        secondTitleLabel.text = secondLabel
        thirdTitleLabel.text = thirdLabel
    }
}
