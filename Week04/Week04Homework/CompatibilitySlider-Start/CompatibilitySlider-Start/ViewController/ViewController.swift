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
    
    var compatibilityModel = CompatibilityModel(items: ["Cats", "Dogs"])

    override func viewDidLoad() {
        super.viewDidLoad()
        compatibilityModel.resetGame()
        setupLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      registerForTap()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      unregisterForTap()
    }
    
    func registerForTap() {
      NotificationCenter.default.addObserver(self, selector: #selector(setSlider), name: Notification.Name.init("tapOccurred"), object: nil)
    }
    
    func unregisterForTap() {
      NotificationCenter.default.removeObserver(self)
    }
    
    @objc func setSlider(notification: NSNotification) {
        if let tag = notification.userInfo?["tag"] as? Int {
            slider.value = Float(tag)
        }
    }
    
    @IBAction func didPressNextItemButton(_ sender: Any) {
        let score = slider.value.rounded()
        let currentItem =  compatibilityModel.currentItem
        let person = compatibilityModel.currentPerson
        person?.items.updateValue(score, forKey: currentItem)
        compatibilityModel.currentItemIndex += 1
        if let itemCount = person?.items.count, compatibilityModel.currentItemIndex >= itemCount {
            guard person?.id != compatibilityModel.person2.id else {
                let results = compatibilityModel.calculateCompatibility()
                showAlert(with: results)
                return
            }
            
            compatibilityModel.currentPerson = compatibilityModel.person2
            compatibilityModel.currentItemIndex = 0
        }
        setupLabels()
    }
    
    func setupLabels() {
        guard let id = compatibilityModel.currentPerson?.id else { return }
        questionLabel.text = "User \(id), how do you feel about..."
        compatibilityItemLabel.text = compatibilityModel.currentItem
    }
    
    func showAlert(with results: String) {
        let alertVC = UIAlertController(title: "Results", message: "You two are \(results) compatible", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.compatibilityModel.resetGame()
            self.setupLabels()
            self.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
}

