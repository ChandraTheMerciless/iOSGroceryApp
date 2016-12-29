//
//  TableCellProtocols.swift
//  Grocery App
//
//  Created by Asar, Chandra on 12/10/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import Foundation
import UIKit

protocol ListTableCellContainer {
    var listName: UILabel! { get set }
    var listItemNum: UILabel! { get set }
}

extension ListTableCellContainer {
    func setListName(name: String?) {
        listName.text = name
    }
    
    func setItemNum(itemNum: String?) {
        listItemNum.text = itemNum
    }
}

protocol DataTableCellContainer {
    var itemName: UILabel! { get set }
    var itemQuantity: UILabel! { get set }
}

extension DataTableCellContainer {
    func setListName(dataName: String?) {
        itemName.text = dataName
    }
    
    func setItemNum(dataItemNum: String?) {
        itemQuantity.text = dataItemNum
    }
}
