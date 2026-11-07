//
//  WeatherViewModel.swift
//  WhetherApp
//
//  Created by Мария Александрова on 14.09.2026.
//

import Foundation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    
    @Published var weatherData: WeatherData?
    @Published var weatherResponse: [WeatherResponse.WeatherForecast] = []
    var weakMin: Double = Double(Int.max)
    var weakMax: Double = Double(Int.min)
        
    init(city: String = "Moscow") {
        Task {
            do {
                let data = try await NetworkService.shared.getWeatherData(city: city)
                self.weatherData = data
                guard let lat = weatherData?.coord.lat, let lon = weatherData?.coord.lon
                else {
                    print("нет никаких lat и lon")
                    return
                }
                let dataFiveDays = try await NetworkService.shared.getWeatherFiveDays(lat: lat, lon: lon)
                let weatherResponse = formatToDays(with: dataFiveDays.list)
                self.weatherResponse = weatherResponse
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func formatToDays(with weatherResponse: [WeatherResponse.WeatherForecast]) -> [WeatherResponse.WeatherForecast] {
        var result: [WeatherResponse.WeatherForecast] = []
        var currentDay: (String, WeatherResponse.WeatherForecast?) = ("", nil)

        weatherResponse.enumerated().forEach { index, weatherForecast in
            let dayString = String(weatherForecast.dtTxt.prefix(10))
            guard index != 0 else {
                currentDay = (dayString, weatherForecast)
                return
            }
            guard let currentWeatherResponse = currentDay.1 else { return }
            
            switch dayString == currentDay.0 {
                case true:
                    var currentTempMin = currentWeatherResponse.main.tempMin
                    if weatherForecast.main.tempMin < currentTempMin {
                        currentTempMin = weatherForecast.main.tempMin
                    }
                    var currentTempMax = currentWeatherResponse.main.tempMax
                    if weatherForecast.main.tempMax > currentTempMax {
                        currentTempMax = weatherForecast.main.tempMax
                    }
                    currentDay.1?.main.tempMin = currentTempMin
                    currentDay.1?.main.tempMax = currentTempMax
                    
                    if index == weatherResponse.count - 1 {
                        fallthrough
                    }
                case false:
                    result.append(currentWeatherResponse)
                    weakMin = weakMin <= currentWeatherResponse.main.tempMin
                    ? weakMin
                    : currentWeatherResponse.main.tempMin
                    weakMax = weakMax >= currentWeatherResponse.main.tempMax
                    ? weakMax
                    : currentWeatherResponse.main.tempMax
                    currentDay = (dayString, weatherForecast)
            }
        }

        return result
    }
    
    func tempDescription(temp: Double?) -> String {
        guard let temp else {
            return "-"
        }
        let result = "\(Int(temp))°C"
        return result
    }
    
    func pressureDesc(_ pressure: Double?) -> String {
        guard let pressure else { return "-" }
        return String(Int(pressure * 0.75))
        
    }
    
    func getDirection() -> String {
        let deg = Double(self.weatherData?.wind.deg ?? 0)
        
        switch deg {
            case 22.6 ... 67.5: return "СВ"
            case 67.6 ... 112.5: return "В"
            case 112.6 ... 157.5: return "ЮВ"
            case 157.6 ... 202.5: return "Ю"
            case 202.6 ... 247.5: return "ЮЗ"
            case 247.6 ... 292.5: return "З"
            case 292.6 ... 337.5: return "СЗ"
            default: return "С"
        }
    }
    
    func getTime(utc: TimeInterval?) -> String {
        guard let utc else { return "" }
        
        let date = Date(timeIntervalSince1970: TimeInterval(integerLiteral: Int64(utc)))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH.mm"
        let str = formatter.string(from: date)
        return str
    }
    
    func loadWeather() async -> (lat: Double?, lon: Double?) {
        guard let coord = weatherData?.coord else { return (nil, nil) }
        return (lat: coord.lat, lon: coord.lon)
    }
}

