//
//  GroceryDataManager.swift
//  Grocery App
//
//  Created by Asar, Chandra on 11/24/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import Foundation
import CoreData

enum DataError: Error {
    case BadManagedObjectContext(String)
    case BadEntity(String)
}

class DataManager {
    
    static var shared: DataManager = DataManager()
    var managedObjectContext: NSManagedObjectContext?
    
    var data: [GroceryData]
    
    private init() {
        data = []
    }
    
    func set(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    //if function has throw, wherever you use that func has to be wrapped in try
    func create(data: (listName: String?, itemName: String?, itemQuantity: Int)) throws {
        guard let ctx = managedObjectContext else {
            throw DataError.BadManagedObjectContext("The managed object context was nil")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "MyData", in: ctx) else {
            throw DataError.BadEntity("The entity description was bad")
        }
        // TODO: Implement Me!
        let obj = GroceryData(entity: entity, insertInto: ctx)
        obj.listName = data.listName
        obj.itemName = data.itemName
        obj.itemQuantity = Int16(data.itemQuantity)
        
        try? save()
    }
    
    //needs [weak self] (closure of captured list - needs to be weak because we don't want to capture self, we want to capture weak reference to it so it doesn't force function to run when we don't want it to
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
    
    func save()  throws {
        try managedObjectContext?.save()
    }
}
