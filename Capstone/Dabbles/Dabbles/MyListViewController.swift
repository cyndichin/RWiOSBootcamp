//
//  MyListViewController.swift
//  Dabbles
//
//  Created by cynber on 7/26/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import UIKit

class MyListViewController: UIViewController {
    enum Section: CaseIterable {
        case favorites
        case all
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    private let viewModel = MyListViewModel()
    private lazy var dataSource = makeDataSource()
    private lazy var compositionalLayout = makeCompositionalLayout()

    override func viewDidLoad() {
        super.viewDidLoad()

         collectionView.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.reuseIdentifier)
//        // Configure Collection View
//        collectionView.delegate = self
//        collectionView.dataSource = self
        // Create Collection View Layout
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = compositionalLayout
        view.addSubview(collectionView)
        updateList()
    }

    func updateList() {
           var snapshot = NSDiffableDataSourceSnapshot<Section, ChallengeItem>()
           snapshot.appendSections(Section.allCases)
           snapshot.appendItems(viewModel.favorites, toSection: .favorites)
           snapshot.appendItems(viewModel.all, toSection: .all)
           dataSource.apply(snapshot)
       }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, ChallengeItem> {
          let dataSource = UICollectionViewDiffableDataSource<Section, ChallengeItem>(
              collectionView: collectionView,
              cellProvider: { (collectionView, indexPath, ChallengeItem) ->
                  UICollectionViewCell? in
                  // 2
                  let cell = collectionView.dequeueReusableCell(
                      withReuseIdentifier: ListCollectionViewCell.reuseIdentifier,
                      for: indexPath) as? ListCollectionViewCell
                  print(ChallengeItem.title, ChallengeItem.thumbnail)
                cell?.challengeItemTitleLabel.text = "Boo"
                  return cell
          })
          return dataSource
      }
  
    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)

      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

      let section = NSCollectionLayoutSection(group: group)

      let layout = UICollectionViewCompositionalLayout(section: section)
      return layout
    }
}
