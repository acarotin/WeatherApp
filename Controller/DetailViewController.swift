//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/29/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var weather : WeatherData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundView = BackgroundView()
        self.view.insertSubview(backgroundView, at: 0)
        
        tableView.dataSource = self.weather
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        self.title = weather?.city
        self.weatherLabel.text = weather?.weather
        self.temperatureLabel.text = weather?.temperatureAsTxt
        self.weatherLabel.textColor = UIColor.white
        self.temperatureLabel.textColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = UIColor.clear
    
    }
    
}
