//
//  ListsTableViewController.swift
//  Grocery App
//
//  Created by Asar, Chandra on 11/24/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import UIKit

class ListsTableViewController: UITableViewController {

    @IBOutlet var GroceryListView: UITableView?
    
    var manager: (GroceryGetList & GroceryEditList) = GroceryListManager.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        manager.loadGroceryList()
        GroceryListView?.reloadData()
    }

    // MARK: - Table view data source

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.groceryListCount
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let listCell = cell as? ListTableCellContainer {
            let dataCount = manager.groceryList[indexPath.row].groceryData?.count
        
            listCell.listName?.text = manager.getGroceryListName(from: indexPath)
            listCell.listItemNum?.text = "\(dataCount ?? 0)"
        }
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: UIView.areAnimationsEnabled)
        
        manager.selectedGroceryListIndex = indexPath.row
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let listName = manager.getGroceryListName(from: indexPath);
            
            //handle delete stuff here
            try? manager.remove(groceryListNamed: listName)
            manager.groceryList.remove(at: indexPath.row)
            
            GroceryListView?.reloadData()
        }
    }
}
