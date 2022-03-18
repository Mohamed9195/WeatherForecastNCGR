//
//  WeatherDaysEndPoints.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation
import Moya
import RxSwift

// MARK: - Provider support
class WeatherDaysEndPoints {

    static var shared = WeatherDaysEndPoints()

    let provider = MoyaProvider<WeatherDaysEndpointSpecifications>(plugins: [CompleteUrlLoggerPlugin()])
}
