//
//  DetailsViewModel.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class DetailsViewModel: DaysServicesDelegate {
    
    var cityId = ""
    var date = ""
    private let weatherDetailsEndPoints: WeatherDaysEndPoints = WeatherDaysEndPoints(provider: MoyaProvider<WeatherDaysEndpointSpecifications>(plugins: [CompleteUrlLoggerPlugin()]))
    
    let dayDetails: BehaviorSubject<[DayResponseModel]> = BehaviorSubject(value: [])
    let error: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    init(date: String, cityId: String) {
        self.date = date
        self.cityId = cityId
        
        weatherDetailsEndPoints.delegate = self
    
        InternetConnection.shared.startListening { connectionStatus in
            if connectionStatus == .connected {
                self.weatherDetailsEndPoints.getDay(cityId: cityId, day: date)
            } else {
                if let cachedModel = DefaultDetailsDayModelManger().get() as? [DayResponseModel] {
                    self.dayDetails.onNext(cachedModel)
                } else {
                    self.error.onNext("no internet connection")
                }
            }
        }
    }
    
    func didGetDayWithError(error: Error?) {
        self.error.onNext(error?.localizedDescription ?? "")
    }
    
    func didGetDay(city: [DayResponseModel]) {
        DefaultDetailsDayModelManger().save(file: city as [DayResponseModel])
        dayDetails.onNext(city)
    }
}
