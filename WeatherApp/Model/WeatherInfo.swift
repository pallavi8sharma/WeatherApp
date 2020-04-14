//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by pallavi sharma on 01/04/2020.
//  Copyright © 2020 pallavi sharma. All rights reserved.
//

import Foundation

class Weather {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
    let dt_txt: String?

    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Int?
    let sea_level: Int?
    let grnd_level: Int?
    let humidity: Int?
    let temp_kf: Double?
    let all: Int?
    let speed: Double?
    let deg: Int?
    let pod: String?

        
    init(withJSON json: [String: Any] , waeatherDate : String, mainInfo :[String: Any], cloudsInfo: [String: Any], windInfo: [String: Any], sysInfo: [String: Any] ) {
        
        print(json)
        print(mainInfo)
        
        self.id             = json["id"] as? Int ?? 0
        self.main           = json["main"] as? String ?? ""
        self.description    = json["description"] as? String ?? ""
        self.icon           = json["icon"] as? String ?? ""
        self.dt_txt         = waeatherDate
        
        self.temp           = mainInfo["temp"] as? Double ?? 0.00
        self.feels_like           = mainInfo["feels_like"] as? Double ?? 0.00
        self.temp_min           = mainInfo["temp_min"] as? Double ?? 0.00
        self.temp_max           = mainInfo["temp_max"] as? Double ?? 0.00
        self.pressure           = mainInfo["pressure"] as? Int ?? 0
        self.sea_level           = mainInfo["sea_level"] as? Int ?? 0
        self.grnd_level           = mainInfo["grnd_level"] as? Int ?? 0
        self.humidity           = mainInfo["humidity"] as? Int ?? 0
        self.temp_kf           = mainInfo["temp_kf"] as? Double ?? 0.00
        self.all           = cloudsInfo["all"] as? Int ?? 0
        self.speed           = windInfo["speed"] as? Double ?? 0.00
        self.deg           = windInfo["deg"] as? Int ?? 0
        self.pod           = sysInfo["pod"] as? String ?? ""

        let defaults = UserDefaults.standard
        defaults.set(self.id, forKey: "id")
        defaults.set(self.main, forKey: "main")
        defaults.set(self.description, forKey: "description")
        defaults.set(self.icon, forKey: "icon")
        defaults.set(self.dt_txt, forKey: "dt_txt")

    }
   
}


extension Weather {
    
    class func getWeatherData(ofCity: String, success: @escaping (_ weatherItems: [Weather]) -> (), failure: @escaping (_ errorMessage: String) -> ()) {
        let forecastAPI = Const.FORECAST + "?q=\(ofCity)" + "&units=metric&lang=fr" + "&appid=\(Const.openWeatherMapAPIKey)";
        
        HTTP.get(api: forecastAPI, success: { (json) in
            
            let apiStatusCode = json["cod"] as? String
            if apiStatusCode == "200" { 
                
                if let listOfWeatherInfo = json["list"] as? [[String: Any]] {
                    
                    var weatherInfo = [Weather]()
                    for jsonWeatherInfo in listOfWeatherInfo {
                        
                        if let weatherObject = jsonWeatherInfo["weather"] as? [[String: Any]] {
                            
                            
                            let mainInfo = jsonWeatherInfo["main"] as! [String: Any]
                            
                            let cloudsINfo = jsonWeatherInfo["clouds"] as! [String: Any]
                            let windInfo = jsonWeatherInfo["wind"] as! [String: Any]
                            let sysInfo = jsonWeatherInfo["sys"] as! [String: Any]

                            
                            
                            
                            let weatherDate = jsonWeatherInfo["dt_txt"] as! String
                            var fomattedWeatherDate : String = ""
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let dateFormatterPrint = DateFormatter()
                            dateFormatterPrint.dateFormat = "MMM dd"
                            if let date = dateFormatterGet.date(from:weatherDate) {
                                 fomattedWeatherDate =  dateFormatterPrint.string(from: date)
                            } else {
                               print("There was an error decoding the string")
                            }

                            
                            let defaults = UserDefaults.standard
                            if let dateForWeather = defaults.string(forKey:"dt_txt") {
                                print(dateForWeather) // Some String Value
                                
                                if dateForWeather == fomattedWeatherDate{
                                    
                                }else{
                                
                                if let firstObject = weatherObject.first {
                                    let weather = Weather(withJSON: firstObject,waeatherDate: fomattedWeatherDate, mainInfo: mainInfo, cloudsInfo: cloudsINfo, windInfo: windInfo, sysInfo: sysInfo)
                                    weatherInfo.append(weather)
                                }

                                }
                                
                            }
                        }
                        

                    }

                    
                    success(weatherInfo)
                } else {
                    failure("No weather infomration available for \(ofCity)")
                }
                
            }

            
        }, failure: failure)
        
    }
        
        
    
}
