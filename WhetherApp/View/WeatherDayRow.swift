//
//  WeatherDayCell.swift
//  WhetherApp
//
//  Created by Мария Александрова on 15.09.2026.
//

import SwiftUI

struct WeatherDayRow: View {
    
    let day: DailyWeather
    let weekMax, weekMin: Double
    
           var body: some View {
               HStack(spacing: 16) {
                   // День недели
                   Text(day.weekday)
                       .font(.system(size: 18, weight: .bold))
                       .padding(.leading, 10)
                       .foregroundColor(.white)
                   // Вероятность дождя
                   Text("\(Int(day.rainProbability * 100))%")
                       .font(.system(size: 18, weight: .bold))
                       .foregroundColor(.white)
                   // Минимальная температура
                   Text("+\(Int(day.minTemperature))°C")
                       .font(.system(size: 18, weight: .bold))
                       .foregroundColor(.white)
                   // Температурная шкала
                   TemperatureRangeBar(
                    minTemperature: day.minTemperature,
                    maxTemperature: day.maxTemperature,
                       scaleMin: weekMin,
                       scaleMax: weekMax
                   )
                   // Максимальная температура
                   Text("+\(Int(day.maxTemperature))°C")
                       .font(.system(size: 18, weight: .bold))
                       .padding(.trailing, 10)
                       .foregroundColor(.white)
               }
               .padding(.horizontal, 0)
               .padding(.vertical, 5)
               .tint(.white)
               .frame(maxWidth: .infinity)
           }
    }



#Preview {
    let day = DailyWeather.init(date: Date.init(timeIntervalSince1970: 1789470577), minTemperature: 15, maxTemperature: 19, rainProbability: 0.80)
    
    WeatherDayRow(
        day: day,
//        timezone: TimeZone.init(secondsFromGMT: 10800) ?? .current,
//        rainProbability: 0.80,
        weekMax: 20,
        weekMin: 13
    )
//    TemperatureRangeBar(
//        minTemperature: day.minTemperature,
//        maxTemperature: day.maxTemperature,
//        scaleMin: 13,
//        scaleMax: 21
//    )
}
