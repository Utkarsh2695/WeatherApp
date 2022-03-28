//
//  WeatherReportModel.swift
//  WeatherLookup
//
//  Created by Utkarsh Upadhyay (BLR GSS) on 20/03/22.
//

import Foundation

struct WeatherReport: Codable {
    let hourly: [HourlyWeatherReport]?
}


struct HourlyWeatherReport: Codable {
    let temp: Double?
    let feelsLike: Double?
    let humidity: Double?
    let clouds: Double?

    let weather: [WeatherDescription]?

    private enum CodingKeys: String, CodingKey {
        case temp, humidity, clouds, weather
        case feelsLike = "feels_like"
    }
}

struct WeatherDescription: Codable {
    let description: String?
    let main: String?
}
