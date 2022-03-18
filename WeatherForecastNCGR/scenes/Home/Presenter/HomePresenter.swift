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
    }
    
    func viewDidAppear() {
        interactor?.getHome(cityId: "44418")
    }
    
    func viewWillDisappear() {
    }
    
    // MARK: - View Methods
    
}

// MARK: - Interactor Callbacks

extension HomePresenter: HomeInteractorOutputProtocol {
    func didGetHomeWithError(error: Error?) {
        print(error)
    }
    
    func didGetHome(city: HomeResponseModel) {
        print(city)
    }
}
