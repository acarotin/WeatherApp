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
    private var _main        : String?
    private var _icon        : String?
    private var _temperature : Int?
    private var _sunset      : Date?
    private var _sunrise     : Date?
    private var _humidity    : Int?
    private var _windspeed   : Int?
    private var _pressure    : Int?
    private var _lowest      : Int?
    private var _highest     : Int?
    
    var temperatureAsTxt : String = "Unavailable"
    var sunsetAsTxt      : String = "Unavailable"
    var sunriseAsTxt     : String = "Unavailable"
    var humidityAsTxt    : String = "Unavailable"
    var windspeedAsTxt   : String = "Unavailable"
    var pressureAsTxt    : String = "Unavailable"
    var lowestAsTxt      : String = "Unavailable"
    var highestAsTxt     : String = "Unavailable"
    
    private enum Constants {
        static let CellIdentifier = "Cell"
        static let StartingIndex = 13
    }
    
    init?(city: String, json: [String: Any]) {

        super.init()

        self.city = city
            
        if let weather = ((json["weather"] as? [[String: Any]])?[0]["description"] as? String) {
            
            self.weather = weather
            
        }
        
        if let main = ((json["weather"] as? [[String: Any]])?[0]["main"] as? String) {
            
            self.main = main
            
        }
        
        if let icon = ((json["weather"] as? [[String: Any]])?[0]["icon"] as? String) {
            
            self.icon = icon
            
        }
            
        if let temperature = ((json["main"] as? [String: Any])?["temp"]) {
            
            if let tempAsDouble = temperature as? Double {
                
                self.temperature = Int(round(tempAsDouble))
                if let t = self.temperature {
                    
                    self.temperatureAsTxt = "\(t)º"
                    
                }
                
            } else {
                
                self.temperature = nil
                
            }
            
        }
            
        if let sunriseTimestamp = ((json["sys"] as? [String: Any])?["sunrise"]) {
            
            if let timeInterval = sunriseTimestamp as? TimeInterval {
                
                var sunrise = Date(timeIntervalSince1970: timeInterval)
                sunrise = sunrise.addingTimeInterval(2 * 60 * 60)
                self.sunrise = sunrise
                self.sunriseAsTxt = sunrise.dateToString(date: sunrise)
                
            } else {
                
                self.sunrise = nil
                
            }
            
        }
            
        if let sunsetTimestamp = ((json["sys"] as? [String: Any])?["sunset"]) {
            
            if let timeInterval = sunsetTimestamp as? TimeInterval {
                
                var sunset = Date(timeIntervalSince1970: timeInterval)
                sunset = sunset.addingTimeInterval(2 * 60 * 60)
                self.sunset = sunset
                self.sunsetAsTxt = sunset.dateToString(date: sunset)
                
            } else {
                
                self.sunset = nil
                
            }
            
        }
        
        if let humidity = ((json["main"] as? [String: Any])?["humidity"]) {
            
            if let humidityAsDouble = humidity as? Double {
                
                self.humidity = Int(round(humidityAsDouble))
                if let h = self.humidity {
                    
                    self.humidityAsTxt = "\(h)%"
                    
                }
            
            } else {
                
                self.humidity = nil
                
            }
            
        }

        if let windspeed = ((json["wind"] as? [String: Any])?["speed"]) {
        
            if let windspeedAsDouble = windspeed as? Double {
                
                self.windspeed = Int(round(windspeedAsDouble))
                if let w = self.windspeed {
                    
                    self.windspeedAsTxt = "\(w) meter/sec"
                    
                }
                
            } else {
                
                self.windspeed = nil
                
            }
            
        }

        if let pressure = ((json["main"] as? [String: Any])?["pressure"]) {
            
            if let pressureAsDouble = pressure as? Double {
                
                self.pressure = Int(round(pressureAsDouble))
                if let p = self.pressure {
                    
                    self.pressureAsTxt = "\(p) hPa"
                    
                }
                
            } else {
                
                self.pressure = nil
            
            }
            
        }
        
        if let highest = ((json["main"] as? [String: Any])?["temp_max"]) {
            
            if let highestAsDouble = highest as? Double {
                
                self.highest = Int(round(highestAsDouble))
                if let hT = self.highest {
                    
                    self.highestAsTxt = "\(hT)º"
                    
                }
                
                
            } else {
                
                self.highest = nil
            
            }
            
        }
            
        if let lowest = ((json["main"] as? [String: Any])?["temp_min"]) {
            
            if let lowestAsDouble = lowest as? Double {
                
                self.lowest = Int(round(lowestAsDouble))
                if let lT = self.lowest {
                    
                    self.lowestAsTxt = "\(lT)º"
                    
                }
                
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
            
            if let main = weatherDataEntity.main {
                
                self.main = main
                
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
            
            if let t = self.temperature {
                
                self.temperatureAsTxt = "\(t)º"
            
            }
            
            if let sr = self.sunrise {
                
                self.sunriseAsTxt = "\(sr.dateToString(date: sr))º"
                
            }
            
            if let ss = self.sunset {
                
                self.sunsetAsTxt = "\(ss.dateToString(date: ss))º"
                
            }
            
            if let h = self.humidity {
                
                self.humidityAsTxt = "\(h)%"
                
            }
            
            if let w = self.windspeed {
                
                self.windspeedAsTxt = "\(w) meter/sec"
                
            }
            
            if let p = self.pressure {
                
                self.pressureAsTxt = "\(p) hPa"
                
            }
            
            if let h = self.highest {
                
                self.highestAsTxt = "\(h)º"
                
            }
            
            if let l = self.lowest {
                
                self.lowestAsTxt = "\(l)º"
                
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
    
    var main : String {
        get {
            if let m = _main {
                
                return m
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _main = newValue
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
        return (String(name.dropLast(5)), value)
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
        cell.selectionStyle = .none
        return cell
    }
    
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Detailed Informations"
    }
}
