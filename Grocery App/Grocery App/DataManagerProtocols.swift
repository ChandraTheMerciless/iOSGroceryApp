//
//  DataManagerProtocols.swift
//  Grocery App
//
//  Created by Asar, Chandra on 12/10/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import Foundation

//MARK: break above protocol into traits
//NOTE: Below traits are too broad, since they should be as small as possible - break inits and edit down into smaller, more specific traits

protocol GroceryGetList {
    var groceryList: [GroceryList] { get set }
    func loadGroceryList()
}

protocol GroceryGetData {
    var groceryData: [GroceryData] { get set }
    func loadGroceryData()
}

protocol GroceryInterpretListProps {
    var groceryListCount: Int  { get }
    var selectedGroceryListIndex: Int { get set }
    func getGroceryListName(from indexPath: IndexPath) -> String?
}

protocol GroceryInterpretDataProps {
    var groceryDataCount: Int { get }
    var selectedGroceryDataIndex: Int { get set }
    func getGroceryData(from indexPath: IndexPath) -> (itemName: String?, itemQuantity: Int)?
}

protocol GroceryCreateList {
    func create(groceryListNamed groceryListName: String?) throws
}

protocol GroceryCreateData{
    func create(data: (itemName: String?, itemQuantity: Int)) throws
}

protocol GroceryEditList {
    func remove(groceryListNamed groceryListName: String?) throws
}

protocol GorceryEditData {
    
}
