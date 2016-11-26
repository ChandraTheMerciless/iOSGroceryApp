//
//  GroceryListProperties.swift
//  Grocery App
//
//  Created by Asar, Chandra on 11/25/16.
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



// MARK: Generated accessors for people
extension GroceryList {
    
    @objc(addPeopleObject:)
    @NSManaged public func addToItems(_ value: GroceryData)
    
    @objc(removePeopleObject:)
    @NSManaged public func removeFromItems(_ value: GroceryData)
    
    @objc(addPeople:)
    @NSManaged public func addToItems(_ values: NSSet)
    
    @objc(removePeople:)
    @NSManaged public func removeFromItems(_ values: NSSet)
    
}
