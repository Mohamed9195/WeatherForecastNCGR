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
    
    case test
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
        case .test:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .test:
            return .get
        }
    }

    // header
    var headers: [String : String]? {
        switch self {
        case .test:
            return  ["" : ""]
        }
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)! as Data
    }

    var task: Task {
        switch self {

        // send request as by parameter as query
        case .test:
            return .requestPlain
        }
    }
}
