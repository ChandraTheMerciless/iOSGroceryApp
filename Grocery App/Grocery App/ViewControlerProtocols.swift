//
//  ViewControlerProtocols.swift
//  Grocery App
//
//  Created by Asar, Chandra on 12/12/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import Foundation
import UIKit

protocol DismissableKeyboard {
    func dismissKeyboard()
}

extension UIViewController: DismissableKeyboard {
    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }
}
