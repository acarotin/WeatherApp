//
//  DailyForecast.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/22/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation

class DailyForecast: NSObject {
    var date : String?
    var hourlyForecast : [HourlyForecast]
    
    init(date: String? = nil, hourlyForecast: [HourlyForecast] = []) {
        self.date = date
        self.hourlyForecast = hourlyForecast
    }
    
    func getHourlyForecastByHour(hour: String) -> HourlyForecast {
        for case let h in self.hourlyForecast {
            if h.hour == hour {
                return h
            }
        }
        return self.hourlyForecast[0]
    }
    
    func getLowestTemp() -> String {
        var lowest : Int = 0
        for case let h in self.hourlyForecast {
            if let newLowest = h.data.lowest {
                if newLowest > lowest {
                    lowest = newLowest
                }
            }
        }
        if lowest == 0 {
            return "Unavailable"
        } else {
            return String(describing: lowest)
        }
    }
    
    func getHighestTemp() -> String {
        var highest : Int = 0
        for case let h in self.hourlyForecast {
            if let newHighest = h.data.highest {
                if newHighest > highest {
                    highest = newHighest
                }
            }
        }
        if highest == 0 {
            return "Unavailable"
        } else {
            return String(describing: highest)
        }
    }
}
