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
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
