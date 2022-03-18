//
//  HomeResponseModel.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation

struct HomeResponseModel: Codable {
    var consolidatedWeather: [ConsolidatedWeather]?
    var time, sunRise, sunSet, timezoneName: String?
    var parent: Parent?
    var sources: [Source]?
    var title, locationType: String?
    var woeid: Int?
    var lattLong, timezone: String?

    enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather"
        case time
        case sunRise = "sun_rise"
        case sunSet = "sun_set"
        case timezoneName = "timezone_name"
        case parent, sources, title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
        case timezone
    }
}

// MARK: - ConsolidatedWeather
struct ConsolidatedWeather: Codable {
    var id: Int?
    var weatherStateName, weatherStateAbbr, windDirectionCompass, created: String?
    var applicableDate: String?
    var minTemp, maxTemp, theTemp, windSpeed: Double?
    var windDirection, airPressure: Double?
    var humidity: Int?
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

// MARK: - Parent
struct Parent: Codable {
    var title, locationType: String?
    var woeid: Int?
    var lattLong: String?

    enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
    }
}

// MARK: - Source
struct Source: Codable {
    var title, slug: String?
    var url: String?
    var crawlRate: Int?

    enum CodingKeys: String, CodingKey {
        case title, slug, url
        case crawlRate = "crawl_rate"
    }
}

struct AddCityModel: Codable {
    var title, locationType: String
    var woeid: Int
    var lattLong: String

    enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
    }
}
