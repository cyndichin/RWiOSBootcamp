//
//  InfoViewController.swift
//  ColorSlider
//
//  Created by cynber on 5/30/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import UIKit
import WebKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://en.wikipedia.org/wiki/RGB_color_model") {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    

}
