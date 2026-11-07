//
//  NetworkService.swift
//  WhetherApp
//
//  Created by Мария Александрова on 14.09.2026.
//
import Foundation

class NetworkService {
    static let shared = NetworkService(); private init() { }
    private let apiKey = "db62dabd31df8fb479f62c62313413f7"
    private let gateway = "https://"
    private let server = "api.openweathermap.org"
    
    func createURL(city: String?, endpoint: Endpoint, unit: Units = .metric, lat: Double?, lon: Double?) -> URL? {
        let cityStr = city.map { "&q=\($0)" } ?? ""
        let latStr = lat.map{ "&lat=\($0)" } ?? ""
        let lonStr = lon.map{ "&lon=\($0)" } ?? ""
        var str = gateway + server + endpoint.rawValue
        str += "?appid=\(apiKey)\(cityStr)\(latStr)\(lonStr)&units=\(unit.rawValue)"
        let url = URL(string: str)
        return url
    }
    
    
    
    func getWeatherData(city: String) async throws -> WeatherData {
        guard let url = createURL(city: city, endpoint: .currentWeather, lat: nil, lon: nil) else {
            throw NetworkError.badUrl
        }
        let response = try await URLSession.shared.data(from: url)
        let data = response.0
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let weatherData = try? decoder.decode(WeatherData.self, from: data) else {
            throw NetworkError.invalidDecoding
        }
        return weatherData
    }
    
    func getWeatherFiveDays(lat: Double, lon: Double) async throws -> WeatherResponse {
        guard let url = createURL(city: nil, endpoint: .forecast, lat: lat, lon: lon) else {
            throw NetworkError.badUrl
        }
        let response = try await URLSession.shared.data(from: url)
        print(url)
        let data = response.0
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let weatherResponse = try? decoder.decode(WeatherResponse.self, from: data) else {
            throw NetworkError.invalidDecoding
        }
        return weatherResponse
    }
    
}

enum Endpoint: String {
    
    case currentWeather = "/data/2.5/weather"
    case forecast = "/data/2.5/forecast"
}

enum NetworkError: LocalizedError {
    case badUrl, badResponse, invalidDecoding
    
    var errorDescription: String? {
        switch self {
            case .badUrl: "badUrl"
            case .badResponse: "badResponse"
            case .invalidDecoding: "invalidDecoding"
        }
    }
}

enum Units: String {
    case standart = "standard"
    case metric = "metric"
    case imperial = "imperial"
}
