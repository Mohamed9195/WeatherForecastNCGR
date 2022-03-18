//
//  DaysResponceModel.swift
//  WeatherForecastNCGR
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation

struct DayResponseModel: Codable {
    let id: Int?
    let weatherStateName: String?
    let weatherStateAbbreviation: String?
    let windDirectionCompass: String?
    let created, applicableDate: String?
    let minTemp, maxTemp, theTemp: Double?
    let windSpeed, windDirection: Double?
    let airPressure, humidity: Int?
    let visibility: Double?
    let predictability: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case weatherStateName = "weather_state_name"
        case weatherStateAbbreviation = "weather_state_abbr"
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
