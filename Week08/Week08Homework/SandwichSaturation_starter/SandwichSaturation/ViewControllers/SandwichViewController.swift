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
  let searchController = UISearchController(searchResultsController: nil)
  var sandwiches = [SandwichModel]()
  var filteredSandwiches = [SandwichModel]()
    
    private var query = ""
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
   loadSandwiches()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
    
@IBAction func handleLongPress(gestureRecognizer: UIGestureRecognizer) {
    if gestureRecognizer.state != .ended {
        return
    }
    let point = gestureRecognizer.location(in: tableView)

    if let indexPath = tableView.indexPathForRow(at: point) {
        let sandwich = sandwiches[indexPath.row]
        context.delete(sandwich)
        appDelegate.saveContext()
        refresh()
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
  
  func loadSandwiches() {
        guard let fileURL = Bundle.main.url(forResource: "sandwiches", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([SandwichData].self, from: data)
            initialize()
            decodedData.forEach { (sandwich) in
                saveSandwich(sandwich)
            }

        } catch let error {
            print("Error in parsing \(error.localizedDescription)")
        }
  }
    
    func initialize() {
        for item in sauceAmounts {
            let sauceAmount = SauceAmountModel(entity: SauceAmountModel.entity(), insertInto: context)
            sauceAmount.sauceAmountString = item
            appDelegate.saveContext()
        }
    }
    
    private var sauceAmounts: [String] {
          return SauceAmount.allCases.map { $0.rawValue }
      }

  func saveSandwich(_ sandwich: SandwichData) {
    let sandwichCD = SandwichModel(entity: SandwichModel.entity(), insertInto: context)
           sandwichCD.name = sandwich.name
           do {
               let sandwichModels: [SauceAmountModel] = try context.fetch(SauceAmountModel.fetchRequest())
               guard !sandwichModels.isEmpty else { return }
               sandwichCD.sauceAmountModel = sandwichModels.first {
                   return $0.sauceAmountString == sandwich.sauceAmount.rawValue
               }
               sandwichCD.imageName = sandwich.imageName
               appDelegate.saveContext()
               refresh()
               tableView.reloadData()
           } catch let error as NSError {
               print("Could not fetch. \(error), \(error.userInfo)")
           }
  }

    func refresh() {
        do {
        let request: NSFetchRequest<SandwichModel> = SandwichModel.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(SandwichModel.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
        sandwiches = try context.fetch(request)
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
  
  func filterContentForSearchText(_ searchText: String,
                                  sauceAmount: SauceAmount? = nil) {
    query = searchText
    guard let sauceAmount = sauceAmount else { return }
    let request: NSFetchRequest<SandwichModel> = SandwichModel.fetchRequest()
    let sauceQuery = "sauceAmountModel.sauceAmountString = %@"
    let nameSearch = NSPredicate(format: "name CONTAINS[cd] %@", query)
    var sauceSearch = NSPredicate(format: sauceQuery, "\(sauceAmount.rawValue)")
    if sauceAmount == .any {
        sauceSearch = NSCompoundPredicate(orPredicateWithSubpredicates: [NSPredicate(format: sauceQuery, "None"), NSPredicate(format: sauceQuery, "Too Much")])
    }

    if isSearchBarEmpty {
        request.predicate = sauceSearch
    } else {
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [nameSearch, sauceSearch])
    }
    let sort = NSSortDescriptor(key: #keyPath(SandwichModel.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
    request.sortDescriptors = [sort]
    do {
        filteredSandwiches = try context.fetch(request)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
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

