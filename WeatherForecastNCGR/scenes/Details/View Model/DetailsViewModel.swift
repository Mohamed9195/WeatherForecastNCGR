//
//  DetailsViewModel.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation
//
//var cityId: String = ""
//private let weatherDaysEndPoints = WeatherDaysEndPoints(provider: MoyaProvider<WeatherDaysEndpointSpecifications>(plugins: [CompleteUrlLoggerPlugin()]))
//
//let days : PublishSubject<[DayResponseModel]> = PublishSubject()
//let error : PublishSubject<String> = PublishSubject()
//
//init(cityId: String) {
//    self.cityId = cityId
//    weatherDaysEndPoints.delegate = self
//    
//    InternetConnection.shared.startListening { connectionStatus in
//        if connectionStatus == .connected {
//            self.weatherDaysEndPoints.getDay(cityId: <#T##String#>, day: <#T##String#>)
//        } else {
//            self.view?.didGetHomeWithError(error: "no internet connection")
//        }
//    }
//}
//
//func didGetDayWithError(error: Error?) {
//    self.error.onNext(error?.localizedDescription ?? "")
//}
//
//func didGetDay(city: [DayResponseModel]) {
//    days.onNext(city)
//}
