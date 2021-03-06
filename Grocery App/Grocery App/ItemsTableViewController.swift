//
//  ItemsTableViewController.swift
//  Grocery App
//
//  Created by Asar, Chandra on 11/24/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    @IBOutlet var GroceryDataView: UITableView?
    var manager: (GenericListVariables & GroceryGetData) = GroceryListManager.shared

    
    override func viewWillAppear(_ animated: Bool) {
        manager.loadGroceryData()
        
        GroceryDataView?.reloadData()
    }

    // MARK: - Table view data source
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.groceryDataCount
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let itemCell = cell as? DataTableCellContainer {
            let item = manager.getGroceryData(from: indexPath)
            
            itemCell.itemName?.text = item?.itemName
            itemCell.itemQuantity?.text = "Quantity: \(item?.itemQuantity ?? 0)"
        }
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: UIView.areAnimationsEnabled)
        manager.selectedGroceryDataIndex = indexPath.row
    }
}
