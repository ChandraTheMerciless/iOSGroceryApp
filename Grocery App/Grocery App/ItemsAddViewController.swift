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
    
    let groceryDataManager = GroceryListManager.shared
    
    @IBAction func addItem(){
        try? groceryDataManager.create(data: (itemName?.text, itemQuantity?.text?.integer ?? 0))
        
        dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true);
        super.touchesBegan(touches, with: event);
        
        itemName!.resignFirstResponder();
        itemQuantity!.resignFirstResponder();
    }
    
    @IBAction func cancelAddItem(){
        navigationController?.popViewController(animated: true)
    }
}

//converts int obj to string obj
extension String {
    var integer: Int? {
        return Int(self)
    }
}
