//
//  ForecastData.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/29/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation

class ForecastData {
    
    private var _temperature : String?
    private var _description : String?
    private var _icon        : String?
    private var _highest     : String?
    private var _lowest      : String?
    
    init(temperature : String? = nil, description : String? = nil, icon : String? = nil, highest : String? = nil, lowest : String? = nil) {
        
        self._temperature    = temperature
        self._description    = description
        self._icon           = icon
        self._highest        = highest
        self._lowest         = lowest
        
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
    
    var description : String {
        get {
            if let d = _description {
                
                return d
                
            } else {
                
                return "Unavailable"
                
            }
        }
        set {
            _description = newValue
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
    
}
