//
//  WeatherView.swift
//  WhetherApp
//
//  Created by Мария Александрова on 14.09.2026.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel()
    
//    @StateObject var weather = WeatherResponseViewModel(lat: self.viewModel.weatherData?.coord.lat ?? nil, lon: self.viewModel.weatherData?.coord.lon ?? nil)
////
    
    
    var body: some View {
        VStack {
            Text(viewModel.weatherData?.name ?? "-")
                .font(.custom("AvenistNext-Bold", size: 24))
                .foregroundColor(.white)
            HStack {
                Text(viewModel.tempDescription(temp: viewModel.weatherData?.main.tempMin))
                    .font(.custom("AvenistNext-Bold", size: 20))
                    .padding()
                    .foregroundColor(.white)
                    .background {
                        Color("darkSeaColor").blur(radius: 10)
                    }
                Spacer()
                Text(viewModel.tempDescription(temp: viewModel.weatherData?.main.temp))
                    .font(.custom("AvenistNext-Bold", size: 80))
                    .padding(.vertical, 16)
                    .foregroundColor(.white)
                Spacer()
                Text(viewModel.tempDescription(temp: viewModel.weatherData?.main.tempMax))
                    .font(.custom("AvenistNext-Bold", size: 20))
                    .padding()
                    .foregroundColor(.white)
            }
            HStack {
                Text("Восход: \n\(viewModel.getTime(utc: viewModel.weatherData?.sys.sunrise))")
                    .font(.custom("AvenistNext-Regular", size: 16))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                VStack {
                    Text("\(viewModel.pressureDesc(viewModel.weatherData?.main.pressure)) мм рт.ст.")
                        .font(.custom("AvenistNext-Regular", size: 20))
                        .foregroundColor(.white)
                    Text(viewModel.weatherData?.weather[0].main ?? "-")
                        .font(.custom("AvenistNext-Bold", size: 20))
                        .foregroundColor(.white)
                    Text("\(viewModel.weatherData?.wind.speed.description ?? "-") м/с \(viewModel.getDirection())")
                        .font(.custom("AvenistNext-Regular", size: 24))
                        .foregroundColor(.white)
                }
                .padding()
                .background {
                    Color("darkSeaColor").blur(radius: 40)
                }
                .cornerRadius(40)
                Spacer()
                Text("Закат: \n\(viewModel.getTime(utc: viewModel.weatherData?.sys.sunset))")
                    .font(.custom("AvenistNext-Regular", size: 16))
                    .foregroundColor(.white)
                    .padding()
            }
            Spacer()
            List {
                ForEach(0 ..< viewModel.weatherResponse.count, id: \.self) { index in
                    cellView(with: viewModel.weatherResponse[index])
                        .listRowBackground(Color.darkSea)
                }
            }
            .listStyle(.plain)
            .cornerRadius(16)
//            .background(.clear)
            
//            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
//        .ignoresSafeArea(edges: .bottom)
//        .task {
//            //    await viewModel.loadWeather()
//            }
    }
}

extension WeatherView {
    func cellView(with weatherForecast: WeatherResponse.WeatherForecast) -> some View {
        return WeatherDayRow(day: DailyWeather(date: Date(timeIntervalSince1970: weatherForecast.dt),
                                        minTemperature: weatherForecast.main.tempMin,
                                        maxTemperature: weatherForecast.main.tempMax, rainProbability: weatherForecast.pop),
                      weekMax: viewModel.weakMax,
                      weekMin: viewModel.weakMin)
    }
}

#Preview {
    WeatherView()
}
