//
//  Forecast.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/22/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation

class Forecast {
    var date: String? = nil
    var weather: String? = nil
    var dailyForecast : [DailyForecast] = []
    
    func contains(date: String?) -> DailyForecast? {
        guard let d = date else {
            return nil
        }
        for case let df in self.dailyForecast {
            if df.date == d {
                return df
            }
        }
        return nil
    }
    
    init?(json: [String: Any]) {

        print (json)
        
        guard let all = json["list"] as? NSArray else {
            
            print("fatal error")
            return
            
        }
        
        for case let result in all {
            
            var hour    : String?       = nil
            let day     : DailyForecast = DailyForecast()
            let data                    = WeatherData()
            
            if let date = ((result as? [String : Any])?["dt_txt"] as? String) {
                
                let dateArray   = date.components(separatedBy: " ")
                self.date       = dateArray[0]
                hour            = dateArray[1]
                
            }
            
            if let weather = (((result as? [String : Any])?["weather"] as? [[String: Any]])?[0]["main"] as? String) {
                
                self.weather = weather
                
            }
            
            if let temperature = (((result as? [String : Any])?["main"] as? [String: Any])?["temp"]) {
                
                if let tempAsDouble = temperature as? Double {
                    data.temperature = String(describing: Int(round(tempAsDouble)))
                } else {
                    data.temperature = "Unavailable"
                }
                
            }
            
            if let description = (((result as? [String : Any])?["weather"] as? [[String: Any]])?[0]["description"] as? String) {
                
                data.description = description
                
            }
            
            if let icon = (((result as? [String : Any])?["weather"] as? [[String: Any]])?[0]["icon"] as? String) {
                
                data.icon = icon
                
            }
            
            if let highest = (((result as? [String : Any])?["main"] as? [String: Any])?["temp_max"]) {
                
                if let highestAsDouble = highest as? Double {
                    data.highest = String(describing: Int(round(highestAsDouble)))
                } else {
                    data.highest = "Unavailable"
                }
                
            }
            
            if let lowest = (((result as? [String : Any])?["main"] as? [String: Any])?["temp_min"]) {
                
                if let lowestAsDouble = lowest as? Double {
                    data.lowest = String(describing: Int(round(lowestAsDouble)))
                } else {
                    data.lowest = "Unavailable"
                }
                
            }
            
            if let d = self.contains(date: self.date) {
                
                d.hourlyForecast.append(HourlyForecast(hour: hour, data: data))
                
            } else {
                
                day.date = self.date
                day.hourlyForecast.append(HourlyForecast(hour: hour, data: data))
                self.dailyForecast.append(day)
                
            }
            
        }
        
    }
    
    /*init(date: String, weather: String, weatherArray: [HourlyForecast]) {
        self.date = date
        self.weather = weather
        self.weatherArray = weatherArray
    }*/
}
