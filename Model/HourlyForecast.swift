//
//  HourlyForecast.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/22/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation

class HourlyForecast {
    private var _hour : String?
    var data : WeatherData
    
    init(hour: String? = nil, data: WeatherData) {
        self._hour = hour
        self.data = data
    }
    
    var hour: String? {
        get {
            if let h = _hour {
                
                return h.components(separatedBy: ":")[0]
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _hour = newValue
        }
    }
}
