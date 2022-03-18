//
//  WeatherDaysEndpointSpecifications.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//


import Foundation
import Moya

// MARK: - Provider Specifications
enum WeatherDaysEndpointSpecifications {
    case days(cityId: String, day: String)
}

// MARK: - Provider target type
extension WeatherDaysEndpointSpecifications: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: releaseURL)!
        }
    }

    var path: String {
        switch self {
        case .days(let cityId, let day):
            return "location/\(cityId)/\(day)/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .days:
            return .get
        }
    }

    // header
    var headers: [String : String]? {
        switch self {
        case .days:
            return  nil
        }
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)! as Data
    }

    var task: Task {
        switch self {

        case .days:
            return .requestPlain
        }
    }
}
