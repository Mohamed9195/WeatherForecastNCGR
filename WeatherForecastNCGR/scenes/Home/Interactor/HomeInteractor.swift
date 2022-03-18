//
//  HomeInteractor.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation

class HomeInteractor: HomeInteractorProtocol {
    
    weak var presenter: HomeInteractorOutputProtocol?
    var remoteWorker: HomeRemoteWorkerProtocol?
    
    /// Initialize the interactor with the required parameters to work properly
    /// - Parameter remoteWorker: The remote worker to load the data remotely
    init(remoteWorker: HomeRemoteWorkerProtocol) {
        self.remoteWorker = remoteWorker
    }
    
    func getHome(cityId: String) {
        remoteWorker?.getHome(cityId: cityId)
    }
    
    func addNewCity(name: String) {
        remoteWorker?.addNewCity(name: name)
    }
    
}

// MARK: - Remote Callbacks

extension HomeInteractor: HomeRemoteWorkerOutputProtocol {
    func didGetHomeWithError(error: Error?) {
        presenter?.didGetHomeWithError(error: error)
    }
    
    func didGetHome(city: HomeResponseModel) {
        presenter?.didGetHome(city: city)
    }
    func cityId(id: String) {
        presenter?.cityId(id: id)
    }
    func cityIdError(error: Error?) {
        presenter?.cityIdError(error: error)
    }
}
