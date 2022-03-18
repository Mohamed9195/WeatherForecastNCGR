//
//  HomeRouter.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import UIKit
import Moya

/// Defines the router functionalities
protocol HomeRouterProtocol {
    func navigateTo(_ route: HomeRouter.HomeRoute)
}

class HomeRouter: HomeRouterProtocol {
    enum HomeRoute {
        case days(homeResponseModel: HomeResponseModel)
    }

    typealias DataType = HomeViewData
    
    weak var viewController: UIViewController?
    
    // MARK: - Router Creation
    /// Creates a view controller
    /// - Parameter data: The initial data required by the module
    /// - Returns: The view controller after initializing and hooking everything -> Data, presenter, interactor, workers, and router
    static func createModule(data: HomeViewData?) -> UIViewController {
        let viewController = HomeViewController()
        let remoteService = HomeEndPoints(provider: MoyaProvider<HomeEndpointSpecifications>(plugins: [CompleteUrlLoggerPlugin()]))
        let remoteWorker = HomeRemoteWorker(homeServiceProtocol: remoteService)
        remoteService.delegate = remoteWorker
        let interactor = HomeInteractor(remoteWorker: remoteWorker)
        remoteWorker.interactor = interactor
        let router = HomeRouter()
        router.viewController = viewController
        let presenter = HomePresenter(interactor: interactor, view: viewController, router: router)
        interactor.presenter = presenter
        viewController.presenter = presenter
        presenter.viewData = data
        return viewController
    }
    
    func navigateTo(_ route: HomeRoute) {
        switch route {
        case .days(let homeResponseModel):
            navigateToDays(homeResponseModel: homeResponseModel)
        }
    }
                           
    private func navigateToDays(homeResponseModel: HomeResponseModel) {
        let daysController = DaysViewController(homeResponseModel: homeResponseModel)
        viewController?.navigationController?.pushViewController(daysController, animated: true)
    }
}
