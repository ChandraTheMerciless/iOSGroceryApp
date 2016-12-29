//
//  DataManagerProtocols.swift
//  Grocery App
//
//  Created by Asar, Chandra on 12/10/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import Foundation
import CoreData

protocol GroceryGetList {
    var groceryList: [GroceryList] { get set } // NOTE - declared in multiple protocols
    var groceryListCount: Int  { get }
    var selectedGroceryListIndex: Int { get set } // NOTE - declared in multiple protocols
    
    func getGroceryListName(from indexPath: IndexPath) -> String?
    func fetch<T: NSManagedObject>() -> [T]
}

extension GroceryGetList {
    mutating func loadGroceryList() {
        groceryList = fetch()
    }
    
    func getGroceryListName(from indexPath: IndexPath) -> String? {
        return groceryList.value(at: indexPath.row)?.groceryListName
    }
}



//NOTE - since this depends on variables from list and data, restructure?
protocol GroceryGetData {
    var groceryData: [GroceryData] { get set } // NOTE - declared in multiple protocols
    var groceryList: [GroceryList] { get set } // NOTE - declared in multiple protocols
    var groceryDataCount: Int { get }
    var selectedGroceryListIndex: Int { get set } // NOTE - declared in multiple protocols
    var selectedGroceryDataIndex: Int { get set }
    
    func getGroceryData(from indexPath: IndexPath) -> (itemName: String?, itemQuantity: Int)?
}


extension GroceryGetData {
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
    var managedObjectContext: NSManagedObjectContext? { get set } //NOTE common - put in generic protocol for others to rely on?
    
    func save() throws // NOTE declared in multiple protocols
    
    func create(groceryListNamed groceryListName: String?) throws
}

extension GroceryCreateList {
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
    var groceryList: [GroceryList] { get set } // NOTE declared in two protocols or more

    var selectedGroceryListIndex: Int { get set } // NOTE - declared in multiple protocols

    var managedObjectContext: NSManagedObjectContext? { get set } //NOTE common - put in generic protocol for others to rely on?
    
    func create(data: (itemName: String?, itemQuantity: Int)) throws
    func save() throws // NOTE declared in multiple protocols
}

extension GroceryCreateData{
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

protocol GroceryEditList {
    var managedObjectContext: NSManagedObjectContext? { get set } //NOTE common - put in generic protocol for others to rely on?
    
    var groceryList: [GroceryList] { get set } // NOTE declared in two protocols or more

    func save() throws // NOTE declared in multiple protocols
    func remove(groceryListNamed groceryListName: String?) throws
}

extension GroceryEditList {
    func remove(groceryListNamed groceryListName: String?) throws {
        guard let ctx = managedObjectContext else {
            throw GroceryListError.BadManagedObjectContext("The managed object context was nil")
        }
        
        //MARK: The larger block returned an error of "cannot call value of non-function type"
        let list = groceryList.first
        
        if let listToBeDeleted = list {
            ctx.delete(list!)
        }
        
        try? save()
    }
}


protocol GroceryEditData {
    var managedObjectContext: NSManagedObjectContext? { get set } //NOTE common - put in generic protocol for others to rely on?
    
    var groceryData: [GroceryData] { get set }
    
    func remove(data: (itemName: String?, itemQuantity: Int)) throws
    func save() throws // NOTE declared in multiple protocols
}

extension GroceryEditData {
    func remove(data: (itemName: String?, itemQuantity: Int)) throws {
        guard let ctx = managedObjectContext else {
            throw GroceryListError.BadManagedObjectContext("The managed object context was nil")
        }
        
        //MARK: The larger block returned an error of "cannot call value of non-function type"
        let data = groceryData.first
        
        if let dataToBeDeleted = data {
            ctx.delete(data!)
        }
        
        try? save()
    }
}
