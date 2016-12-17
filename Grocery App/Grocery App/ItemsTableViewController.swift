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
    var manager: (GroceryGetData & GroceryInterpretDataProps) = GroceryListManager.shared
    
    override func viewWillAppear(_ animated: Bool) {
        manager.loadGroceryData()
        
        GroceryDataView?.reloadData()
    }

    // MARK: - Table view data source
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.groceryDataCount
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! DataTableCellContainer
        
        let item = manager.getGroceryData(from: indexPath)
        
        cell.itemName?.text = item?.itemName
        cell.itemQuantity?.text = "Quantity: \(item?.itemQuantity ?? 0)"
        
        return cell as! UITableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: UIView.areAnimationsEnabled)
        manager.selectedGroceryDataIndex = indexPath.row
    }
    
}
