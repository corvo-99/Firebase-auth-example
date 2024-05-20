//
//  WeatherViewModel.swift
//  WeatherKitTest
//
//  Created by Dylan Corvo on 15/04/24.
//

import WeatherKit
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var dayWeather: DayWeather?
    @Published var hourlyWeatherData: [HourWeather]?
    @Published var hourWeather: HourWeather?
    private let weatherService = WeatherService()
    private var locationViewModel = LocationViewModel()
    
    init() {
        self.dayWeather = nil
    }
    
    func fetchCurrentWeather() {
        Task {
            do {
                if let location = locationViewModel.location {
                    let weather = try await weatherService.weather(for: location)
                    DispatchQueue.main.async { [weak self] in
                        var hourlyWeatherData: [HourWeather] = []
                        
                        self?.dayWeather = DayWeather(
                            currentTemperature: weather.currentWeather.temperature.converted(to: .celsius),
                            currentFeelsLikeTemperature: weather.currentWeather.apparentTemperature.converted(to: .celsius),
                            lowTemperature: weather.dailyForecast[0].lowTemperature.converted(to: .celsius),
                            highTemperature: weather.dailyForecast[0].highTemperature.converted(to: .celsius),
                            precipitationChance: weather.dailyForecast[0].precipitationChance,
                            rainfallAmount: weather.dailyForecast[0].precipitationAmount.converted(to: .millimeters),
                            snowfallAmount: weather.dailyForecast[0].snowfallAmount.converted(to: .millimeters),
                            wind: weather.dailyForecast[0].wind
                        )
                        
                        for forecast in weather.hourlyForecast {
                            let hourWeather = HourWeather(date: forecast.date, apparentTemperature: forecast.apparentTemperature)
                            hourlyWeatherData.append(hourWeather)
                        }
                        
                        let extractor = WeatherDataExtractor()
                        extractor.extractHourlyData(from: hourlyWeatherData)
                    }
                }
            } catch {
                print("Error fetching forecast: \(error)")
            }
        }
    }
}

class WeatherDataExtractor {
    @Published var hourlyFeelsLikeTemperature: [Double] = []
    
    func extractHourlyData(from hourlyWeatherData: [HourWeather]?) {
        guard let hourlyWeatherData = hourlyWeatherData else { return }
        
        let endOfTheDay = Calendar.current.startOfDay(for: Date()).addingTimeInterval(24 * 60 * 60)
        let endOfTomorrow = Calendar.current.startOfDay(for: endOfTheDay).addingTimeInterval(24 * 60 * 60)
        
        let extractedData = hourlyWeatherData.compactMap { forecast -> Double? in
            guard let forecastDate = forecast.date,
                  forecastDate >= Date() && forecastDate < endOfTomorrow else {
                      return nil
                  }
            return forecast.apparentTemperature.converted(to: .celsius).value
        }
        
        hourlyFeelsLikeTemperature = extractedData
        print("Feels like temp: \(hourlyFeelsLikeTemperature)")
    }
}
