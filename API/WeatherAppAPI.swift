//
//  WeatherAppAPI.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/22/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import UIKit

final class WeatherAppAPI {
    
    // The shared static constant approach gives other objects access to the singleton object WeatherAppAPI
    static let shared = WeatherAppAPI()
    
    // The private initializer prevents creating new instances of WeatherAppAPI from outside.
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(downloadImage(with:)), name: .BLDownloadIcon, object: nil)
    }
    
    //private let persistencyManager = PersistencyManager()
    private let httpClient = HTTPClient()
    //private let isOnline = false
    
    /*func getReactions() -> [Reaction] {
        return persistencyManager.getReactions()
    }
    
    func addReaction(_ album: Reaction, at index: Int) {
        persistencyManager.addReaction(album, at: index)
        /*if isOnline {
         httpClient.postRequest("/api/addAlbum", body: album.description)
         }*/
    }
    
    func deleteAlbum(at index: Int) {
        persistencyManager.deleteReaction(at: index)
        /*if isOnline {
         httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
         }*/
    }*/
    
    func getForecast(city: String, completion: @escaping (_ json: [String:Any]?) -> Void) {
        httpClient.getForecast(city: city) { json in
            completion(json)
        } 
    }
    
    @objc func downloadImage(with notification: Notification) {
        guard let userInfo = notification.userInfo,
            let imageView = userInfo["iconView"] as? UIImageView,
            let coverUrl = userInfo["iconUrl"] as? String/*,
            let filename = URL(string: coverUrl)?.lastPathComponent*/ else {
                return
        }
        
        /*if let savedImage = persistencyManager.getImage(with: filename) {
            imageView.image = savedImage
            return
        }*/
        
        DispatchQueue.global().async {
            let downloadedIcon = self.httpClient.downloadIcon(coverUrl) ?? UIImage()
            DispatchQueue.main.async {
                imageView.image = downloadedIcon
                //self.persistencyManager.saveImage(downloadedImage, filename: filename)
            }
        }
    }
    
}
