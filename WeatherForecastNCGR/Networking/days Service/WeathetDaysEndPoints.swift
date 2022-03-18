//
//  WeatherDaysEndPoints.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation
import Moya
import RxSwift

protocol DaysServicesProtocol {
    func getDay(cityId: String, day: String)
}

protocol DaysServicesDelegate: AnyObject {
    func didGetDayWithError(error: Error?)
    func didGetDay(city: [DayResponseModel])
}

// MARK: - Provider support
class WeatherDaysEndPoints: DaysServicesProtocol {

    weak var delegate: DaysServicesDelegate?
    var provider = MoyaProvider<WeatherDaysEndpointSpecifications>(plugins: [CompleteUrlLoggerPlugin()])
    let disposed = DisposeBag()
    
    init(provider: MoyaProvider<WeatherDaysEndpointSpecifications>) {
        self.provider = provider
    }
    
    // MARK: - Methods
    func getDay(cityId: String, day: String) {
        provider.rx
            .request(.days(cityId: cityId, day: day))
            .filterSuccessfulStatusCodes()
            .timeout(.seconds(30), scheduler: MainScheduler.instance)
            .retry(2)
            .map([DayResponseModel].self)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.delegate?.didGetDay(city: response)
                
            }) { [weak self] error in
                guard let self = self else { return }
                self.delegate?.didGetDayWithError(error: error)
                
            }.disposed(by: disposed)
    }
}
