//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var compatibilityItemLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var questionLabel: UILabel!

    var compatibilityItems = ["Cats", "Dogs"] // Add more!
    var currentItemIndex = 0

    var person1 = Person(id: 1, items: [:])
    var person2 = Person(id: 2, items: [:])
    var currentPerson: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        person1.setupObjects(with: compatibilityItems)
        person2.setupObjects(with: compatibilityItems)
        resetGame()
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
        print(sender.value.rounded())
    }

    @IBAction func didPressNextItemButton(_ sender: Any) {
        let score = slider.value.rounded()
        let currentItem = compatibilityItems[currentItemIndex]
        currentPerson?.items.updateValue(score, forKey: currentItem)
        currentItemIndex += 1
        if let itemCount = currentPerson?.items.count, currentItemIndex >= itemCount {
            guard currentPerson?.id != person2.id else {
                print("No more people")
                let results = calculateCompatibility()
                showAlert(with: results)
                return
            }
            currentPerson = person2
            currentItemIndex = 0
        }
        setupLabels()
    }
    
    func setupLabels() {
        guard let id = currentPerson?.id else { return }
        questionLabel.text = "User \(id), how do you feel about..."
        compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
    }
    
    
    func showAlert(with results: String) {
        let alertVC = UIAlertController(title: "Results", message: "You two are \(results) compatible", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.resetGame()
            self.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
    
    func resetGame() {
        currentPerson = person1
        currentItemIndex = 0
        setupLabels()
    }

    func calculateCompatibility() -> String {
        // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
        var percentagesForAllItems: [Double] = []

        for (key, person1Rating) in person1.items {
            let person2Rating = person2.items[key] ?? 0
            let difference = abs(person1Rating - person2Rating)/5.0
            percentagesForAllItems.append(Double(difference))
        }

        let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
        let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
        print(matchPercentage, "%")
        let matchString = 100 - (matchPercentage * 100).rounded()
        return "\(matchString)%"
    }

}

