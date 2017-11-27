//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/22/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation

class WeatherData {
    
    var temperature : String?
    var description : String?
    var icon        : String?
    var highest     : String?
    var lowest      : String?
    
    init(temperature : String? = nil, description : String? = nil, icon : String? = nil, highest : String? = nil, lowest : String? = nil) {
        
        self.temperature    = temperature
        self.description    = description
        self.icon           = icon
        self.highest        = highest
        self.lowest         = lowest
        
    }
    
}
