//
//  ListsAddViewController.swift
//  Grocery App
//
//  Created by Asar, Chandra on 11/24/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import UIKit

class ListsAddViewController: UIViewController {
    
    @IBOutlet var listName: UITextField?
    
    var manager: GroceryCreateList = GroceryListManager.shared
    
    @IBAction func addListName(){
        try? manager.create(groceryListNamed: listName?.text)
        
        dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
        dismissView()
    }
}
