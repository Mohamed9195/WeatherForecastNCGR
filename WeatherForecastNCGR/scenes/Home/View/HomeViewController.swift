//
//  HomeViewController.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import UIKit
import IQKeyboardManagerSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var loaderView: UIVisualEffectView!
    @IBOutlet weak var addNewCityButton: UIButton!
    @IBOutlet weak var weatherCityTableView: UITableView!
    @IBOutlet weak var cityTextView: UITextField!
    
    var presenter: HomePresenterProtocol?
    var refresher: UIRefreshControl!
    var showNewCity = false
    
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
        
        weatherCityTableView.rowHeight = weatherCityTableView.frame.height / 3
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
    @IBAction func touchToAddNewCity(_ sender: Any) {
        showNewCity = !showNewCity
        cityTextView.isHidden = !showNewCity
    }
    
    private func setupUI() {
        addNewCityButton.setTitle("", for: .normal)
        title = "weather City"
        self.refresher = UIRefreshControl()
        self.refresher.tintColor = .red
        self.refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.weatherCityTableView.addSubview(refresher)
        weatherCityTableView.register(UINib(nibName: "\(HomeTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        cityTextView.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        cityTextView.delegate = self
    }
    
    @objc func doneButtonClicked(_ sender: Any) {
        presenter?.saveNewCity(name: cityTextView.text ?? "")
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.refresher.beginRefreshing()
        presenter?.viewWillAppear()
    }
}

extension HomeViewController: HomePresenterOutputProtocol, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter?.saveNewCity(name: cityTextView.text ?? "")
        view.endEditing(true)
        return true
    }
    
    func reloadView() {
        weatherCityTableView.reloadData()
    }
    
    func didGetHomeWithError(error: String?) {
        refresher.endRefreshing()
        WeatherAlert.genericErrorAlert(error: error ?? "")
    }
    func didGetHome() {
        refresher.endRefreshing()
        weatherCityTableView.reloadData()
        cityTextView.isHidden = true
    }
    
    func startLoader() {
        loaderView.isHidden = false
    }
    func stopLoader() {
        loaderView.isHidden = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getHomeWeatherCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            fatalError()
        }
        if let dataModel = presenter?.getHomeWeather(forIndexRow: indexPath.row),
            let dataCityModel = dataModel.consolidatedWeather?.first,
           let icon = presenter?.cityIconWeather(indexRow: indexPath.row) {
            cell.configureUI(model: dataCityModel, cityName: dataModel.title ?? "", icon: icon)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.navigatToCityDate(indexRow: indexPath.row)
    }
}
