////
////  WeatherResponseViewModel.swift
////  WhetherApp
////
////  Created by Мария Александрова on 15.09.2026.
////
//
//import Foundation
//import Combine
//
//@MainActor
//class WeatherResponseViewModel: ObservableObject {
//    
//    @Published var weather: WeatherResponse?
//    
//    init(lat: Double?, lon: Double?) {
//        print()
//        guard let lat, let lon else { return }
//        Task {
//            do {
//                let data = try await NetworkService.shared.getWeatherFiveDays(lat: lat, lon: lon)
//                self.weather = data
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func tempDescription(temp: Double?) -> String {
//        guard let temp else {
//            return "-"
//        }
//        let result = "\(Int(temp))°C"
//        return result
//    }
//    
//    func pressureDesc(_ pressure: Double?) -> String {
//        guard let pressure else { return "-" }
//        return String(Int(pressure * 0.75))
//        
//    }
//    
////    func getDirection() -> String {
////        let deg = Double(self.weatherData?.wind.deg ?? 0)
////        
////        switch deg {
////            case 22.6 ... 67.5: return "СВ"
////            case 67.6 ... 112.5: return "В"
////            case 112.6 ... 157.5: return "ЮВ"
////            case 157.6 ... 202.5: return "Ю"
////            case 202.6 ... 247.5: return "ЮЗ"
////            case 247.6 ... 292.5: return "З"
////            case 292.6 ... 337.5: return "СЗ"
////            default: return "С"
////        }
////    }
//    
//    func getTime(utc: Int?) -> String {
//        guard let utc else { return "" }
//        
//        let date = Date(timeIntervalSince1970: TimeInterval(integerLiteral: Int64(utc)))
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH.mm"
//        let str = formatter.string(from: date)
//        return str
//    }
//    
//    
//    
//}
//
//
