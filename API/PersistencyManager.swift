//
//  PersistencyManager.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/30/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import UIKit
import CoreData

final class PersistencyManager {
    //private var forecast = Forecast?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init() {
        
    }
    
    func saveForecastToCoreData(forecast: Forecast) {
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newForecast = NSEntityDescription.insertNewObject(forEntityName: "ForecastEntity", into: context)
        
        for dailyForecast in forecast.dailyForecast {
            
            let newDailyForecast = NSEntityDescription.insertNewObject(forEntityName: "DailyForecastEntity", into: context)
            newDailyForecast.setValue(dailyForecast.date, forKey: "date")
            for hourlyForecast in dailyForecast.hourlyForecast {
                
                let newHourlyForecast = NSEntityDescription.insertNewObject(forEntityName: "HourlyForecastEntity", into: context)
                newHourlyForecast.setValue(hourlyForecast.hour, forKey: "hour")
                
                let newForecastData = NSEntityDescription.insertNewObject(forEntityName: "ForecastDataEntity", into: context)
                newForecastData.setValue(hourlyForecast.data.temperature, forKey: "temperature")
                newForecastData.setValue(hourlyForecast.data.weather, forKey: "weather")
                newForecastData.setValue(hourlyForecast.data.icon, forKey: "icon")
                newForecastData.setValue(hourlyForecast.data.highest, forKey: "highest")
                newForecastData.setValue(hourlyForecast.data.lowest, forKey: "lowest")
                newHourlyForecast.setValue(newForecastData, forKey: "forecastData")
                
                newHourlyForecast.setValue(newDailyForecast, forKey: "dailyForecast")
                
            }
            newDailyForecast.setValue(newForecast, forKey: "forecast")
        }
        
        do {
            try newForecast.managedObjectContext?.save()
        } catch {
            print(error)
        }
        
    }
    
    func saveWeatherToCoreData(weather: WeatherData) {
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newWeatherData = NSEntityDescription.insertNewObject(forEntityName: "WeatherDataEntity", into: context)
        newWeatherData.setValue(weather.city, forKey: "city")
        newWeatherData.setValue(weather.weather, forKey: "weather")
        newWeatherData.setValue(weather.icon, forKey: "icon")
        newWeatherData.setValue(weather.temperature, forKey: "temperature")
        newWeatherData.setValue(weather.sunrise, forKey: "sunrise")
        newWeatherData.setValue(weather.sunset, forKey: "sunset")
        newWeatherData.setValue(weather.humidity, forKey: "humidity")
        newWeatherData.setValue(weather.windspeed, forKey: "windspeed")
        newWeatherData.setValue(weather.pressure, forKey: "pressure")
        newWeatherData.setValue(weather.lowest, forKey: "lowest")
        newWeatherData.setValue(weather.highest, forKey: "highest")
        
        do {
            try newWeatherData.managedObjectContext?.save()
        } catch {
            print(error)
        }
        
    }
    
    func fetchForecastFromCoreData() -> Forecast? {
        
        var forecast : Forecast? = nil
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ForecastEntity>(entityName: "ForecastEntity")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            forecast = Forecast(result: result)
            
        } catch {
            
            let fetchError = error as NSError
            print(fetchError)
            
        }
        
        return forecast
    
    }
    
    func fetchWeatherFromCoreData() -> WeatherData? {
        
        var weather : WeatherData? = nil
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<WeatherDataEntity>(entityName: "WeatherDataEntity")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            weather = WeatherData(result: result)
            
        } catch {
            
            let fetchError = error as NSError
            print(fetchError)
            
        }
        
        return weather
        
    }
    
    func deleteEntityFromCoreData(entity: String) {
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    /*func getReactions() -> [Reaction] {
        return reactions
    }
    
    func addReaction(_ reaction: Reaction, at index: Int) {
        if (reactions.count >= index) {
            reactions.insert(reaction, at: index)
        } else {
            reactions.append(reaction)
        }
    }
    
    func deleteReaction(at index: Int) {
        reactions.remove(at: index)
    }
    
    private var cache: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    func saveImage(_ image: UIImage, filename: String) {
        let url = cache.appendingPathComponent(filename)
        guard let data = UIImagePNGRepresentation(image) else {
            return
        }
        try? data.write(to: url)
    }
    
    func getImage(with filename: String) -> UIImage? {
        let url = cache.appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }*/
}
