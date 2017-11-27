//
//  DailyForecast.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/22/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation

class DailyForecast {
    var date : String?
    var hourlyForecast : [HourlyForecast]
    
    init(date: String? = nil, hourlyForecast: [HourlyForecast] = []) {
        self.date = date
        self.hourlyForecast = hourlyForecast
    }
}
