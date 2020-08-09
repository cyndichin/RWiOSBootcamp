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

final class ViewController: UIViewController {
  //MARK:- IB Outlets
  
  @IBOutlet private var tableView: TableView! {
    didSet { tableView.handleSelection = showItem }
  }

  @IBOutlet private var menuButton: UIButton!
  @IBOutlet private var titleLabel: UILabel!

  @IBOutlet private var menuHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var menuButtonTrailingConstraint: NSLayoutConstraint!
  @IBOutlet private var titleCenterYClosedConstraint: NSLayoutConstraint!
  @IBOutlet private var titleCenterYOpenConstraint: NSLayoutConstraint!

  //MARK:- Variables
  
  private var slider: HorizontalItemSlider!
  private var menuIsOpen = false
}

//MARK:- UIViewController
extension ViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    slider = HorizontalItemSlider(in: view) { [unowned self] item in
      self.tableView.addItem(item)
      self.transitionCloseMenu()
    }
    titleLabel.superview!.addSubview(slider)
  }
}

//MARK:- private
private extension ViewController {
  @IBAction func toggleMenu() {
    menuIsOpen.toggle()
    titleLabel.text = menuIsOpen ? "Select Item!" : "Packing List"
    view.layoutIfNeeded()

    titleCenterYClosedConstraint.isActive = !menuIsOpen
    titleCenterYOpenConstraint.isActive = menuIsOpen

    let constraints = titleLabel.superview!.constraints
    constraints.first {
      $0.firstItem === titleLabel
      && $0.firstAttribute == .centerX
    }?.constant = menuIsOpen ? -100 : 0

    menuHeightConstraint.constant = menuIsOpen ? 200 : 80
    menuButtonTrailingConstraint.constant = menuIsOpen ? 16 : 8

    UIView.animate(
      withDuration: 1, delay: 0,
      usingSpringWithDamping: 0.4, initialSpringVelocity: 10,
      options: .allowUserInteraction,
      animations: {
        self.menuButton.transform = .init(rotationAngle: self.menuIsOpen ? .pi / 4 : 0)
        self.view.layoutIfNeeded()
      }
    )
  }

  func showItem(_ item: Item) {
    let imageView = UIImageView(item: item)
    imageView.backgroundColor = .init(white: 0, alpha: 0.5)
    imageView.layer.cornerRadius = 5
    imageView.layer.masksToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(imageView)

    let containerView = UIView(frame: imageView.frame)
    view.addSubview(containerView)
    containerView.addSubview(imageView)
    containerView.translatesAutoresizingMaskIntoConstraints = false

    let bottomConstraint = containerView.bottomAnchor.constraint(
      equalTo: view.bottomAnchor, constant: containerView.frame.height
    )
    let widthConstraint = containerView.widthAnchor.constraint(
      equalTo: view.widthAnchor, multiplier: 1 / 3, constant: -50
    )
    NSLayoutConstraint.activate([
      bottomConstraint,
      widthConstraint,
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor),

      imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
    ])

    view.layoutIfNeeded()

    UIView.animate(
      withDuration: 0.8, delay: 0,
      usingSpringWithDamping: 0.6, initialSpringVelocity: 10,
      animations: {
        bottomConstraint.constant = imageView.frame.height * -2
        widthConstraint.constant = 0
        self.view.layoutIfNeeded()
      }
    )

    delay(seconds: 1) {
      UIView.transition(
        with: containerView,
        duration: 1,
        options: .transitionFlipFromBottom,
        animations: imageView.removeFromSuperview,
        completion: { _ in containerView.removeFromSuperview() }
      )
    }
  }

  func transitionCloseMenu() {
    delay(seconds: 0.35, execute: toggleMenu)

    let titleBar = slider.superview!
    UIView.transition(
      with: titleBar,
      duration: 0.5,
      options: .transitionFlipFromBottom,
      animations: { self.slider.isHidden = true },
      completion: { _ in self.slider.isHidden = false }
    )
  }
}

private func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
}
