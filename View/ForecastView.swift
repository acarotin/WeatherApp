//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/22/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation
import UIKit

class ForecastView: UIView {
    
    //private var forecastView: UIView!
    private var iconView: UIImageView!
    private var indicatorView: UIActivityIndicatorView!
    private var valueObservation: NSKeyValueObservation!
    private var hour : UILabel!
    private var temperature : UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //commonInit()
    }
    
    init(frame: CGRect, iconUrl: String?, hourText : String, temperatureText : String) {
        super.init(frame: frame)
        commonInit(hourText: hourText, temperatureText: temperatureText)
        if let url = iconUrl {
            NotificationCenter.default.post(name: .BLDownloadIcon, object: self, userInfo: ["iconView": iconView, "iconUrl" : url])
        }
    }
    
    private func commonInit(hourText : String, temperatureText : String) {
        
        // Setup the background
        backgroundColor = UIColor(white: 1, alpha: 0)
        //backgroundColor = .black
        
        // Create the cover image view
        iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        valueObservation = iconView.observe(\.image, options: [.new]) { [unowned self] observed, change in
            if change.newValue is UIImage {
                self.indicatorView.stopAnimating()
            }
        }
        addSubview(iconView)
        iconView.frame = CGRect(x: 0, y: 0, width: frame.size.width / 2, height: frame.size.height / 2)
        //iconView.layer.borderColor = UIColor.red.cgColor
        //iconView.layer.borderWidth = 1
        iconView.contentMode = .scaleToFill
        
        
        // Create the indicator view
        indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.activityIndicatorViewStyle = .whiteLarge
        indicatorView.startAnimating()
        addSubview(indicatorView)
        
        //add the constraints to put the image and indicator in the middle of the view
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        hour = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 20))
        hour.translatesAutoresizingMaskIntoConstraints = false
        hour.textAlignment = .center
        hour.text = "\(hourText)h"
        addSubview(hour)
        
        temperature = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 20))
        temperature.translatesAutoresizingMaskIntoConstraints = false
        temperature.textAlignment = .center
        temperature.text = "\(temperatureText)"
        addSubview(temperature)
        
        NSLayoutConstraint.activate([
            hour.centerXAnchor.constraint(equalTo: centerXAnchor),
            hour.topAnchor.constraint(equalTo: topAnchor),
            temperature.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperature.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    func highlightAlbum(_ didHighlightView: Bool) {
        if didHighlightView == true {
            backgroundColor = .white
        } else {
            backgroundColor = .black
        }
    }
    
}
