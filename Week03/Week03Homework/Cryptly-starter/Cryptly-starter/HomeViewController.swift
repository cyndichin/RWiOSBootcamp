/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class HomeViewController: UIViewController{

  @IBOutlet weak var view1: UIView!
  @IBOutlet weak var view2: UIView!
  @IBOutlet weak var view3: UIView!
  @IBOutlet weak var risingView: UIView!
  @IBOutlet weak var fallingView: UIView!
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var view1TextLabel: UILabel!
  @IBOutlet weak var view2TextLabel: UILabel!
  @IBOutlet weak var view3TextLabel: UILabel!
  @IBOutlet weak var themeSwitch: UISwitch!
  @IBOutlet weak var risingTextLabel: UILabel!
  @IBOutlet weak var fallingTextLabel: UILabel!
  @IBOutlet weak var risingHeaderTextLabel: UILabel!
  @IBOutlet weak var fallingHeaderTextLabel: UILabel!
  
  let cryptoData = DataGenerator.shared.generateData()
  var views: [UIView] = []
  var labels: [UILabel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLabels()
    setView1Data()
    setView2Data()
    setView3Data()
    setRisingData()
    setFallingData()
    ThemeManager.shared.set(theme: LightTheme())
    views = [view1, view2, view3, risingView, fallingView]
    labels = [view1TextLabel, view2TextLabel, view3TextLabel, headingLabel, risingTextLabel, fallingTextLabel, risingHeaderTextLabel, fallingHeaderTextLabel]
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerForTheme()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForTheme()
  }
  
  func setupLabels() {
    labels.forEach { $0.font = UIFont.systemFont(ofSize: 18, weight: .regular) }
    headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
  }
  
  func setView1Data() {
    guard let cryptoData = cryptoData else { return }
    let currencies = cryptoData.reduce("") {
      $0 == "" ? $1.name : $0 + ", " + $1.name
    }
    view1TextLabel.text = currencies
  }
  
  func setView2Data() {
    guard let cryptoData = cryptoData else { return }
    let increasedCurrencies = cryptoData.filter({ (currency) -> Bool in
      currency.currentValue > currency.previousValue
    }).reduce("", {
        $0 == "" ? $1.name : $0 + ", " + $1.name
    })
    view2TextLabel.text = increasedCurrencies
  }
  
  func setView3Data() {
     guard let cryptoData = cryptoData else { return }
     let decreasedCurrencies = cryptoData.filter({ (currency) -> Bool in
       currency.currentValue < currency.previousValue
     }).reduce("", {
         $0 == "" ? $1.name : $0 + ", " + $1.name
     })
    view3TextLabel.text = decreasedCurrencies
  }
  
  func setRisingData() {
    guard let cryptoData = cryptoData else { return }
    let risingValue = cryptoData.reduce(0) { (result, crypto) -> Float in
      max(result, crypto.valueRise)
    }
    risingTextLabel.text = risingValue.description
  }
  
  func setFallingData() {
    guard let cryptoData = cryptoData else { return }
    let fallingValue = cryptoData.reduce(0) { (result, crypto) -> Float in
      min(result, crypto.valueRise)
    }
    fallingTextLabel.text = fallingValue.description
  }
  
  @IBAction func switchPressed(_ sender: Any) {
    let theme: Theme = themeSwitch.isOn ? DarkTheme() : LightTheme()
    ThemeManager.shared.set(theme: theme)
  }
}

extension HomeViewController: Themeable {
  func registerForTheme() {
    NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: Notification.Name.init("themeChanged"), object: nil)
  }
  
  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func themeChanged() {
    views.forEach { (view) in
      view.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor
      view.layer.borderColor = ThemeManager.shared.currentTheme?.borderColor.cgColor
    }
    labels.forEach { $0.textColor = ThemeManager.shared.currentTheme?.textColor }
    view.backgroundColor = ThemeManager.shared.currentTheme?.backgroundColor
  }
  
}
