//
//  ChallengeItemDetailViewController.swift
//  Dabbles
//
//  Created by cynber on 7/26/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import Foundation
import UIKit

class ChallengeItemDetailViewController: UIViewController {
    var headerView: UIView!
    var titleLabel: UILabel!
    var ChallengeItem: ChallengeItem?
    
    convenience init(with ChallengeItem: ChallengeItem) {
        self.init()
        self.ChallengeItem = ChallengeItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeaderAndTitleLabel()
    }
    
    func setupHeaderAndTitleLabel() {
        // Initialize views and add them to the ViewController's view
        headerView = UIView()
        headerView.backgroundColor = .red
        self.view.addSubview(headerView)
        
        titleLabel = UILabel()
        titleLabel.text = ChallengeItem?.title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 20)
        headerView.addSubview(titleLabel)
        
        // Set position of views using constraints
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.4).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.5).isActive = true
    }
}
