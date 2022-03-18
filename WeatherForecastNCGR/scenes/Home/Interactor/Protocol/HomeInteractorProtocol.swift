//
//  HomeInteractorProtocol.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation

/// Defines the interactor capabilities
protocol HomeInteractorProtocol: AnyObject {
    func getHome(cityId: String)
}

//
/// Defines the interactor callbacks to presenter
protocol HomeInteractorOutputProtocol: AnyObject {
    func didGetHomeWithError(error: Error?)
    func didGetHome(city: HomeResponseModel)
}
