//
//  WeatherManager.swift
//  Clima
//
//  Created by Pranaya on 1/26/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_weatherManager:WeatherManager,weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=15bd41c5d030bb84c602444ae9752099&units=metric"
     
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName:String){
        let txtAppend = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let urlString = "\(weatherURL)&q=\(txtAppend!)"
        print("urlString: "+urlString+".")
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            //let task = session.dataTask(with: url, completionHandler: handle( data: response: error:))
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let weather = self.parseJson(weatherData: safeData){
                        self.delegate?.didUpdateWeather(_weatherManager: self, weather: weather)
                    }
                }
            }
            
            task.resume()
            
        }
    }
    func parseJson(weatherData:Data)-> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            print(decodedData.main.temp)
            let id = decodedData.weather[0].id
            print("weather id :", +id)
            let name = decodedData.name
            print(decodedData.name)
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            print(weather.conditionName)
            print(weather.temperatureString)
            return weather
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
        
    }
}

