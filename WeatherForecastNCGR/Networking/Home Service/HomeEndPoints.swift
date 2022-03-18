//
//  HomeEndPoints.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation
import Moya
import RxSwift

protocol HomeServicesProtocol {
    func getHome(cityId: String)
}

protocol HomeServicesDelegate: AnyObject {
    func didGetHomeWithError(error: Error?)
    func didGetHome(city: HomeResponseModel)
}

// MARK: - Provider support
class HomeEndPoints: HomeServicesProtocol {
    
    weak var delegate: HomeServicesDelegate?
    var provider = MoyaProvider<HomeEndpointSpecifications>(plugins: [CompleteUrlLoggerPlugin()])
    let disposed = DisposeBag()
    
    init(provider: MoyaProvider<HomeEndpointSpecifications>) {
        self.provider = provider
    }
    
    // MARK: - Methods
    func getHome(cityId: String) {
        provider.rx
            .request(.city(cityId: cityId))
            .filterSuccessfulStatusCodes()
            .timeout(.seconds(30), scheduler: MainScheduler.instance)
            .retry(2)
            .map(HomeResponseModel.self)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.delegate?.didGetHome(city: response)
                
            }) { [weak self] error in
                guard let self = self else { return }
                self.delegate?.didGetHomeWithError(error: error)
                
            }.disposed(by: disposed)
    }
}
