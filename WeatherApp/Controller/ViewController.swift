//
//  ViewController.swift
//  WeatherApp
//
//  Created by pallavi sharma on 30/03/2020.
//  Copyright © 2020 pallavi sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let imageCache = NSCache<NSString, UIImage>()

    var weatherData = [Weather]()
    
    @IBOutlet var tblWeatherData : UITableView!
    @IBOutlet var loadingActivity: UIActivityIndicatorView!
    
    
    var weatherTemp : String = ""
    var weatherDescripiton : String = ""
    var weatherMin : String  = ""
    var weatherMax : String  = ""
    var weatherWind : String  = ""
    var weatherPressure : String  = ""
    var weatherFeel : String  = ""
    var weatherHumidity : String  = ""
    
    var weatherImageStr : String  = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Paris weather"
        
        tblWeatherData.rowHeight = UITableView.automaticDimension
        tblWeatherData.estimatedRowHeight = 284

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Weather.getWeatherData(ofCity: "paris", success: { (weatherData_) in
            self.weatherData = weatherData_
            
            DispatchQueue.main.async {
                self.tblWeatherData?.reloadData()
                self.loadingActivity.isHidden = true

            }

        }) { (errorMessage) in
            let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
            DispatchQueue.main.async {
                self.loadingActivity.isHidden = true

            }
        }

    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }
    
     func tableView(tableView: UITableView, heightForRowAt: NSIndexPath) -> CGFloat
    {
        return 284
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherInfo = weatherData[indexPath.row]
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        
        let intValue = Int(weatherInfo.feels_like ?? 0)
        weatherCell.lblWeatherTemp.text =  "\( intValue )" + "°"
        weatherCell.lblweatherDate?.text = weatherInfo.dt_txt
        weatherCell.lblWeatherDescription?.text = weatherInfo.description

        let weatherLogo = weatherInfo.icon! as String
        
        let link = "http://openweathermap.org"
                                   let weatherLogoUrlStr = link + "/img/wn/" + weatherLogo + "@2x.png" as NSString;
        
        var urlStr : NSString = weatherLogoUrlStr.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        
        let weatherLogoUrl = NSURL(string: urlStr as String )
        if let cachedImage = imageCache.object(forKey:  urlStr as String as NSString) {

            weatherCell.imgWeatherIcon!.image = cachedImage as UIImage
        }
else{
        DispatchQueue.global(qos: .background).async {
            let url = URL(string:urlStr as String)
            let data = try? Data(contentsOf: url!)
            let image: UIImage = UIImage(data: data!)!
            DispatchQueue.main.async {
                 self.imageCache.setObject(image, forKey: NSString(string:urlStr as String))
               // self.weatherImage = image
                    weatherCell.imgWeatherIcon!.image = image
            }
        }

    }
        
        return weatherCell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        let weatherInfo = weatherData[indexPath.row]
        
        

        let tempintValue = Int(weatherInfo.temp ?? 0)
        let minintValue = Int(weatherInfo.temp_max ?? 0)
        let maxintValue = Int(weatherInfo.temp_min ?? 0)
        let feelintValue = Int(weatherInfo.feels_like ?? 0)

        weatherImageStr = weatherInfo.icon! as String
        
        weatherTemp = "\( tempintValue )" + "°"
        weatherMin = "\( minintValue )" + "°"
        weatherMax = "\( maxintValue )" + "°"
        weatherFeel = "\( feelintValue )" + "°"
        weatherDescripiton = weatherInfo.description!
        weatherHumidity = "\( weatherInfo.humidity ?? 0 )"
        weatherWind = "\( weatherInfo.speed ?? 0 )"
        weatherPressure = "\( weatherInfo.pressure ?? 0)"
        
        

        performSegue(withIdentifier: "detailView", sender: self)

    }
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailView") {
            let viewController = segue.destination as! DetailViewController
            
            viewController.weatherTemp = weatherTemp
            viewController.weatherMin = weatherMin
            viewController.weatherMax = weatherMax
            viewController.weatherPressure = weatherPressure
            viewController.weatherWind = weatherWind
            viewController.weatherHumidity = weatherHumidity
            viewController.weatherDescripiton = weatherDescripiton
            viewController.weatherFeel = weatherFeel
            
            viewController.weatherImageStr = weatherImageStr
        }
       }
    
    
}
