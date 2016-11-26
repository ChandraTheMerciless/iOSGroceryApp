//
//  ArrayExtension.swift
//  Grocery App
//
//  Created by Asar, Chandra on 11/26/16.
//  Copyright © 2016 Asar, Chandra. All rights reserved.
//

import Foundation

extension Array {
    func value(at index: Int) -> Element? {
        guard index >= 0 && index < endIndex else {
            return nil
        }
        return self[index]
    }
}
