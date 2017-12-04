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
    private var _temperature : Int?
    private var _sunset      : Date?
    private var _sunrise     : Date?
    private var _humidity    : Int?
    private var _windspeed   : Int?
    private var _pressure    : Int?
    private var _lowest      : Int?
    private var _highest     : Int?
    
    private enum Constants {
        static let CellIdentifier = "Cell"
        static let StartingIndex = 4
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
                self.temperature = Int(round(tempAsDouble))
            } else {
                self.temperature = nil
            }
            
        }
            
        if let sunriseTimestamp = ((json["sys"] as? [String: Any])?["sunrise"]) {
            
            if let timeInterval = sunriseTimestamp as? TimeInterval {
                var sunrise = Date(timeIntervalSince1970: timeInterval)
                sunrise = sunrise.addingTimeInterval(2 * 60 * 60)
                self.sunrise = sunrise
            } else {
                self.sunrise = nil
            }
            
        }
            
        if let sunsetTimestamp = ((json["sys"] as? [String: Any])?["sunset"]) {
            
            if let timeInterval = sunsetTimestamp as? TimeInterval {
                var sunset = Date(timeIntervalSince1970: timeInterval)
                sunset = sunset.addingTimeInterval(2 * 60 * 60)
                self.sunset = sunset
            } else {
                self.sunset = nil
            }
            
        }
        
        if let humidity = ((json["main"] as? [String: Any])?["humidity"]) {
            
            if let humidityAsDouble = humidity as? Double {
                self.humidity = Int(round(humidityAsDouble))
            } else {
                self.humidity = nil
            }
            
        }

        if let windspeed = ((json["wind"] as? [String: Any])?["speed"]) {
        
            if let windspeedAsDouble = windspeed as? Double {
                self.windspeed = Int(round(windspeedAsDouble))
            } else {
                self.windspeed = nil
            }
            
        }

        if let pressure = ((json["main"] as? [String: Any])?["pressure"]) {
            
            if let pressureAsDouble = pressure as? Double {
                self.pressure = Int(round(pressureAsDouble))
            } else {
                self.pressure = nil
            }
            
        }
        
        if let highest = ((json["main"] as? [String: Any])?["temp_max"]) {
            
            if let highestAsDouble = highest as? Double {
                self.highest = Int(round(highestAsDouble))
            } else {
                self.highest = nil
            }
            
        }
            
        if let lowest = ((json["main"] as? [String: Any])?["temp_min"]) {
            
            if let lowestAsDouble = lowest as? Double {
                self.lowest = Int(round(lowestAsDouble))
            } else {
                self.lowest = nil
            }
                
        }
        
    }
    
    init?(result: [WeatherDataEntity]) {
        
        super.init()
        
        for weatherDataEntity in result {
            
            if let city = weatherDataEntity.city {
                
                self.city = city
                
            }
            
            if let weather = weatherDataEntity.weather {
                
                self.weather = weather
                
            }
            
            if let icon = weatherDataEntity.icon {
                
                self.icon = icon
                
            }
                
            self.temperature = Int(weatherDataEntity.temperature)
            self.sunrise = weatherDataEntity.sunrise
            self.sunset = weatherDataEntity.sunset
            self.humidity = Int(weatherDataEntity.humidity)
            self.windspeed = Int(weatherDataEntity.windspeed)
            self.pressure = Int(weatherDataEntity.pressure)
            self.highest = Int(weatherDataEntity.highest)
            self.lowest = Int(weatherDataEntity.lowest)
            
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
    
    var temperature : Int? {
        get {
            if let t = _temperature {
                
                return t
                
            } else {
                
                return nil
                
            }
        }
        set {
            _temperature = newValue
        }
    }
    
    var temperatureAsTxt : String {
        get {
            if let t = _temperature {
                
                return "\(t)º"
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var sunrise : Date? {
        get {
            if let s = _sunrise {
                
                return s
                
            } else {
                
                return nil
                
            }
        }
        set {
            _sunrise = newValue
        }
    }
    
    var sunriseToTxt : String {
        get {
            if let s = _sunrise {
                
                let sToTxt = s.dateToString(date: s)
                return sToTxt
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var sunset : Date? {
        get {
            if let s = _sunset {
                
                return s
                
            } else {
                
                return nil
                
            }
        }
        set {
            _sunset = newValue
        }
    }
    
    var sunsetToTxt : String {
        get {
            if let s = _sunset {
                
                let sToTxt = s.dateToString(date: s)
                return sToTxt
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var humidity : Int? {
        get {
            if let h = _humidity {
                
                return h
                
            } else {
                
                return nil
                
            }
        }
        set {
            _humidity = newValue
        }
    }
    
    var humidityAsTxt : String {
        get {
            if let h = _humidity {
                
                return "\(h)%"
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var windspeed : Int? {
        get {
            if let w = _windspeed {
                
                return w
                
            } else {
                
                return nil
                
            }
        }
        set {
            _windspeed = newValue
        }
    }
    
    var windspeedAsTxt : String {
        get {
            if let w = _windspeed {
                
                return "\(w) meter/sec"
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var pressure : Int? {
        get {
            if let p = _pressure {
                
                return p
                
            } else {
                
                return nil
                
            }
        }
        set {
            _pressure = newValue
        }
    }
    
    var pressureAsTxt : String {
        get {
            if let p = _pressure {
                
                return "\(p) hPa"
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var highest : Int? {
        get {
            if let h = _highest {
                
                return h
                
            } else {
                
                return nil
                
            }
        }
        set {
            _highest = newValue
        }
    }
    
    var highestAsTxt : String {
        get {
            if let h = _highest {
                
                return "\(h)º"
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var lowest : Int? {
        get {
            if let l = _lowest {
                
                return l
                
            } else {
                
                return nil
                
            }
        }
        set {
            _lowest = newValue
        }
    }
    
    var lowestAsTxt : String {
        get {
            if let l = _lowest {
                
                return "\(l)º"
                
            } else {
                
                return "Unavailable"
                
            }
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
        let cell = UITableViewCell(style:UITableViewCellStyle.value1, reuseIdentifier: Constants.CellIdentifier)
        cell.textLabel?.text = self[indexPath.row]?.key
        cell.detailTextLabel?.text = self[indexPath.row]?.value
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("test")
        cell.backgroundColor = UIColor.clear
    }
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Detailed Informations"
    }
}
