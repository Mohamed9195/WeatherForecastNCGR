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
    func addNewCity(name: String)
}

protocol HomeServicesDelegate: AnyObject {
    func didGetHomeWithError(error: Error?)
    func didGetHome(city: HomeResponseModel)
    func cityId(id: String)
    func cityIdError(error: Error?)
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
    
    func addNewCity(name: String) {
        provider.rx
            .request(.addCity(name: name))
            .filterSuccessfulStatusCodes()
            .timeout(.seconds(30), scheduler: MainScheduler.instance)
            .retry(2)
            .map([AddCityModel].self)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.delegate?.cityId(id: String(response.first?.woeid ?? 0))
                
            }) { [weak self] error in
                guard let self = self else { return }
                self.delegate?.cityIdError(error: error)
                
            }.disposed(by: disposed)
    }
}
