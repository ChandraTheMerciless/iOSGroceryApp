//
//  GroceryList+CoreDataProperties.swift
//  Grocery App
//
//  Created by Asar, Chandra on 12/5/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import Foundation
import CoreData


extension GroceryList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryList> {
        return NSFetchRequest<GroceryList>(entityName: "GroceryList");
    }

    @NSManaged public var groceryListName: String?
    @NSManaged public var groceryData: NSSet?

}

// MARK: Generated accessors for groceryData
extension GroceryList {

    @objc(addGroceryDataObject:)
    @NSManaged public func addToGroceryData(_ value: GroceryData)

    @objc(removeGroceryDataObject:)
    @NSManaged public func removeFromGroceryData(_ value: GroceryData)

    @objc(addGroceryData:)
    @NSManaged public func addToGroceryData(_ values: NSSet)

    @objc(removeGroceryData:)
    @NSManaged public func removeFromGroceryData(_ values: NSSet)

}
