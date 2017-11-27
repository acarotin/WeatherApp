//
//  ViewController.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/22/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cityLabel: UILabel!
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
        
        horizontalScrollerView.dataSource = self
        horizontalScrollerView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        WeatherAppAPI.shared.getForecast(city: "Paris"){ json in
            if json != nil
            {
                self.forecast = Forecast(json: json!)
                DispatchQueue.main.async {
                    
                    self.horizontalScrollerView.reload()
                    self.cityLabel.text = "Paris"
                    self.weatherLabel.text = self.forecast?.weather
                    self.tempLabel.text = "\((self.forecast?.dailyForecast[0].hourlyForecast[0].data.temperature)!)º"
                    
                    
                }
                
                if #available(iOS 11.0, *) {
                    //self.horizontalScrollerView.contentInsetAdjustmentBehavior = .never
                } else {
                    self.automaticallyAdjustsScrollViewInsets = false
                }
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

/*extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        if tableView == self.tableViewHour {
            if (weatherDayArray.count > 0) {
                count = weatherDayArray.first?.weatherArray.count
            }
            else {
                count = weatherDayArray.count
            }
        }
        else {
            count = weatherDayArray.count
        }
        return count!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableViewHour
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "hourCell", for: indexPath) as! HourTableViewCell
            let hour = weatherDayArray.first?.weatherArray[indexPath.row]
            cell.hourCell = hour
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! DayTableViewCell
            let day = weatherDayArray[indexPath.row]
            cell.dayCell = day
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Daily Forecast"
    }
}*/

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
        let forecastView = ForecastView(frame: CGRect(x: 0, y: 0, width: horizontalScrollerView.frame.size.height - 10, height: horizontalScrollerView.frame.size.height - 10), iconUrl: hourlyForecast?.data.icon, hourText: (hourlyForecast?.hour)!, temperatureText: (hourlyForecast?.data.temperature)!)
        return forecastView
    }
}
