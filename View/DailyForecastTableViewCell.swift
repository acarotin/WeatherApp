//
//  DailyForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/28/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var metricLabel: UILabel!
    private var indicatorView: UIActivityIndicatorView!
    private var valueObservation: NSKeyValueObservation!
    
    var dayCell : DailyForecast? {
        didSet {
            if let d = dayCell {
                dayLabel?.text = d.date
                let hourlyForecast = d.getHourlyForecastByHour(hour: "15")
                NotificationCenter.default.post(name: .BLDownloadIcon, object: self, userInfo: ["iconView": self.iconView, "iconUrl" : hourlyForecast.data.icon])
                metricLabel?.text = d.getLowestTemp() + "° / " + d.getHighestTemp() + "°"
                self.dayLabel.textColor = UIColor.white
                self.metricLabel.textColor = UIColor.white
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        valueObservation = iconView.observe(\.image, options: [.new]) { [unowned self] observed, change in
            if change.newValue is UIImage {
                self.indicatorView.stopAnimating()
            }
        }
        
        indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.activityIndicatorViewStyle = .whiteLarge
        indicatorView.startAnimating()
        addSubview(indicatorView)
        
        //add the constraints to put the image and indicator in the middle of the view
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
