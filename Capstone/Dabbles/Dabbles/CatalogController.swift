//
//  FirstViewController.swift
//  Dabbles
//
//  Created by cynber on 7/22/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import UIKit

class CatalogController: UIViewController {
    
    static let sectionHeaderElementKind = "section-header-element-kind"
//    let ref = Database.database().reference(withPath: "ChallengeItem-items")
    
    @IBOutlet weak var collectionView: UICollectionView!
    let headerId = "headerId"
    static let categoryHeaderId = "categoryHeaderId"
    
    
    // MARK: - Properties
    private var sections = Category.allCategories
    private lazy var dataSource = makeDataSource()
    private var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Value Types
    typealias DataSource = UICollectionViewDiffableDataSource<Category, ChallengeItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Category, ChallengeItem>
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        collectionView.register(UINib(nibName: "ChallengeItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ChallengeItemCollectionViewCell.reuseIdentifier)
        configureSearchController()
        configureLayout()
        applySnapshot(animatingDifferences: false)
        
        navigationItem.title = "ChallengeItems Catalog"
    }
    
    // MARK: - Functions
    func makeDataSource() -> DataSource {
        // 1
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, ChallengeItem) ->
                UICollectionViewCell? in
                // 2
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ChallengeItemCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? ChallengeItemCollectionViewCell
                print(ChallengeItem.title, ChallengeItem.thumbnail)
                cell?.ChallengeItem = ChallengeItem
                return cell
        })
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            let section = self.dataSource.snapshot()
                .sectionIdentifiers[indexPath.section]
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CategoryHeaderReusableView.reuseIdentifier,
                for: indexPath) as? CategoryHeaderReusableView
            view?.titleLabel.text = section.title
            return view
        }
        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        // 2
        var snapshot = Snapshot()
        // 3
        snapshot.appendSections(sections)
        // 4
        sections.forEach { section in
            snapshot.appendItems(section.ChallengeItems, toSection: section)
        }
        // 5
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                return section
                
            } else if sectionNumber == 1 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(150)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .absolute(50), heightDimension: .absolute(50)), elementKind: categoryHeaderId, alignment: .topLeading)
                ]
                return section
            } else if sectionNumber == 2 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.leading = 32
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.75), heightDimension: .absolute(125)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 16
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(300)))
                item.contentInsets.bottom = 16
                item.contentInsets.trailing = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(1000)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 32, leading: 16, bottom: 0, trailing: 0)
                return section
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func loadChallengeItems() -> [ChallengeItem] {
        guard let fileURL = Bundle.main.url(forResource: "sandwiches", withExtension: "json") else { return [] }
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([ChallengeItem].self, from: data)
            return decodedData
        } catch let error {
            print("Error in parsing \(error.localizedDescription)")
            return []
        }
    }
    
}

class Header: UICollectionReusableView {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "Categories"
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}

extension CatalogController {
    
    func generateCategoryLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
}

extension CatalogController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        sections = filteredCategories(for: searchController.searchBar.text)
        applySnapshot()
    }
    
    func filteredCategories(for queryOrNil: String?) -> [Category] {
        let categories = Category.allCategories
        guard
            let query = queryOrNil,
            !query.isEmpty
            else {
                return categories
        }
        
        return categories.filter { section in
            var matches = section.title.lowercased().contains(query.lowercased())
            for ChallengeItem in section.ChallengeItems {
                if ChallengeItem.title.lowercased().contains(query.lowercased()) {
                    matches = true
                    break
                }
            }
            return matches
        }
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search ChallengeItems"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
//        searchController.searchBar.scopeButtonTitles = Category.allCategories.map { $0.title }
//        searchController.searchBar.delegate = self
    }
}


// MARK: - Layout Handling
extension CatalogController {
    private func configureLayout() {
        collectionView.register(
            CategoryHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CategoryHeaderReusableView.reuseIdentifier
        )
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            if sectionIndex == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                return section
                
            } else if sectionIndex == 1 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(150)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                //                       section.boundarySupplementaryItems = [
                //                           .init(layoutSize: .init(widthDimension: .absolute(50), heightDimension: .absolute(50)), elementKind: categoryHeaderId, alignment: .topLeading)
                //                       ]
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                section.interGroupSpacing = 10
                // Supplementary header view setup
                let headerFooterSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(20)
                )
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            } else if sectionIndex == 3 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.leading = 32
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.75), heightDimension: .absolute(125)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 16
                return section
            } else if sectionIndex == 2 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(300)))
//                item.contentInsets.bottom = 16
//                item.contentInsets.trailing = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
//                section.contentInsets = .init(top: 32, leading: 16, bottom: 0, trailing: 0)
                return section
            } else {
                 let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(300)))
                 //                item.contentInsets.bottom = 16
                 //                item.contentInsets.trailing = 16
                                 let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), subitems: [item])
                                 let section = NSCollectionLayoutSection(group: group)
                                 section.orthogonalScrollingBehavior = .continuous
                 //                section.contentInsets = .init(top: 32, leading: 16, bottom: 0, trailing: 0)
                                 return section
            }
            
            //      let isPhone = layoutEnvironment.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone
            //      let size = NSCollectionLayoutSize(
            //        widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            //        heightDimension: NSCollectionLayoutDimension.absolute(isPhone ? 280 : 250)
            //      )
            //      let itemCount = isPhone ? 1 : 3
            //      let item = NSCollectionLayoutItem(layoutSize: size)
            //      let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
            //      let section = NSCollectionLayoutSection(group: group)
            //      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            //      section.interGroupSpacing = 10
            //      // Supplementary header view setup
            //      let headerFooterSize = NSCollectionLayoutSize(
            //        widthDimension: .fractionalWidth(1.0),
            //        heightDimension: .estimated(20)
            //      )
            //      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            //        layoutSize: headerFooterSize,
            //        elementKind: UICollectionView.elementKindSectionHeader,
            //        alignment: .top
            //      )
            //      section.boundarySupplementaryItems = [sectionHeader]
        })
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
}

extension CatalogController: UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let ChallengeItem = dataSource.itemIdentifier(for: indexPath) else {   return}
        print(ChallengeItem)
        let ChallengeItemVC = ChallengeItemDetailViewController(with: ChallengeItem)
        present(ChallengeItemVC, animated: true)
    }
}


// MARK: - UISearchBarDelegate
extension CatalogController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar,
//                   selectedScopeButtonIndexDidChange selectedScope: Int) {
//        UserDefaults.standard.set(selectedScope, forKey: "SauceAmountIndex")
//        let sauceAmount = SauceAmount(rawValue:
//            searchBar.scopeButtonTitles![selectedScope])
//        filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
//    }
}
