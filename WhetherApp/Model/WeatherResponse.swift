//
//  WeatherResponse.swift
//  WhetherApp
//
//  Created by Мария Александрова on 14.09.2026.
//

import Foundation

struct WeatherResponse: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [WeatherForecast]
    let city: City
    
    struct WeatherForecast: Decodable {
        let dt: TimeInterval
        var main: MainWeather
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let pop: Double
        let sys: Sys
        let dtTxt: String
    }
    
    struct MainWeather: Decodable {
        let temp: Double
        let feelsLike: Double
        var tempMin: Double
        var tempMax: Double
        let pressure: Int
        let seaLevel: Int
        let grndLevel: Int
        let humidity: Int
        let tempKf: Double
        let dewPoint: Double
    }
    
    struct Weather: Identifiable, Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct City: Identifiable, Decodable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population: Int
        let timezone: Int
        let sunrise: TimeInterval
        let sunset: TimeInterval
    }
    
    struct Coord: Decodable {
        let lat: Double
        let lon: Double
    }
    
    struct Wind: Decodable {
        let speed: Double
        let deg: Int
        let gust: Double
    }
    
    struct Sys: Decodable {
        let pod: String
    }
    
    struct Clouds: Decodable {
        let all: Int
    }
}
