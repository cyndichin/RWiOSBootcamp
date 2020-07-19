//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichDataSource {
    func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
    private var fetchedRC: NSFetchedResultsController<Sandwich>!
    private var query = ""
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let searchController = UISearchController(searchResultsController: nil)
//    var sandwiches = [SandwichData]()
//    var filteredSandwiches = [SandwichData]()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        guard !UserDefaults.standard.bool(forKey: "FirstLaunch") else {
            return
        }
        UserDefaults.standard.set(true, forKey: "FirstLaunch")
        loadSandwiches()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        // Setup Search Controller
//        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Filter Sandwiches"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
        searchController.searchBar.selectedScopeButtonIndex = UserDefaults.standard.integer(forKey: "SauceAmountIndex")
//        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    func loadSandwiches() {
        guard let fileURL = Bundle.main.url(forResource: "sandwiches", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([SandwichData].self, from: data)
//            sandwiches = decodedData
            decodedData.forEach { (sandwich) in
                let sandwichCD = Sandwich(entity: Sandwich.entity(), insertInto: context)
                sandwichCD.name = sandwich.name
                sandwichCD.sauceAmountModel.sauceAmount = sandwich.sauceAmount
                sandwichCD.imageName = sandwich.imageName
            }
            appDelegate.saveContext()
            refresh()
        } catch let error {
            print("Error in parsing \(error.localizedDescription)")
        }
    }
    
    func saveSandwich(_ sandwich: SandwichData) {
//        sandwiches.append(sandwich)
        let sandwichCD = Sandwich(entity: Sandwich.entity(), insertInto: context)
        sandwichCD.name = sandwich.name
        sandwichCD.sauceAmountModel = SauceAmountModel()
        sandwichCD.sauceAmountModel.sauceAmount = sandwich.sauceAmount
        sandwichCD.imageName = sandwich.imageName
        appDelegate.saveContext()
        refresh() // remove this for testing
        tableView.reloadData()
    }
    
    private func refresh() {
      let request = Sandwich.fetchRequest() as NSFetchRequest<Sandwich>
//      if query.isEmpty {
//        request.predicate = NSPredicate(format: "owner = %@", friend)
//      } else {
//        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@ AND owner = %@", query, friend)
//      }
      let sort = NSSortDescriptor(key: #keyPath(Sandwich.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
      request.sortDescriptors = [sort]
      do {
        fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        try fetchedRC?.performFetch()
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
      
    }
    
    @objc
    func presentAddView(_ sender: Any) {
        performSegue(withIdentifier: "AddSandwichSegue", sender: self)
    }
    
    // MARK: - Search Controller
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
//    func filterContentForSearchText(_ searchText: String,
//                                    sauceAmount: SauceAmount? = nil) {
//        filteredSandwiches = sandwiches.filter { (sandwhich: SandwichData) -> Bool in
//            let doesSauceAmountMatch = sauceAmount == .any || sandwhich.sauceAmount == sauceAmount
//
//            if isSearchBarEmpty {
//                return doesSauceAmountMatch
//            } else {
//                return doesSauceAmountMatch && sandwhich.name.lowercased()
//                    .contains(searchText.lowercased())
//            }
//        }
//
//        tableView.reloadData()
//    }
    
    var isFiltering: Bool {
        let searchBarScopeIsFiltering =
            searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive &&
            (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedRC?.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedRC?.sections, let objs = sections[section].objects else {
             return 0
        }
        return objs.count
//        return isFiltering ? filteredSandwiches.count : sandwiches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
            else { return UITableViewCell() }
        
//        let sandwich = isFiltering ?
//            filteredSandwiches[indexPath.row] :
//            sandwiches[indexPath.row]
        
        guard let sandwich = fetchedRC?.object(at: indexPath) else {
            return SandwichCell()
        }
        
        cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
        cell.nameLabel.text = sandwich.name
        cell.sauceLabel.text = sandwich.sauceAmountModel.sauceAmountString
        
        return cell
    }
}

// MARK: - UISearchResultsUpdating
//extension SandwichViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        let sauceAmount = SauceAmount(rawValue:
//            searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
//
//        filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
//    }
//}
//
//// MARK: - UISearchBarDelegate
//extension SandwichViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar,
//                   selectedScopeButtonIndexDidChange selectedScope: Int) {
//        UserDefaults.standard.set(selectedScope, forKey: "SauceAmountIndex")
//        let sauceAmount = SauceAmount(rawValue:
//            searchBar.scopeButtonTitles![selectedScope])
//        filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
//    }
//}

