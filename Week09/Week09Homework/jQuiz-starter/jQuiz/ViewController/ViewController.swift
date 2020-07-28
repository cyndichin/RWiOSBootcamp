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

    let game = GameManager()

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
            self.logoImageView.image = UIImageView.retrieveImage(data).image
        })
        
        getClue()
        let viewModel = JeopardyViewModel(with: game)
        self.scoreLabel.text = viewModel.points
        setSoundImage()
        SoundManager.shared.playSound()
    }

    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        setSoundImage()
    }
    
    func setSoundImage() {
        let soundImageLiteral = SoundManager.shared.isSoundEnabled == false ? "speaker.slash" : "speaker"
        soundButton.setImage(UIImage(systemName: soundImageLiteral), for: .normal)
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
                self.game.clues = response
                self.setUpView()
            }
        })
    }
    
    func setUpView() {
        game.setAnswer()
        let viewModel = JeopardyViewModel(with: game)
        categoryLabel.text = viewModel.category
        clueLabel.text = viewModel.question
        scoreLabel.text = viewModel.points
        tableView.reloadData()
    }
    
    func showAlert(with clue: Clue) {
        let info: (title: String, message: String)
        let viewModel = JeopardyViewModel(with: game)
        
        guard let correctClue = game.correctAnswerClue else { return }
        if clue.answer == correctClue.answer {
            info.title = viewModel.correctInfo.title
            info.message = viewModel.correctInfo.message
            game.addPoints(correctClue.value ?? 1)
        } else {
            info.title = viewModel.wrongInfo.title
            info.message = viewModel.wrongInfo.message
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
        return game.clues.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .systemPurple
        cell.textLabel?.text = game.clues[indexPath.row].answer.capitalized
        cell.textLabel?.textAlignment = .center
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let choice = game.clues[indexPath.row]
        showAlert(with: choice)
    }
}

