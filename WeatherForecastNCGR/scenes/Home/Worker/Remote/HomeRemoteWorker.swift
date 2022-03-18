//
//  HomeRemoteWorker.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation

class HomeRemoteWorker: HomeRemoteWorkerProtocol {

    var homeServiceProtocol: HomeServicesProtocol?
    
    weak var interactor: HomeRemoteWorkerOutputProtocol?
    
//    /// Initialize the worker with the required parameters to work properly
//    /// - Parameter : service protocol
    init(homeServiceProtocol: HomeServicesProtocol?) {
        self.homeServiceProtocol = homeServiceProtocol
    }
    
    func getHome(cityId: String) {
        homeServiceProtocol?.getHome(cityId: cityId)
    }
    
    func addNewCity(name: String) {
        homeServiceProtocol?.addNewCity(name: name)
    }
}

//// MARK: - Service Callbacks
//
extension HomeRemoteWorker: HomeServicesDelegate {
    func didGetHomeWithError(error: Error?) {
        interactor?.didGetHomeWithError(error: error)
    }
    
    func didGetHome(city: HomeResponseModel) {
        interactor?.didGetHome(city: city)
    }
    
    func cityId(id: String) {
        interactor?.cityId(id: id)
    }
    func cityIdError(error: Error?) {
        interactor?.cityIdError(error: error)
    }
}
