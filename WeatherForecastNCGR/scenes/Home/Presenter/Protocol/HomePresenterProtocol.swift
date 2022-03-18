//
//  HomePresenterProtocol.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation

/// Defines the presenter capabilities
protocol HomePresenterProtocol: AnyObject {
    var interactor: HomeInteractorProtocol? { get set }
    var view: HomePresenterOutputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    
    func getHomeWeather(forIndexRow: Int) -> HomeResponseModel?
    func getHomeWeatherCount() -> Int
    func navigatToCityDate(indexRow: Int)
    func cityIconWeather(indexRow: Int) -> String
}

/// Defines the presenter callbacks to view
protocol HomePresenterOutputProtocol: AnyObject {
    func didGetHomeWithError(error: String?)
    func didGetHome()
    func startLoader()
    func stopLoader()
}
