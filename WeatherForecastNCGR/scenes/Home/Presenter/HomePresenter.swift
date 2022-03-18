//
//
//  HomePresenter.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation
import UIKit

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
        self.view?.startLoader()
        
        InternetConnection.shared.startListening { connectionStatus in
            if connectionStatus == .connected {
                self.interactor?.getHome(cityId: CityName.cairo.rawValue)
            } else {
                self.view?.stopLoader()
                if let cachedModel = DefaultHomeModelManger().get() as? [HomeResponseModel] {
                    self.homeWeathers = cachedModel
                    self.view?.didGetHome()
                } else {
                    self.view?.didGetHomeWithError(error: "no internet connection")
                }
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
            router?.navigateTo(.days(homeResponseModel: homeWeathers[indexRow]))
        }
    }
    
    func cityIconWeather(indexRow: Int) -> String {
        guard let homeWeathers = homeWeathers,
              indexRow < homeWeathers.count,
              let icon = homeWeathers[indexRow].consolidatedWeather?.first?.weatherStateAbbr else { return "" }
        return "https://www.metaweather.com/static/img/weather/png/\(icon).png"
    }
    
    func saveNewCity(name: String) {
        view?.startLoader()
        interactor?.addNewCity(name: name)
    }
    
    func getCachedCity() -> [String]? {
        if let oldCity = UserDefaults.standard.object(forKey: "NewCity") as? [String] {
            return oldCity
        } else {
            return nil
        }
    }
}

// MARK: - Interactor Callbacks

extension HomePresenter: HomeInteractorOutputProtocol {
    func didGetHomeWithError(error: Error?) {
        homeWeathers?.removeAll()
        self.view?.stopLoader()
        if let cachedModel = DefaultHomeModelManger().get() as? [HomeResponseModel] {
            homeWeathers = cachedModel
            view?.didGetHome()
        } else {
            view?.didGetHomeWithError(error: error?.localizedDescription)
        }
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
            if let cachedCity = getCachedCity() {
                cachedCity.forEach { city in
                    self.cityNames.insert(.other)
                    interactor?.getHome(cityId: city)
                }
            } else {
                view?.stopLoader()
                view?.didGetHome()
                homeWeathers != nil ? DefaultHomeModelManger().save(file: homeWeathers! as [HomeResponseModel]) : ()
            }
            
        default:
            view?.stopLoader()
            view?.didGetHome()
            homeWeathers != nil ? DefaultHomeModelManger().save(file: homeWeathers! as [HomeResponseModel]) : ()
        }
    }
    
    func cityId(id: String) {
        if var oldCity = UserDefaults.standard.object(forKey: "NewCity") as? [String] {
            if !oldCity.contains(where: { $0 == id }) {
                oldCity.append(id)
            }
            UserDefaults.standard.set(oldCity, forKey: "NewCity")
        } else {
            UserDefaults.standard.set([id], forKey: "NewCity")
        }
        view?.stopLoader()
        view?.didGetHome()
    }
    
    func cityIdError(error: Error?) {
        view?.didGetHomeWithError(error: "can not found city")
    }
}
