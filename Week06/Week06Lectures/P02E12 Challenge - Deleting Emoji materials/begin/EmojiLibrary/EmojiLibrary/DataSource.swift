/// Copyright (c) 2019 Razeware LLC
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
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class DataSource: NSObject, UICollectionViewDataSource {
  let emoji = Emoji.shared
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    emoji.sections.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let category = emoji.sections[section]
    let emoji = self.emoji.data[category]
    
    return emoji?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let emojiCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseIdentifier, for: indexPath) as? EmojiCell else {
      fatalError("Cell cannot be created")
    }
    
    let category = emoji.sections[indexPath.section]
    let emoji = self.emoji.data[category]?[indexPath.item] ?? ""
    
    emojiCell.emojiLabel.text = emoji
    
    return emojiCell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let emojiHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EmojiHeaderView.reuseIdentifier, for: indexPath) as? EmojiHeaderView else {
      fatalError("Cannot create EmojiHeaderView")
    }
    
    let category = emoji.sections[indexPath.section]
    emojiHeaderView.textLabel.text = category.rawValue
    
    return emojiHeaderView
  }
}

extension DataSource {
  func addEmoji(_ emoji: String, to category: Emoji.Category) {
    guard var emojiData = self.emoji.data[category] else { return }
    emojiData.append(emoji)
    self.emoji.data.updateValue(emojiData, forKey: category)
  }
    
    func deleteEmoji(at indexPath: IndexPath) {
        let category = emoji.sections[indexPath.section]
        guard var emojiData = emoji.data[category] else { return }
        emojiData.remove(at: indexPath.item)
        emoji.data.updateValue(emojiData, forKey: category)
    }
    
    func deleteEmoji(at indexPaths: [IndexPath]) {
        for path in indexPaths {
            deleteEmoji(at: path)
        }
    }
}
