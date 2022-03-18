//
//  HomeViewController.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol?
    
    // MARK: - Init
    init() {
        super.init(nibName: "\(HomeViewController.self)", bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - DeInit
    deinit {
         debugPrint("\(HomeViewController.self)" + "Release from Memory")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup before displaying the view.
        
        presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after displaying the view.
        
        presenter?.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Do any additional setup before hiding the view.
        
        presenter?.viewWillDisappear()
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    /// Setup the UI
    private func setupUI() {
       
    }
}

extension HomeViewController: HomePresenterOutputProtocol {
    
}
