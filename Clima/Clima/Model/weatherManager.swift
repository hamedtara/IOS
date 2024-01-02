//
//  weatherManager.swift
//  Clima
//
//  Created by Hamed Tara on 2023-12-29.

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager :weatherManager,  weather: WeatherModel);
    func didFailedWithError(error:Error);
}

//http://api.openweathermap.org/data/2.5/weather?q=Tehran&appid=81c0a9769c9cd7ae492c3c216655b097&units=metric
struct weatherManager {
    
    var delegate : WeatherManagerDelegate?
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=81c0a9769c9cd7ae492c3c216655b097&units=metric"
    
    func fetchWeather (cityName: String){
        
        let urlString = "\(weatherUrl)&q=\(cityName)"
        
        performString(with: urlString);
        
        // print(urlString);
        
        
        
    }
    
    func  fetchWeather(latitude: CLLocationDegrees,longitude: CLLocationDegrees){
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude )"
        
        
        performString(with: urlString);
    }

    
    
    
    
    func performString(with urlString: String){
        // 1: Create a URL
        
        if let url = URL(string: urlString) {
            //2: URL Sesseion
            
            let session = URLSession(configuration: .default)
            
            
            //3: Give the session a task
            
            let task =  session.dataTask(with: url) { data, response, error in
                if (error != nil){
                    self.delegate?.didFailedWithError(error: error!)

                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJson(safeData){
                        let weatherVC = WeatherViewController();
                        self.delegate?.didUpdateWeather(self, weather: weather);
                        //weatherVC.didUpdateWeather(weather: weather);
                    }
                    
                }
            }
            
            //4: Start The Task
            
            task.resume();
            
            
        }
        
    }
    
    func parseJson(_ weatherData:Data) -> WeatherModel?{
        
        let decoder = JSONDecoder();
        do{
            
          let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp);
            
            let id = decodedData.weather[0].id;
            let temp = decodedData.main.temp;
            let name = decodedData.name;
            
            let weather = WeatherModel(conditionID: id, cityName: name , tempeture: temp)
            
            return weather
            
            
          //  print(weather.conditionName);
         //   print(weather.temperatureString)

            
        }catch{
            self.delegate?.didFailedWithError(error: error)

//            print(error)
            
            
            return nil
        }
        
    }
    
    
    }
    
    

