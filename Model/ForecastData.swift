//
//  ForecastData.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/29/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation

class ForecastData {
    
    private var _temperature : Int?
    private var _weather     : String?
    private var _icon        : String?
    private var _highest     : Int?
    private var _lowest      : Int?
    
    init(temperature : Int? = nil, weather : String? = nil, icon : String? = nil, highest : Int? = nil, lowest : Int? = nil) {
        
        self._temperature    = temperature
        self._weather        = weather
        self._icon           = icon
        self._highest        = highest
        self._lowest         = lowest
        
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
                
                return "\(h)"
                
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
                
                return "\(l)"
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
}
