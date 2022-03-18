//
//  HomeEndpointSpecifications.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation
import Moya

// MARK: - Provider Specifications
enum HomeEndpointSpecifications {
    case city(cityId: String)
    case addCity(name: String)
}

// MARK: - Provider release url
let releaseURL = "https://www.metaweather.com/api/" // in next feature we will save it in info.plist for any target schema.

// MARK: - Provider target type
extension HomeEndpointSpecifications: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: releaseURL)!
        }
    }

    var path: String {
        switch self {
        case .city(let cityId):
            return "location/\(cityId)/"
        case .addCity:
            return "location/search/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .city, .addCity:
            return .get
        }
    }

    // header
    var headers: [String : String]? {
        switch self {
        case .city, .addCity:
            return  nil
        }
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)! as Data
    }

    var task: Task {
        switch self {

        case .city:
            return .requestPlain
            
        case .addCity(let name):
            return .requestParameters(parameters: ["query" : name], encoding: URLEncoding.queryString)
        }
    }
}
