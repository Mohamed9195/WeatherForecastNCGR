//
//  HomeRemoteWorkerProtocols.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation

/// Defines the remote worker capabilities
protocol HomeRemoteWorkerProtocol: AnyObject {
    func getHome(cityId: String)
    func addNewCity(name: String)
}

/// Defines the remote worker callbacks
protocol HomeRemoteWorkerOutputProtocol: AnyObject {
    func didGetHomeWithError(error: Error?)
    func didGetHome(city: HomeResponseModel)
    func cityId(id: String)
    func cityIdError(error: Error?)
}
