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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true);
        super.touchesBegan(touches, with: event);
        
        listName!.resignFirstResponder();
    }
    
    @IBAction func addListName(){
        print(listName?.text);
        try? manager.create(groceryListName: listName?.text)
        
        dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}




/*
 
 import UIKit
 
 class AddDataViewController: UIViewController {
 
 @IBOutlet var nameField: UITextField?
 
 let manager = DataManager.shared
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 
 }
 
 //will talk with core data
 @IBAction func add(){
 //do {
 //use question park to just say "throw exception on the ground because I don't care :D"
 //in using question mark, I don't need the rest of the do try catch syntaxs
 
 
 try? manager.create(data: (nameField?.text, ageField?.text?.integar ?? 0, descriptionView?.text))
 
 
 //}
 //catch {
 //    print(error)
 //}
 
 dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
 }
 }
 
 //converts int obj to string obj
 extension String {
 var integar: Int? {
 return Int(self)
 }
 }

 
 */
