//
//  DaysViewModel.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation
import RxSwift
import RxCocoa

class DaysViewModel {
    
    var daysModel: BehaviorSubject<HomeResponseModel?> = BehaviorSubject(value: nil)
    var daysDetailsModel: BehaviorSubject<[ConsolidatedWeather]> = BehaviorSubject(value: [])
    
    init(homeResponseModel: HomeResponseModel) {
        self.daysModel.onNext(homeResponseModel)
        if homeResponseModel.consolidatedWeather != nil {
            self.daysDetailsModel.onNext(homeResponseModel.consolidatedWeather!)
        }
    }
}
