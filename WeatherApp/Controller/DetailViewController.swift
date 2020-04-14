//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by pallavi sharma on 03/04/2020.
//  Copyright © 2020 pallavi sharma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var lblweatherTemp : UILabel!
    @IBOutlet var lblweatherDescription : UILabel!
    @IBOutlet var lblweatherMin : UILabel!
    @IBOutlet var lblweatherMax : UILabel!
    @IBOutlet var lblweatherWind : UILabel!
    @IBOutlet var lblweatherPressure : UILabel!
    @IBOutlet var lblweatherRealFeel : UILabel!
    @IBOutlet var lblweatherHumidity : UILabel!

    @IBOutlet var imgWeatherIcon : UIImageView!
    
    
    
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
        
        lblweatherTemp.text = weatherTemp
        lblweatherDescription.text = weatherDescripiton
        lblweatherMin.text = weatherMin
        lblweatherMax.text = weatherMax
        lblweatherWind.text = weatherWind
        lblweatherPressure.text = weatherPressure
        lblweatherRealFeel.text = weatherFeel
        lblweatherHumidity.text = weatherHumidity
        
        let link = "http://openweathermap.org"
        let weatherLogoUrlStr = link + "/img/wn/" + weatherImageStr + "@2x.png" as NSString;
        
        var urlStr : NSString = weatherLogoUrlStr.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        
        let weatherLogoUrl = NSURL(string: urlStr as String )
        

        DispatchQueue.global(qos: .background).async {
            let url = URL(string:urlStr as String)
            let data = try? Data(contentsOf: url!)
            let image: UIImage = UIImage(data: data!)!
            DispatchQueue.main.async {
                self.imgWeatherIcon!.image = image
            }
        }


    }
    

   

}
