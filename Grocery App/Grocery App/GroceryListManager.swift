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

class GroceryListManager: GroceryGetData, GroceryGetList, GroceryCreateList, GroceryCreateData, GroceryEditList, GroceryEditData {
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

//put fetch and save into another protocol
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
