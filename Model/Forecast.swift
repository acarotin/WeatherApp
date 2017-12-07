//
//  Forecast.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/22/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation

class Forecast: CustomStringConvertible {
    var dailyForecast : [DailyForecast] = []
    
    var description: String {
        
        return "\(dump(self.dailyForecast))"
        
    }
    
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
        
        guard let all = json["list"] as? NSArray else {
            
            print("fatal error")
            return
            
        }
        
        for case let result in all {
            
            var hour    : String?       = nil
            var date    : String?       = nil
            let day     : DailyForecast = DailyForecast()
            let data                    = ForecastData()
            
            if let d = ((result as? [String : Any])?["dt_txt"] as? String) {
                
                let dateArray   = d.components(separatedBy: " ")
                date            = dateArray[0]
                hour            = dateArray[1]
                
            }
            
            if let temperature = (((result as? [String : Any])?["main"] as? [String: Any])?["temp"]) {
                
                if let tempAsDouble = temperature as? Double {
                    data.temperature = Int(round(tempAsDouble))
                } else {
                    data.temperature = nil
                }
                
            }
            
            if let weather = (((result as? [String : Any])?["weather"] as? [[String: Any]])?[0]["description"] as? String) {
                
                data.weather = weather
                
            }
            
            if let icon = (((result as? [String : Any])?["weather"] as? [[String: Any]])?[0]["icon"] as? String) {
                
                data.icon = icon
                
            }
            
            if let highest = (((result as? [String : Any])?["main"] as? [String: Any])?["temp_max"]) {
                
                if let highestAsDouble = highest as? Double {
                    data.highest = Int(round(highestAsDouble))
                } else {
                    data.highest = nil
                }
                
            }
            
            if let lowest = (((result as? [String : Any])?["main"] as? [String: Any])?["temp_min"]) {
                
                if let lowestAsDouble = lowest as? Double {
                    data.lowest = Int(round(lowestAsDouble))
                } else {
                    data.lowest = nil
                }
                
            }
            
            if let d = self.contains(date: date) {
                
                d.hourlyForecast.append(HourlyForecast(hour: hour, data: data))
                
            } else {

                day.date = date
                day.hourlyForecast.append(HourlyForecast(hour: hour, data: data))
                self.dailyForecast.append(day)
                
            }
            
        }
        
    }
    
    init?(result: [ForecastEntity]) {
        
        for forecastEntity in result {
            
            var dailyForecast : [DailyForecast] = []
            
            if let dailyForecastFetch = forecastEntity.dailyForecast {
                
                for case let day as DailyForecastEntity in dailyForecastFetch {
                    
                    var hourlyForecast : [HourlyForecast] = []
                    
                    if let hourlyForecastFetch = day.hourlyForecast {
                            
                        for case let hour as HourlyForecastEntity in hourlyForecastFetch {
                            
                            var dt = ForecastData()
                            
                            if let data = hour.forecastData {
                            
                                dt = ForecastData(temperature: Int(data.temperature), weather: data.weather, icon: data.icon, highest: Int(data.highest), lowest: Int(data.lowest))
                            
                            }
                        
                            let h = HourlyForecast(hour: hour.hour, data: dt)
                            hourlyForecast.append(h)
                        
                        }
                    
                    }
                    
                    hourlyForecast.sort(by: {
                        (lhs, rhs) -> Bool in
                        guard let rhsHour = rhs.hour else {
                            return true
                        }
                        guard let lhsHour = lhs.hour else {
                            return false
                        }
                        return lhsHour < rhsHour
                    })
                    
                    let d = DailyForecast(date: day.date, hourlyForecast: hourlyForecast)
                    dailyForecast.append(d)
                
                }
            
            }
            
            dailyForecast.sort(by: {
                (lhs, rhs) -> Bool in
                guard let rhsDate = rhs.date else {
                    return true
                }
                guard let lhsDate = lhs.date else {
                    return false
                }
                return lhsDate < rhsDate
            })
            self.dailyForecast = dailyForecast
            
        }
        
        let now = Date()
         
        self.dailyForecast = self.dailyForecast.filter {
         
            if let dateString = $0.date {
         
                if let dateObj = Date(string: dateString) {

                    return dateObj > now
                    
                }
         
            }
         
            return false
         
        }
        
        print(self.dailyForecast.count)
         
        let hour = String(format: "%0.2d", Calendar.current.component(.hour, from: Date()))
        
        if self.dailyForecast.count > 0 {
            
            self.dailyForecast[0].hourlyForecast = self.dailyForecast[0].hourlyForecast.filter {
                
                if let hourString = $0.hour {
                    
                    return hourString > hour
                    
                }
                
                return true
                
            }
            
        }
        
    }
    
}
