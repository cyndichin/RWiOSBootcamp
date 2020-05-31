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
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var thirdTitleLabel: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var segmentIndex: Int {
        return segmentControl.selectedSegmentIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func setColor() {
        let alertVC = UIAlertController(title: "Set Color", message: "Please Enter a Color Name", preferredStyle: .alert)
        alertVC.addTextField { textField in
            textField.text = ""
            textField.placeholder = "i.e. Blue"
        }
        let action = UIAlertAction(title: "Enter", style: .default) { alert in
            let textField = alertVC.textFields![0]
            self.updateColor(with: textField.text ?? "Color Name")
        }
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func reset() {
        colorNameLabel.text = "Color Name"
        colorNameLabel.textColor = .white
        resetSlider(redSlider, redValueLabel)
        resetSlider(greenSlider, greenValueLabel)
        resetSlider(blueSlider, blueValueLabel)
        backgroundView.backgroundColor = .black
    }
    
    func resetSlider(_ colorSlider: UISlider, _ colorLabel: UILabel) {
        colorSlider.value = 0
        colorLabel.text = "0"
    }
    
    @IBAction func sliderMoved(_ sender: AnyObject) {
        let red = redSlider.value.rounded()
        let green = greenSlider.value.rounded()
        let blue = blueSlider.value.rounded()
        let previewColor: UIColor
        if segmentIndex == 0 {
            previewColor = UIColor(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: 1.0)
        } else {
            previewColor = UIColor(hue: CGFloat(red/360.0), saturation: CGFloat(green/100.0), brightness: CGFloat(blue/100.0), alpha: 1.0)
        }
        redValueLabel.text = String(Int(red))
        greenValueLabel.text = String(Int(green))
        blueValueLabel.text = String(Int(blue))
        previewView.backgroundColor = previewColor
    }
    
    func updateColor(with name: String) {
        colorNameLabel.text = name
        let red = redSlider.value.rounded()
        let green = greenSlider.value.rounded()
        let blue = blueSlider.value.rounded()
        let nameColor: UIColor
        let bgColor: UIColor
        if segmentIndex == 0 {
            nameColor = UIColor(red: CGFloat((255 - red)/255), green: CGFloat((255 - green)/255), blue: CGFloat((255 - blue)/255), alpha: 1.0)
            bgColor = UIColor(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: 1.0)
        } else {
            nameColor = UIColor(hue: CGFloat((360 - red)/360), saturation: CGFloat((100 - green)/100), brightness: CGFloat((100 - blue)/100), alpha: 1.0)
            bgColor = UIColor(hue: CGFloat(red/360.0), saturation: CGFloat(green/100.0), brightness: CGFloat(blue/100.0), alpha: 1.0)
        }
        colorNameLabel.textColor = nameColor
        backgroundView.backgroundColor = bgColor
    }
    
    @IBAction func modeChanged(_ sender: Any) {
        let index = segmentControl.selectedSegmentIndex
        if index == 0 {
            setTitleLabels("Red", "Green", "Blue")
            setSliderMaximum(255.0, 255.0, 255.0)
        } else if index == 1 {
            setTitleLabels("Hue", "Saturation", "Brightness")
            setSliderMaximum(360.0, 100.0, 100.0)
        }
        reset()
    }
    
    func setSliderMaximum(_ firstMax: Float, _ secondMax: Float, _ thirdMax: Float) {
        redSlider.maximumValue = firstMax
        greenSlider.maximumValue = secondMax
        blueSlider.maximumValue = thirdMax
    }
    
    func setTitleLabels(_ firstLabel: String, _ secondLabel: String, _ thirdLabel: String) {
        firstTitleLabel.text = firstLabel
        secondTitleLabel.text = secondLabel
        thirdTitleLabel.text = thirdLabel
    }
}

