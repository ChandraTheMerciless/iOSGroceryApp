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
    
    let manager = GroceryListManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true);
        super.touchesBegan(touches, with: event);
        
        listName!.resignFirstResponder();
    }
    
    @IBAction func addListName(){
        try? manager.create(groceryListNamed: listName?.text)
        
        dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
    }
}
