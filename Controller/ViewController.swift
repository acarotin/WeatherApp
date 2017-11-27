//
//  ViewController.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/22/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var horizontalScrollerView: HorizontalScrollerView!
    var forecast : Forecast? = nil
    
    private enum Constants {
        static let CellIdentifier = "Cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        let backgroundView = BackgroundView()
        self.view.insertSubview(backgroundView, at: 0)
        /*let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backgroundImage.bounds
        blurredEffectView.alpha = 0.7;
        view.insertSubview(blurredEffectView, at: 1)*/
        
        horizontalScrollerView.dataSource = self
        horizontalScrollerView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        WeatherAppAPI.shared.getForecast(city: "Paris"){ json in
            if json != nil
            {
                self.forecast = Forecast(json: json!)
                DispatchQueue.main.async {
                    self.horizontalScrollerView.reload()
                }
                
                if #available(iOS 11.0, *) {
                    //self.horizontalScrollerView.contentInsetAdjustmentBehavior = .never
                } else {
                    self.automaticallyAdjustsScrollViewInsets = false
                }
                
                /*DispatchQueue.main.async {
                    image.getBackgroundImage(weather: (day!.weather), view: self.view)
                    self.title = "Paris"
                    self.WeatherLabel.text = day!.weatherArray.first?.hourArray["description"]
                    self.TemperatureLabel.text = (day!.weatherArray.first?.hourArray["temperature"])! + "°"
                    image.getIconFromUrl(icon: (day!.weatherArray.first?.hourArray["icon"])!) { image in
                        if image != nil
                        {
                            DispatchQueue.main.async {
                                self.iconView.image = image
                            }
                        }
                    }
                    self.tableViewHour.reloadData()
                    self.tableViewDay.reloadData()
                }
                
                let userDefaults = UserDefaults.standard
                var encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.weatherDayArray)
                userDefaults.set(encodedData, forKey: "forecast")
                userDefaults.synchronize()
                
                encodedData = NSKeyedArchiver.archivedData(withRootObject: self.day)
                userDefaults.set(encodedData, forKey: "current")
                userDefaults.synchronize()*/
            }
            else
            {
                let alert = UIAlertController(title: "Error", message: "An error has occured, please make sure you are connected to the internet then restart the application", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                //self.detailBtn.isEnabled = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

extension ViewController: HorizontalScrollerViewDelegate {
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, didSelectViewAt index: Int) {
        
    }
}

extension ViewController: HorizontalScrollerViewDataSource {
    func numberOfViews(in horizontalScrollerView: HorizontalScrollerView) -> Int {
        if self.forecast != nil {
            return (forecast?.dailyForecast[0].hourlyForecast.count)!
        } else {
            return 0
        }
        
    }
    
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, viewAt index: Int) -> UIView {
        print(index)
        let hourlyForecast = forecast?.dailyForecast[0].hourlyForecast[index]
        let forecastView = ForecastView(frame: CGRect(x: 0, y: 0, width: horizontalScrollerView.frame.size.height - 10, height: horizontalScrollerView.frame.size.height - 10), iconUrl: hourlyForecast?.data.icon, hourText: (hourlyForecast?.getFormattedHour())!, temperatureText: (hourlyForecast?.data.temperature)!)
        return forecastView
    }
}
