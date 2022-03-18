//
//  WeatherAlert.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import UIKit

class WeatherAlert {

    let alert: UIAlertController

    init(title: String? = nil, message: String? = nil, type: UIAlertController.Style = .alert) {
        alert = UIAlertController(title: title, message: message, preferredStyle: type)
    }

    func add(action: UIAlertAction) -> Self {
        alert.addAction(action)
        return self
    }

    func addCancelAction(title: String = "Cancel") -> Self {
        alert.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
        return self
    }

    func show(in vc: UIViewController? = nil) {
        if let vc = vc {
            vc.present(alert, animated: true, completion: nil)
        }
    }

    @discardableResult
    class func genericErrorAlert(error: String = "Something went wrong, please try again later") -> WeatherAlert {
        return WeatherAlert(
            title: "oops sorry",
            message: error
        ).addCancelAction(title: "Ok")
    }
}
