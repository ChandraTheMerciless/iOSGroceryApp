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

class GroceryListManager {
    
    static var shared: GroceryListManager = GroceryListManager()
    var managedObjectContextList: NSManagedObjectContext?
    
    var data: [GroceryList]
    
    private init() {
        data = []
    }
    
    func set(managedObjectContextList: NSManagedObjectContext) {
        self.managedObjectContextList = managedObjectContextList
    }
    
    //if function has throw, wherever you use that func has to be wrapped in try
    func create(groceryListName: (String?)) throws {
        guard let ctx = managedObjectContextList else {
            throw GroceryListError.BadManagedObjectContext("The managed object context was nil")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "GroceryList", in: ctx) else {
            throw GroceryListError.BadEntity("The entity description was bad")
        }
        // TODO: Implement Me!
        let obj = GroceryList(entity: entity, insertInto: ctx)
        obj.groceryListName = groceryListName
        
        try? save()
    }
    
    //needs [weak self] (closure of captured list - needs to be weak because we don't want to capture self, we want to capture weak reference to it so it doesn't force function to run when we don't want it to
    func fetch<T: NSManagedObject>() -> [T] {
        var result: [T]? = nil
        managedObjectContextList?.performAndWait { [weak self] in
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
        try managedObjectContextList?.save()
    }
}
