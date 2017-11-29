//
//  Dictionary.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/29/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation

extension Dictionary {
    
    subscript(_ i : Int) -> (key: Key, value: Value) {
        let index = self.index(self.startIndex, offsetBy: i)
        return self[index]
    }
    
}
