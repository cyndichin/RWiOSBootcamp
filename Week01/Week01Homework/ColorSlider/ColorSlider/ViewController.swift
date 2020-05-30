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
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var rgbView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let screenHeight = UIScreen.main.bounds.size.height
        let baseScreenHeight = UIScreen.main.bounds.height //Layout is iphone 8 plus and 128(redViewheight) according to this.
        let heightRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        coordinator.animate(alongsideTransition: { context in
            //This function will do the trick
            self.rgbView.translatesAutoresizingMaskIntoConstraints = false
            let orientation = UIDevice.current.orientation
            guard orientation != .portrait else { return }
            self.rgbView.heightAnchor.constraint(equalToConstant: baseScreenHeight * heightRatio).isActive = true
            self.rgbView.widthAnchor.constraint(equalToConstant: baseScreenHeight * heightRatio).isActive = true
           
            self.view.layoutIfNeeded()

        })
    }

    @IBAction func setColor() {
        let alertVC = UIAlertController(title: "Set Color", message: "Please Enter a Color Name", preferredStyle: .alert)
        alertVC.addTextField { textField in
            textField.text = ""
            textField.placeholder = "i.e. Blue"
        }
        let action = UIAlertAction(title: "Enter", style: .default) { alert in
            let textField = alertVC.textFields![0]
            self.updateColorName(with: textField.text ?? "Color Name")
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
    
//    @IBAction func sliderMoved(_ slider: UISlider) {
//        redValueLabel.text = String(Int(redSlider.value))
//        greenValueLabel.text = String(Int(greenSlider.value))
//        blueValueLabel.text = String(Int(blueSlider.value))
//    }
    
    @IBAction func changeColor(_ sender: AnyObject) {
        let red = redSlider.value
        let green = greenSlider.value
        let blue = blueSlider.value
        colorNameLabel.textColor = UIColor(red: CGFloat((255 - red)/255), green: CGFloat((255 - green)/255), blue: CGFloat((255 - blue)/255), alpha: 1.0)
        redValueLabel.text = String(Int(red))
        greenValueLabel.text = String(Int(green))
        blueValueLabel.text = String(Int(blue))
        print("Red \(red) Green \(green) Blue \(blue)")
        print("Red \(CGFloat(red)) Green \(CGFloat(green)) Blue \(CGFloat(blue))")
        backgroundView.backgroundColor = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
    }
    
    func updateColorName(with name: String) {
        colorNameLabel.text = name
    }
}

