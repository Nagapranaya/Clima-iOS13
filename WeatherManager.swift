//
//  WeatherManager.swift
//  Clima
//
//  Created by Pranaya on 1/26/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
struct WeatherManager{
  let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=15bd41c5d030bb84c602444ae9752099&units=metric"
    
    func fetchWeather(cityName:String){
        let txtAppend = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        let urlString = "\(weatherURL)&q=\(txtAppend!)"
        print("urlString: "+urlString+".")
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String){
        let url = URL(string: urlString)
        print(url)
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)    
            
            let task = session.dataTask(with: url, completionHandler: handle( data: response: error:))
            
            task.resume()
            
        }
    }
    func handle(data: Data?, response: URLResponse?, error: Error?){
        if error != nil{
            print(error!)
            return
        }
        if let safeData = data {
            let dataString  = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
