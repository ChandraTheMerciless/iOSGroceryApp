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
    let manager = GroceryDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    /*override func viewWillAppear(_ animated: Bool) {
        manager.data = manager.fetch()
        print("view did load working right?")
        print(manager.data)
        GroceryListView?.reloadData()
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.data.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! GroceryDataCell
        
        cell.itemName?.text = manager.data[indexPath.row].itemName
        cell.itemQuantity?.text = "\(manager.data[indexPath.row].itemQuantity)"
        
        return cell
    }
    
    
}
