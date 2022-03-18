//
//  WeatherDetailsEndPoints.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation
import Moya
import RxSwift


// MARK: - Provider support
class WeatherDetailsEndPoints {

    static var shared = WeatherDetailsEndPoints()

    let provider = MoyaProvider<WeatherDetailsEndpointSpecifications>(plugins: [CompleteUrlLoggerPlugin()])
}

class CompleteUrlLoggerPlugin : PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        print("##URL", request.request?.url?.absoluteString ?? "Something is wrong","  ##Body", request.request?.httpBody ?? "Something is wrong", "  ##header", request.request?.headers as Any)
    }
}
