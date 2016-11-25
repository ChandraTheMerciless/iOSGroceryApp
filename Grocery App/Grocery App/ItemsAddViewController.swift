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
    @IBOutlet var itemQuantiy: UITextField?
    
    let dataManager = GroceryDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItem(){
        try? dataManager.create(data: ("List Name", itemName?.text, itemQuantiy?.text?.integer ?? 0))
        
        dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
    }
}

//converts int obj to string obj
extension String {
    var integer: Int? {
        return Int(self)
    }
}
