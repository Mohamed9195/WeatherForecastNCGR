//
//  DetailsViewController.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailsTableView: UITableView!
    
    private var detailsViewModel: DetailsViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(date: String, cityId: String) {
        detailsViewModel = DetailsViewModel(date: date, cityId: cityId)
        super.init(nibName: "\(DetailsViewController.self)", bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - DeInit
    deinit {
        debugPrint("\(DetailsViewController.self)" + "Release from Memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableBinding()
    }
    
    private func detailsTableBinding() {
        detailsTableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: DetailsTableViewCell.self))
        
        if let daysViewModel = detailsViewModel?.dayDetails {
            daysViewModel.bind(to: detailsTableView.rx.items(cellIdentifier: "DetailsTableViewCell", cellType: DetailsTableViewCell.self)) { row, day, cell in
                cell.configureUI(day: day)
            }.disposed(by: disposeBag)
        }
    }
}
