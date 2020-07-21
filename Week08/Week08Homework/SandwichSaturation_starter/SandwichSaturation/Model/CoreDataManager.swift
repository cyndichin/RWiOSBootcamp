//
//  CoreDataManager.swift
//  SandwichSaturation
//
//  Created by cynber on 7/21/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteSandwich(_ sandwich: SandwichModel) {
        context.delete(sandwich)
        appDelegate.saveContext()
        _ = refresh()
    }
    
    func refresh() -> [SandwichModel]? {
        do {
            let request: NSFetchRequest<SandwichModel> = SandwichModel.fetchRequest()
            let sort = NSSortDescriptor(key: #keyPath(SandwichModel.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
            request.sortDescriptors = [sort]
            return try context.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func filter(_ query: String, _ sauceAmount: SauceAmount,_ isSearchBarEmpty: Bool) -> [SandwichModel]? {
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
            return try context.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
}
