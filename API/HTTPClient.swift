//
//  HTTPClient.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/22/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation
import UIKit

class HTTPClient {
    
    private let openWeatherMapURLForecast = "http://api.openweathermap.org/data/2.5/forecast"
    private let openWeatherMapURLCurrent = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "f2c0678af52aa02137f906cc6c18e9b5"
    private let iconBaseUrl = "http://openweathermap.org/img/w/"
    
    func getRequest(_ url: String) -> AnyObject {
        
        return Data() as AnyObject
    }
    
    func getForecast(city: String, completion: @escaping (_ json: [String:Any]?) -> Void) {
        
        let url = URL(string: "\(openWeatherMapURLForecast)?APPID=\(openWeatherMapAPIKey)&q=\(city)&units=metric")!
        
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print("error")
            }else{
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options:[]) as? [String:Any] {
                            completion(json)
                        }
                    } catch let err{
                        print(err.localizedDescription)
                    }
                }
                else {
                    completion(nil)
                }
            }
        }).resume()
        
    }
    
    func downloadIcon(_ url: String) -> UIImage? {
        let aUrl = URL(string: "\(iconBaseUrl)\(url).png")
        print(aUrl)
        guard let data = try? Data(contentsOf: aUrl!),
            let image = UIImage(data: data) else {
                return nil
        }
        return image
    }
    
    func downloadImage(_ url: String) -> UIImage? {
        let aUrl = URL(string: url)
        guard let data = try? Data(contentsOf: aUrl!),
            let image = UIImage(data: data) else {
                return nil
        }
        return image
    }
    
}