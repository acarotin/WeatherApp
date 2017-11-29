//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/22/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation
import UIKit

class WeatherData : NSObject {
    
    private var _city        : String?
    private var _weather     : String?
    private var _icon        : String?
    private var _temperature : String?
    private var _sunset      : String?
    private var _sunrise     : String?
    private var _humidity    : String?
    private var _windspeed   : String?
    private var _pressure    : String?
    private var _lowest      : String?
    private var _highest     : String?
    
    private enum Constants {
        static let CellIdentifier = "Cell"
        static let StartingIndex = 3
    }
    
    init?(city: String, json: [String: Any]) {
        
        super.init()
        //print(json)
        
        self.city = city
            
        if let weather = ((json["weather"] as? [[String: Any]])?[0]["description"] as? String) {
            
            self.weather = weather
            
        }
        
        if let icon = ((json["weather"] as? [[String: Any]])?[0]["icon"] as? String) {
            
            self.icon = icon
            
        }
            
        if let temperature = ((json["main"] as? [String: Any])?["temp"]) {
            
            if let tempAsDouble = temperature as? Double {
                self.temperature = String(describing: Int(round(tempAsDouble)))
            } else {
                self.temperature = "Unavailable"
            }
            
        }
            
        if let sunriseTimestamp = ((json["sys"] as? [String: Any])?["sunrise"]) {
            
            if let timeInterval = sunriseTimestamp as? TimeInterval {
                var sunrise = Date(timeIntervalSince1970: timeInterval)
                sunrise = sunrise.addingTimeInterval(2 * 60 * 60)
                self.sunrise = sunrise.dateToString(date: sunrise)
            } else {
                self.sunrise = "Unavailable"
            }
            
        }
            
        if let sunsetTimestamp = ((json["sys"] as? [String: Any])?["sunset"]) {
            
            if let timeInterval = sunsetTimestamp as? TimeInterval {
                var sunset = Date(timeIntervalSince1970: timeInterval)
                sunset = sunset.addingTimeInterval(2 * 60 * 60)
                self.sunset = sunset.dateToString(date: sunset)
            } else {
                self.sunset = "Unavailable"
            }
            
        }
        
        if let humidity = ((json["main"] as? [String: Any])?["humidity"]) {
            
            if let humidityAsDouble = humidity as? Double {
                self.humidity = String(describing: Int(round(humidityAsDouble)))
            } else {
                self.humidity = "Unavailable"
            }
            
        }

        if let windspeed = ((json["wind"] as? [String: Any])?["speed"]) {
        
            if let windspeedAsDouble = windspeed as? Double {
                self.windspeed = String(describing: Int(round(windspeedAsDouble)))
            } else {
                self.windspeed = "Unavailable"
            }
            
        }

        if let pressure = ((json["main"] as? [String: Any])?["pressure"]) {
            
            if let pressureAsDouble = pressure as? Double {
                self.pressure = String(describing: Int(round(pressureAsDouble)))
            } else {
                self.pressure = "Unavailable"
            }
            
        }
        
        if let highest = ((json["main"] as? [String: Any])?["temp_max"]) {
            
            if let highestAsDouble = highest as? Double {
                self.highest = String(describing: Int(round(highestAsDouble)))
            } else {
                self.highest = "Unavailable"
            }
            
        }
            
        if let lowest = ((json["main"] as? [String: Any])?["temp_min"]) {
            
            if let lowestAsDouble = lowest as? Double {
                self.lowest = String(describing: Int(round(lowestAsDouble)))
            } else {
                self.lowest = "Unavailable"
            }
                
        }
        
    }
    
    var city : String {
        get {
            if let c = _city {
                
                return c
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _city = newValue
        }
    }
    
    var weather : String {
        get {
            if let d = _weather {
                
                return d
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _weather = newValue
        }
    }
    
    var icon : String {
        get {
            if let i = _icon {
                
                return i
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _icon = newValue
        }
    }
    
    var temperature : String {
        get {
            if let t = _temperature {
                
                return "\(t)º"
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _temperature = newValue
        }
    }
    
    var sunrise : String {
        get {
            if let s = _sunrise {
                
                return s
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _sunrise = newValue
        }
    }
    
    var sunset : String {
        get {
            if let s = _sunset {
                
                return s
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _sunset = newValue
        }
    }
    
    var humidity : String {
        get {
            if let h = _humidity {
                
                return h
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _humidity = newValue
        }
    }
    
    var highest : String {
        get {
            if let h = _highest {
                
                return h
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _highest = newValue
        }
    }
    
    var windspeed : String {
        get {
            if let w = _windspeed {
                
                return w
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _windspeed = newValue
        }
    }
    
    var pressure : String {
        get {
            if let p = _pressure {
                
                return p
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _pressure = newValue
        }
    }
    
    var lowest : String {
        get {
            if let l = _lowest {
                
                return l
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _lowest = newValue
        }
    }
    
    var count : Int {
        get {
            let weatherDataMirror = Mirror(reflecting: self)
            return Int(weatherDataMirror.children.count) - Constants.StartingIndex
        }
    }
    
    subscript(_ index : Int) -> (key: String, value: String)? {
        let weatherDataMirror = Mirror(reflecting: self)
        let i = weatherDataMirror.children.index(weatherDataMirror.children.startIndex, offsetBy: Int64(index + Constants.StartingIndex))
        let property = weatherDataMirror.children[i]
        guard let name = property.label,
            let value = property.value as? String else {
            return nil
        }
        return (String(name.dropFirst()), value)
    }
    
}

extension WeatherData : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: Constants.CellIdentifier)
        cell.textLabel?.text = self[indexPath.row]?.key
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Daily Forecast"
    }
}
