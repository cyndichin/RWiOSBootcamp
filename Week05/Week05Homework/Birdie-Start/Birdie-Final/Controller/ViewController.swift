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
    var postImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    func setUpTableView() {
        // Set delegates, register custom cells, set up datasource, etc.
        tableview.dataSource = self
        tableview.register(UINib(nibName: "MediaPostTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaPostTableViewCell")
        mediaPostsHandler.getPosts()
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        present(setUpAlertViewController(), animated: true)
    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.modalPresentationStyle = .fullScreen
        present(imagePickerController, animated: true)
    }
    
    func setUpAlertViewController() -> UIAlertController {
        let textAlertController = UIAlertController(title: "Create Post", message: "What's Up? :]", preferredStyle: .alert)
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
            var post: MediaPost = TextPost(textBody: content, userName: name, timestamp: Date())
            
            if let image = self.postImage {
                post = ImagePost(textBody: content, userName: name, timestamp: Date(), image: image)
            }
            
            MediaPostsHandler.shared.addPost(mediaPost: post)
            self.postImage = nil
            self.tableview.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        textAlertController.addAction(createAction)
        textAlertController.addAction(cancelAction)
        textAlertController.preferredAction = createAction
        return textAlertController
    }
}

extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaPostsHandler.mediaPosts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaPostTableViewCell", for: indexPath)
        guard let mediaCell = cell as? MediaPostTableViewCell else { return cell }
        let post = mediaPostsHandler.mediaPosts[indexPath.row]
        let viewModel = MediaPostsViewModel(with: post)
        viewModel.configure(mediaCell)
        return mediaCell
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] {
            postImage = image as? UIImage
            dismiss(animated: true, completion: nil)
            present(setUpAlertViewController(), animated: true)
        }
    }
}
