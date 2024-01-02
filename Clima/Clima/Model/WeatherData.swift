//
//  WeatherData.swift
//  Clima
//
//  Created by Hamed Tara on 2023-12-30.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather:[ Weather]
}

struct Main: Codable{
    let temp: Double
}

struct Weather:Codable{
    let id : Int
}
