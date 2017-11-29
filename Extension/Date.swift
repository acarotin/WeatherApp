//
//  Date.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/29/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation

extension Date {
    
    func dateToString(date : Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
        
    }
    
}
