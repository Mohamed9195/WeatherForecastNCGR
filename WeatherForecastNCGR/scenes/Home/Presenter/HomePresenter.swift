//
//
//  HomePresenter.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
   
    var interactor: HomeInteractorProtocol?
    weak var view: HomePresenterOutputProtocol?
    var router: HomeRouterProtocol?
    var viewData: HomeViewData?
    private var homeWeathers: [HomeResponseModel]? = []
    private var cityNames: Set<CityName> = [.cairo]
    /// Initialize the presenter with the required parameters to work properly
    /// - Parameters:
    ///   - interactor: The interactor for retrieving the data locally or remotely
    ///   - view: The view which the presenter is preparing the data for
    ///   - router: The router which is responsible for any routing from the view
    init(interactor: HomeInteractorProtocol, view: HomePresenterOutputProtocol, router: HomeRouterProtocol) {
        self.interactor =  interactor
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        homeWeathers?.removeAll()
        cityNames.removeAll()
        cityNames.insert(.cairo)
        
        InternetConnection.shared.startListening { connectionStatus in
            if connectionStatus == .connected {
                self.interactor?.getHome(cityId: CityName.cairo.rawValue)
            } else {
                self.view?.didGetHomeWithError(error: "no internet connection")
            }
        }
    }
    
    func viewDidAppear() {
    }
    
    func viewWillDisappear() {
    }
    
    // MARK: - View Methods
    func getHomeWeather(forIndexRow: Int) -> HomeResponseModel? {
        guard let homeWeathers = homeWeathers, homeWeathers.count > forIndexRow else { return nil }
        return homeWeathers[forIndexRow]
    }
    
    func getHomeWeatherCount() -> Int {
        guard let homeWeathers = homeWeathers else { return 0 }
        return homeWeathers.count
    }
    
    func navigatToCityDate(indexRow: Int) {
        if let homeWeathers = homeWeathers, homeWeathers.count > indexRow {
            router?.navigateTo(.days(cityId: String(homeWeathers[indexRow].woeid ?? 0)))
        }
    }
    
    func cityIconWeather(indexRow: Int) -> String {
        guard let homeWeathers = homeWeathers,
              indexRow < homeWeathers.count,
              let icon = homeWeathers[indexRow].consolidatedWeather?.first?.weatherStateAbbr else { return "" }
        return "https://www.metaweather.com/static/img/weather/png/\(icon).png"
    }
}

// MARK: - Interactor Callbacks

extension HomePresenter: HomeInteractorOutputProtocol {
    func didGetHomeWithError(error: Error?) {
        homeWeathers?.removeAll()
        cityNames.removeAll()
        cityNames.insert(.cairo)
        // add data cached if found
        view?.didGetHomeWithError(error: error?.localizedDescription)
    }
    
    func didGetHome(city: HomeResponseModel) {
        homeWeathers?.append(city)
        switch cityNames.count {
        case 1:
            self.cityNames.insert(.nY)
            interactor?.getHome(cityId: CityName.nY.rawValue)
        case 2:
            self.cityNames.insert(.riyadh)
            interactor?.getHome(cityId: CityName.riyadh.rawValue)
        case 3:
            view?.stopLoader()
            view?.didGetHome()
        default: break
        }
    }
}
