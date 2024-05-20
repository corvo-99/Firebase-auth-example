//
//  WeatherModel.swift
//  WeatherKitTest
//
//  Created by Dylan Corvo on 17/04/24.
//
import Foundation
import WeatherKit

struct DayWeather {
    let currentTemperature: Measurement<UnitTemperature>
    let currentFeelsLikeTemperature: Measurement<UnitTemperature>
    let lowTemperature: Measurement<UnitTemperature>
    let highTemperature: Measurement<UnitTemperature>
    let precipitationChance: Double
    let rainfallAmount: Measurement<UnitLength>
    let snowfallAmount: Measurement<UnitLength>
    let wind: Wind
}





//MARK: do not use HourWeather. instead for the feelsLikeTemperature use: hourlyFeelsLikeTemperature
struct HourWeather {
    let date: Date?
    let apparentTemperature: Measurement<UnitTemperature>

        init(date: Date, apparentTemperature: Measurement<UnitTemperature>) {
            self.date = date
            self.apparentTemperature = apparentTemperature
        }
}
