//
//  WeatherDetailsResponceModel.swift
//  WeatherForecastNCGR
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation

struct WeatherDetailsResponseModel {
    var id: Int
    var weatherStateName: String?
    var weatherStateAbbr: String?
    var windDirectionCompass: String?
    var created, applicableDate: String?
    var minTemp, maxTemp, theTemp: Double?
    var windSpeed, windDirection: Double?
    var airPressure, humidity: Int?
    var visibility: Double?
    var predictability: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case windDirectionCompass = "wind_direction_compass"
        case created
        case applicableDate = "applicable_date"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case theTemp = "the_temp"
        case windSpeed = "wind_speed"
        case windDirection = "wind_direction"
        case airPressure = "air_pressure"
        case humidity, visibility, predictability
    }
}
