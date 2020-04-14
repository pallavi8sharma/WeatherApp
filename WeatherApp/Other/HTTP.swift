//
//  HTTP.swift
//  WeatherApp
//
//  Created by pallavi sharma on 01/04/2020.
//  Copyright © 2020 pallavi sharma. All rights reserved.
//

import Foundation

class HTTP {

    class func get(api: String, success: @escaping (_ json: [String: Any]) -> (), failure: @escaping (_ errorMessage: String) -> () ) {
        let session = URLSession.shared
                
                  let weatherRequestURL = URLRequest(url: URL(string: api)!)
                
                  let dataTask = session.dataTask(with: weatherRequestURL){
                  (data, response, error) in
                  if data != nil  {
                        do {
                                if  let json = try JSONSerialization.jsonObject(with: data!, options:[]) as? [String: Any]{
                                success(json)
                                }
                          
                          } catch let error as NSError {
                                failure("Failed to load: \(error.localizedDescription)")
                          }
                    }else{
                            failure("Server not responding")
                         }

                }
                dataTask.resume()
        
    }
}


