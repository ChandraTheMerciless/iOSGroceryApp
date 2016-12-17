//
//  GroceryListManager.swift
//  Grocery App
//
//  Created by Asar, Chandra on 11/25/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import Foundation
import CoreData

enum GroceryListError: Error {
    case BadManagedObjectContext(String)
    case BadEntity(String)
}

class GroceryListManager: GroceryGetList, GroceryGetData, GroceryCreateList, GroceryCreateData, GroceryInterpretListProps, GroceryInterpretDataProps, GroceryEditList {
    static var shared: GroceryListManager = GroceryListManager()
    
    var managedObjectContext: NSManagedObjectContext?
    
    var groceryList: [GroceryList]
    var groceryListCount: Int {
        return groceryList.count
    }
    
    var groceryData: [GroceryData]
    var groceryDataCount: Int {
        return groceryData.count
    }
    
    var selectedGroceryListIndex: Int
    var selectedGroceryDataIndex: Int
    
    private init() {
        groceryList = []
        groceryData = []
        selectedGroceryListIndex = -1
        selectedGroceryDataIndex = -1
    }
}


extension GroceryListManager {
    func loadGroceryList() {
        groceryList = fetch()
    }
    
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
    
    func remove(groceryListNamed groceryListName: String?) throws {
        guard let ctx = managedObjectContext else {
            throw GroceryListError.BadManagedObjectContext("The managed object context was nil")
        }

        //MARK: The larger block returned an error of "cannot call value of non-function type"
        let list = groceryList.first
//        let list = groceryList.first { list in
//            return list.name == groceryListName
//        }
        if let listToBeDeleted = list {
            print("delete?");
            
            ctx.delete(list!)
        }
        
        try? save()
    }
    
    func getGroceryListName(from indexPath: IndexPath) -> String? {
        return groceryList.value(at: indexPath.row)?.groceryListName
    }
}

extension GroceryListManager {
    func loadGroceryData() {
        let selectedGroceryList = groceryList.value(at: selectedGroceryListIndex)
        groceryData = selectedGroceryList?.groceryData?.flatMap { item in
            return item as? GroceryData
            } ?? []
    }
    
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
}


extension GroceryListManager {
    // MARK: - Fetching Data
    
    func fetch<T: NSManagedObject>() -> [T] {
        var result: [T]? = nil
        managedObjectContext?.performAndWait { [weak self] in
            do {
                result = try self?.executeFetchRequest()
            }
            catch {
                print(error)
            }
        }

        return result ?? []
    }
    
    private func executeFetchRequest<T: NSManagedObject>() throws -> [T]? {
        let request = T.fetchRequest()
        return try request.execute() as? [T]
    }
    
    func save() throws {
        try managedObjectContext?.save()
    }
}
