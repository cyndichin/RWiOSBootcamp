//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit

protocol SandwichDataSource {
    func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
    let searchController = UISearchController(searchResultsController: nil)
    private var query = ""
    let coreDataManager = CoreDataManager()
    var sandwiches = [SandwichModel]()
    var filteredSandwiches = [SandwichModel]()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        // Setup Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Filter Sandwiches"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
        searchController.searchBar.selectedScopeButtonIndex = UserDefaults.standard.integer(forKey: "SauceAmountIndex")
        searchController.searchBar.delegate = self
        guard !UserDefaults.standard.bool(forKey: "FirstLaunch") else {
            refresh()
            return
        }
        UserDefaults.standard.set(true, forKey: "FirstLaunch")
        coreDataManager.loadSandwiches()
        refresh()
    }
    
    @IBAction func handleLongPress(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state != .ended {
            return
        }
        let point = gestureRecognizer.location(in: tableView)
        
        if let indexPath = tableView.indexPathForRow(at: point) {
            let sandwich = sandwiches[indexPath.row]
            coreDataManager.deleteSandwich(sandwich)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func saveSandwich(_ sandwich: SandwichData) {
        coreDataManager.saveSandwich(sandwich)
        refresh()
    }
    
    func refresh() {
        sandwiches = coreDataManager.refresh() ?? []
        tableView.reloadData()
    }
    
    @objc
    func presentAddView(_ sender: Any) {
        performSegue(withIdentifier: "AddSandwichSegue", sender: self)
    }
    
    // MARK: - Search Controller
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    sauceAmount: SauceAmount? = nil) {
        query = searchText
        guard let sauceAmount = sauceAmount else { return }
        filteredSandwiches = coreDataManager.filter(query, sauceAmount, isSearchBarEmpty) ?? []
        tableView.reloadData()
    }
    
    var isFiltering: Bool {
        let searchBarScopeIsFiltering =
            searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive &&
            (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredSandwiches.count : sandwiches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
            else { return UITableViewCell() }
        
        let sandwich = isFiltering ?
            filteredSandwiches[indexPath.row] :
            sandwiches[indexPath.row]
        
        if let imageName = sandwich.imageName {
            cell.thumbnail.image = UIImage.init(imageLiteralResourceName: imageName)
        }
        cell.nameLabel.text = sandwich.name
        cell.sauceLabel.text = sandwich.sauceAmountModel?.sauceAmountString
        
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let sauceAmount = SauceAmount(rawValue:
            searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        
        filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
    }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   selectedScopeButtonIndexDidChange selectedScope: Int) {
        UserDefaults.standard.set(selectedScope, forKey: "SauceAmountIndex")
        let sauceAmount = SauceAmount(rawValue:
            searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
    }
}

