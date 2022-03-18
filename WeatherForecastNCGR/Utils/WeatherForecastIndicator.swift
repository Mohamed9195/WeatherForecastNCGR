//
//  PKHUD.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import PKHUD

class WeatherForecastIndicator {

    class func showProgressView() {
        HUD.hide(afterDelay: 30)
        HUD.show(.systemActivity)
    }

    class func hideProgressView() {
        HUD.hide()
    }

    class func hideBySuccessFlash() {
        HUD.flash(.success)
    }

    class func hideByErrorFlash() {
        HUD.flash(.error)
    }
}
