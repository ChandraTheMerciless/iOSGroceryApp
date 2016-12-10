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
    var manager: DataManager = GroceryListManager.shared
    //let manager = GroceryListManager.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //found that this function results in a nilError in print logs
        manager.loadGroceryList()
        
        GroceryListView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.groceryListCount
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableCellContainer
        
        let itemCollection = manager.getGroceryData(from: indexPath)
        
        print(itemCollection)
        
        manager.loadGroceryData()
        
        cell.listName?.text = manager.getGroceryListName(from: indexPath)
        cell.listItemNum?.text = "\(manager.groceryDataCount ?? 0)"
        
        return cell as! UITableViewCell
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
            var list = manager.getGroceryListName(from: indexPath);
            
            //handle delete stuff here
            manager.groceryList.remove(at: indexPath.row)
            
            GroceryListView?.reloadData()
        }
    }
}
