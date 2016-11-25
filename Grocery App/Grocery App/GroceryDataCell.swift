//
//  GroceryDataCell.swift
//  Grocery App
//
//  Created by Asar, Chandra on 11/25/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import UIKit

class GroceryDataCell: UITableViewCell {

    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemQuantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
