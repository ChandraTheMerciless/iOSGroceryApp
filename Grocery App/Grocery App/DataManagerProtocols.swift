//
//  DataManagerProtocols.swift
//  Grocery App
//
//  Created by Asar, Chandra on 12/10/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import Foundation
import CoreData

// MARK Protocols with generic variables and functions
protocol GenericListVariables {
    var groceryList: [GroceryList] { get set }
    var selectedGroceryListIndex: Int { get set }
}

protocol GenericSaveVariables {
    var managedObjectContext: NSManagedObjectContext? { get set }
    
    func save() throws
}

// MARK Protocols that are more specific to certain jobs
protocol GroceryGetList {
    var groceryListCount: Int  { get }
    
    func getGroceryListName(from indexPath: IndexPath) -> String?
    func fetch<T: NSManagedObject>() -> [T]
}

extension GroceryGetList where Self: GenericListVariables {
    mutating func loadGroceryList() {
        groceryList = fetch()
    }
    
    func getGroceryListName(from indexPath: IndexPath) -> String? {
        return groceryList.value(at: indexPath.row)?.groceryListName
    }
}


protocol GroceryGetData {
    var groceryData: [GroceryData] { get set }
    var groceryDataCount: Int { get }
    var selectedGroceryDataIndex: Int { get set }
    
    func getGroceryData(from indexPath: IndexPath) -> (itemName: String?, itemQuantity: Int)?
}


extension GroceryGetData where Self: GenericListVariables {
    func getGroceryData(from indexPath: IndexPath) -> (itemName: String?, itemQuantity: Int)? {
        guard let item = groceryData.value(at: indexPath.row) else {
            return nil
        }
        return (item.itemName, Int(item.itemQuantity))
    }
    
    func getSelectedGroceryData() -> (itemName: String?, itemQuantity: Int)? {
        guard let item = groceryData.value(at: selectedGroceryDataIndex) else {
            return nil
        }
        return (item.itemName, Int(item.itemQuantity))
    }
    
    mutating func loadGroceryData() {
        let selectedGroceryList = groceryList.value(at: selectedGroceryListIndex)
        groceryData = selectedGroceryList?.groceryData?.flatMap { item in
            return item as? GroceryData
            } ?? []
    }
}


protocol GroceryCreateList {
    func create(groceryListNamed groceryListName: String?) throws
}

extension GroceryCreateList where Self: GenericSaveVariables {
    func create(groceryListNamed groceryListName: String?) throws {
        guard let ctx = managedObjectContext else {
            throw GroceryListError.BadManagedObjectContext("The managed object context was nil")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "GroceryList", in: ctx) else {
            throw GroceryListError.BadEntity("The entity description was bad")
        }
        
        let obj = GroceryList(entity: entity, insertInto: ctx)
        obj.groceryListName = groceryListName
        
        try? save()
    }
}


protocol GroceryCreateData{
    func create(data: (itemName: String?, itemQuantity: Int)) throws
}

extension GroceryCreateData where Self: GenericListVariables, Self: GenericSaveVariables {
    func create(data: (itemName: String?, itemQuantity: Int)) throws {
        guard let ctx = managedObjectContext else {
            throw GroceryListError.BadManagedObjectContext("The managed object context was nil")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "GroceryData", in: ctx) else {
            throw GroceryListError.BadEntity("The entity description was bad")
        }
        let obj = GroceryData(entity: entity, insertInto: ctx)
        obj.itemName = data.itemName
        obj.itemQuantity = Int16(data.itemQuantity)
        obj.groceryList = groceryList.value(at: selectedGroceryListIndex)
        
        try? save()
    }
}
