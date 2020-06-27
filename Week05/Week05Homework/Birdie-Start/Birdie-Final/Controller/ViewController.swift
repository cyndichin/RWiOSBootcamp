//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

let mediaPostsHandler = MediaPostsHandler.shared

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    func setUpTableView() {
        // Set delegates, register custom cells, set up datasource, etc.
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "MediaPostTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaPostTableViewCell")
        mediaPostsHandler.getPosts()
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        let textAlertController = UIAlertController(title: "Create Text Post", message: "What is your username?", preferredStyle: .alert)
        textAlertController.addTextField { textField in
            textField.text = ""
            textField.placeholder = "Username"
        }
        textAlertController.addTextField() { textField in
            textField.text = ""
            textField.placeholder = "Text"
        }
        let createAction = UIAlertAction(title: "Submit", style: .default, handler: { action in
            let name = textAlertController.textFields?[0].text ?? "Noname"
            let content = textAlertController.textFields?[1].text
            
            let post = TextPost(textBody: content, userName: name, timestamp: Date())
            MediaPostsHandler.shared.addTextPost(textPost: post)
            self.tableview.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
        })
        textAlertController.addAction(createAction)
        textAlertController.addAction(cancelAction)
        textAlertController.preferredAction = createAction
        present(textAlertController, animated: true)
        

    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {

    }

}

extension UIViewController: UITableViewDelegate {
    
}

extension UIViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaPostsHandler.mediaPosts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaPostTableViewCell", for: indexPath)
        guard let mediaCell = cell as? MediaPostTableViewCell else {
            return cell
        }
        mediaCell.nameLabel.text = mediaPostsHandler.mediaPosts[indexPath.row].textBody
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM HH:mm"
        let timestamp = mediaPostsHandler.mediaPosts[indexPath.row].timestamp
        mediaCell.timestampLabel.text = dateFormatter.string(from: timestamp)
        mediaCell.bodyLabel.text = mediaPostsHandler.mediaPosts[indexPath.row].userName
        return mediaCell
    }
    
    
}

