//
//  ItemsAddViewController.swift
//  Grocery App
//
//  Created by Asar, Chandra on 11/24/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import UIKit

class ItemsAddViewController: UIViewController {

    @IBOutlet var itemName: UITextField?
    @IBOutlet var itemQuantity: UITextField?
    
    var manager: GroceryCreateData = GroceryListManager.shared
    
    @IBAction func addItem(){
        try? manager.create(data: (itemName?.text, itemQuantity?.text?.integer ?? 0))
        //create(data: (itemName: String?, itemQuantity: Int)
        
        
        dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
    }
    
//    @IBAction func cancelAddItem(){
//        navigationController?.popViewController(animated: true)
//    }
}

//converts int obj to string obj
extension String {
    var integer: Int? {
        return Int(self)
    }
}
