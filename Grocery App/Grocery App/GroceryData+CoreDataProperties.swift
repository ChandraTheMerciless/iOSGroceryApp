//
//  GroceryData+CoreDataProperties.swift
//  Grocery App
//
//  Created by Asar, Chandra on 12/5/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import Foundation
import CoreData


extension GroceryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryData> {
        return NSFetchRequest<GroceryData>(entityName: "GroceryData");
    }

    @NSManaged public var itemName: String?
    @NSManaged public var itemQuantity: Int16
    @NSManaged public var groceryList: GroceryList?

}
