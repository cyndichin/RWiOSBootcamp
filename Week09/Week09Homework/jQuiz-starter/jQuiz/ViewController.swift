//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!

    var clues: [Clue] = []
    var correctAnswerClue: Clue?
    var points: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemPurple
        Networking.sharedInstance.downloadImage(completion: { (data, error) in
            guard let data = data else {
                return
            }
            self.logoImageView.image = UIImage(data: data)
        })
        getClue()
        
        self.scoreLabel.text = "\(self.points)"

        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }

        SoundManager.shared.playSound()
        
    }

    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
    }
    
    func showFailure(message: String) {
          let alertVC = UIAlertController(title: "Network Request Failed", message: message, preferredStyle: .alert)
          alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          show(alertVC, sender: nil)
      }
    
    func getClue() {
        Networking.sharedInstance.getRandomCategory(completion: { (response, error) in
            guard let clue = response else {
                self.showFailure(message: error?.localizedDescription ?? "")
                return
            }
            
            Networking.sharedInstance.getAllCluesInCategory(clue: clue) { (response, error) in
                self.clues = response
                self.setUpView()
            }
        })
    }
    
    func setUpView() {
        let randomInt = Int.random(in: 0...3)
        correctAnswerClue = clues[randomInt]
        categoryLabel.text = correctAnswerClue?.category.title
        clueLabel.text = correctAnswerClue?.question
        scoreLabel.text = points.description
        tableView.reloadData()
    }
    
    func showAlert(with clue: Clue) {
        let info: (title: String, message: String)
        guard let correctClue = correctAnswerClue else { return }
        if clue.answer == correctClue.answer {
            info.title = "Correct Answer!"
            info.message = "You scored a point!"
            points += correctClue.value ?? 1
        } else {
            info.title = "Wrong Answer!"
            info.message = "No points awarded! The correct answer was \(correctClue.answer). Try Again!"
        }
        let alertVC = UIAlertController(title: info.title, message: info.message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default) { (action) in
            self.getClue()
            self.dismiss(animated: true, completion: nil)
        })
        show(alertVC, sender: nil)
    
     }
       

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clues.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .systemPurple
        cell.textLabel?.text = clues[indexPath.row].answer.capitalized
        cell.textLabel?.textAlignment = .center
        if clues[indexPath.row].answer == correctAnswerClue?.answer {
            cell.textLabel?.textColor = .red
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let choice = clues[indexPath.row]
        showAlert(with: choice)
    }
}

