//
//  SauceAmountModel+CoreDataProperties.swift
//  SandwichSaturation
//
//  Created by cynber on 7/19/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


extension SauceAmountModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SauceAmountModel> {
        return NSFetchRequest<SauceAmountModel>(entityName: "SauceAmountModel")
    }

    @NSManaged public var sauceAmountString: String?
    @NSManaged public var sandwich: Sandwich?

}
