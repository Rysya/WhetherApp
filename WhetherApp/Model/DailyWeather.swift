//
//  DailyWeather.swift
//  WhetherApp
//
//  Created by Мария Александрова on 15.09.2026.
//
import Foundation

struct DailyWeather: Identifiable {

    let id = UUID()
    let date: Date
    let minTemperature: Double
    let maxTemperature: Double
    let rainProbability: Double
    
    
}

extension DailyWeather {

    var weekday: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "EE"

        return formatter.string(from: date)
            .uppercased()
    }

}
