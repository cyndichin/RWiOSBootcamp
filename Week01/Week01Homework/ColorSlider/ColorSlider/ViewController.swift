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
    
    var sliderValues: (Float, Float, Float) {
        return (firstSlider.value.rounded(), secondSlider.value.rounded(), thirdSlider.value.rounded())
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
        setAllSlidersColor()
        previewView.layer.borderColor = UIColor.black.cgColor
        backgroundView.backgroundColor = .black
    }
    
    func resetSlider(_ colorSlider: UISlider, _ colorLabel: UILabel) {
        colorSlider.value = 0
        colorLabel.text = "0"
    }
    
    @IBAction func sliderMoved(_ sender: AnyObject) {
        setAllSlidersColor()
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
        let bgColor: UIColor
        
        if segmentIndex == 0 {
            bgColor = UIColor(red: CGFloat(sliderValues.0/255.0), green: CGFloat(sliderValues.1/255.0), blue: CGFloat(sliderValues.2/255.0), alpha: 1.0)
        } else {
            bgColor = UIColor(hue: CGFloat(sliderValues.0/360.0), saturation: CGFloat(sliderValues.1/100.0), brightness: CGFloat(sliderValues.2/100.0), alpha: 1.0)
        }

        firstValueLabel.text = String(Int(sliderValues.0))
        secondValueLabel.text = String(Int(sliderValues.1))
        thirdValueLabel.text = String(Int(sliderValues.2))
        
        if colorView == backgroundView {
            colorNameLabel.text = name
            colorNameLabel.textColor = contrastColor(color: bgColor)
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
    
    func setAllSlidersColor() {
        setSliderColor(slider: firstSlider)
        setSliderColor(slider: secondSlider)
        setSliderColor(slider: thirdSlider)
    }
    
    func contrastColor(color: UIColor) -> UIColor {
        var d = CGFloat(0)
        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)

        color.getRed(&r, green: &g, blue: &b, alpha: &a)

        // Counting the perceptive luminance - human eye favors green color...
        let luminance = 1 - ((0.299 * r) + (0.587 * g) + (0.114 * b))
        d = luminance < 0.5 ? CGFloat(0) : CGFloat(1)
        return UIColor(red: d, green: d, blue: d, alpha: a)
     }
    
    func setSliderColor(slider: UISlider) {
        let tgl = CAGradientLayer()
        let frame = CGRect.init(x:0, y:0, width:slider.frame.size.width, height:5)
        tgl.frame = frame
        
        let rgb = (CGFloat(sliderValues.0/255.0), CGFloat(sliderValues.1/255.0), CGFloat(sliderValues.2/255.0))
        
        let hsb = (CGFloat(sliderValues.0/360.0), CGFloat(sliderValues.1/100.0), CGFloat(sliderValues.2/100.0))
        
        let buttonColor = UIColor(red: rgb.0, green: rgb.1, blue: rgb.2, alpha: 1.0)
        let otherbuttonColor = UIColor(hue: hsb.0, saturation: hsb.1, brightness: hsb.2, alpha: 1.0)

        slider.thumbImage(for: .normal)
        slider.thumbTintColor = segmentIndex == 0 ? buttonColor : otherbuttonColor
        
        switch slider {
        case firstSlider:
            let hueColor0 = updateHSB(0, hsb.1, hsb.2)
            let hueColor1 = updateHSB(60/360.0, hsb.1, hsb.2)
            let hueColor2 = updateHSB(120/360.0, hsb.1, hsb.2)
            let hueColor3 = updateHSB(180/360.0, hsb.1, hsb.2)
            let hueColor4 = updateHSB(240/360.0, hsb.1, hsb.2)
            let hueColor5 = updateHSB(300/360.0, hsb.1, hsb.2)
            let hueColor6 = updateHSB(1, hsb.1, hsb.2)
            
            tgl.colors = segmentIndex == 0 ? [updateRGB(0, rgb.1, rgb.2), updateRGB(1, rgb.1, rgb.2)] : [hueColor0, hueColor1, hueColor2, hueColor3,hueColor4, hueColor5, hueColor6]
        case secondSlider:
            tgl.colors = segmentIndex == 0 ? [updateRGB(rgb.0, 0, rgb.2), updateRGB(rgb.0, 1, rgb.2)] : [updateHSB(hsb.0, 0, hsb.2), updateHSB(hsb.0, 1, hsb.2)]
        case thirdSlider:
            tgl.colors = segmentIndex == 0 ? [updateRGB(rgb.0, rgb.1, 0), updateRGB(rgb.0, rgb.1, 1)] : [updateHSB(hsb.0, hsb.1, 0), updateHSB(hsb.0, hsb.1, 1)]
        default:
            break
        }
        
        tgl.startPoint = CGPoint.init(x:0.0, y:0.5)
        tgl.endPoint = CGPoint.init(x:1.0, y:0.5)

        UIGraphicsBeginImageContextWithOptions(tgl.frame.size, tgl.isOpaque, 0.0);
        tgl.render(in: UIGraphicsGetCurrentContext()!)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()

            image.resizableImage(withCapInsets: UIEdgeInsets.zero)

            slider.setMinimumTrackImage(image, for: .normal)
            slider.setMaximumTrackImage(image, for: .normal)
        }
    }
    
    func updateRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> CGColor {
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor
    }
    
    func updateHSB(_ hue: CGFloat, _ saturation: CGFloat, _ brightness: CGFloat) -> CGColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0).cgColor
    }
}

