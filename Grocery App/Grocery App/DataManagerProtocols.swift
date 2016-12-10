//
//  DataManagerProtocols.swift
//  Grocery App
//
//  Created by Asar, Chandra on 12/10/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import Foundation

protocol DataManager {
    var groceryList: [GroceryList] { get set }
    var groceryListCount: Int  { get }
    
    var groceryData: [GroceryData] { get set }
    var groceryDataCount: Int { get }
    
    var selectedGroceryListIndex: Int { get set }
    var selectedGroceryDataIndex: Int{ get set }
    
    func loadGroceryList()
    func loadGroceryData()
    
    func create(groceryListNamed groceryListName: String?) throws
    func create(data: (itemName: String?, itemQuantity: Int)) throws
    
    func getGroceryListName(from indexPath: IndexPath) -> String?
    func getGroceryData(from indexPath: IndexPath) -> (itemName: String?, itemQuantity: Int)?
}
