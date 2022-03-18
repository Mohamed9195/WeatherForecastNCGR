//
//  DaysViewController.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import UIKit

class DaysViewController: UIViewController {

    var daysViewModel: DaysViewModel?
    
    // MARK: - Init
    init(cityId: String) {
        daysViewModel = DaysViewModel(cityId: cityId)
        super.init(nibName: "\(DaysViewController.self)", bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - DeInit
    deinit {
         debugPrint("\(DaysViewController.self)" + "Release from Memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
