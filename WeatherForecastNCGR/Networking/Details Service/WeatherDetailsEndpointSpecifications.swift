//
//  WeatherDetailsEndpointSpecifications.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation
import Moya

// MARK: - Provider Specifications
enum WeatherDetailsEndpointSpecifications {
    case dateDetails(cityId: String, date: String)
}

// MARK: - Provider target type
extension WeatherDetailsEndpointSpecifications: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: releaseURL)!
        }
    }

    var path: String {
        switch self {
        case .dateDetails(let cityId, let date):
            return "location/\(cityId)/\(date)/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .dateDetails:
            return .get
        }
    }

    // header
    var headers: [String : String]? {
        switch self {
        case .dateDetails:
            return  ["" : ""]
        }
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)! as Data
    }

    var task: Task {
        switch self {

        // send request as by parameter as query
        case .dateDetails:
            return .requestPlain

        }
    }
}
