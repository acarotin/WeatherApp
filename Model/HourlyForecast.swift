//
//  HourlyForecast.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/22/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation

class HourlyForecast {
    var hour : String?
    var data : WeatherData
    
    init(hour: String? = nil, data: WeatherData) {
        self.hour = hour
        self.data = data
    }
    
    func getFormattedHour() -> String {
        
        if let h = hour {
        
            return h.components(separatedBy: ":")[0]
        
        } else {
            
            return "Unavailable"
        
        }
        
    }
}
