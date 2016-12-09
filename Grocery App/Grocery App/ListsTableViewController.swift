//
//  ListsTableViewController.swift
//  Grocery App
//
//  Created by Asar, Chandra on 11/24/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import UIKit

protocol ListTableCellContainer {
    var listName: UILabel! { get set }
    var listItemNum: UILabel! { get set }
    
    func setListName(name: String?)
    func setItemNum(itemNum: String?)
}

extension ListTableCellContainer {
    
    func setListName(name: String?) {
        listName.text = name
    }
    
    func setItemNum(itemNum: String?) {
        listItemNum.text = itemNum
    }
}

class ListsTableViewController: UITableViewController {

    @IBOutlet var GroceryListView: UITableView?
    let manager = GroceryListManager.shared
    
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
        
        cell.listName?.text = manager.getGroceryListName(from: indexPath)
        cell.listItemNum?.text = "\(manager.groceryDataCount ?? 0)"
        
        return cell as! UITableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: UIView.areAnimationsEnabled)
        
        manager.selectedGroceryListIndex = indexPath.row
    }
    
}
