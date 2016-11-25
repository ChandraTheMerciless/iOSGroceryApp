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
    let manager = GroceryListManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager.data = manager.fetch()
        print("view did load working right?")
        print(manager.data)
        GroceryListView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.data.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! GroceryListCell
        
        cell.listName?.text = manager.data[indexPath.row].groceryListName
        //cell.listItemNum?.text = manager.data[indexPath.row].groceryListName
        //cell.listItemNum?.text = "\(manager.data[indexPath.row].groceryItem.count)" //string interpolation
        
        return cell
    }

}
