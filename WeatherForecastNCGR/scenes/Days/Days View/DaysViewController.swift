//
//  DaysViewController.swift
//  WeatherForecast
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class DaysViewController: UIViewController {
    
    @IBOutlet weak var daysTableView: UITableView!
    
    private var homeResponseModel: HomeResponseModel?
    private var daysViewModel: DaysViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(homeResponseModel: HomeResponseModel) {
        self.homeResponseModel = homeResponseModel
        daysViewModel = DaysViewModel(homeResponseModel: homeResponseModel)
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
        daysTableBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        daysTableView.reloadData()
    }
    
    private func daysTableBinding() {
        daysTableView.register(UINib(nibName: "DaysTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: DaysTableViewCell.self))
        
        if let daysViewModel = daysViewModel?.daysDetailsModel {
            daysViewModel.bind(to: daysTableView.rx.items(cellIdentifier: "DaysTableViewCell", cellType: DaysTableViewCell.self)) { row, days, cell in
                cell.configureUI(model: days)
            }.disposed(by: disposeBag)
        }
        
        daysTableView.rx.willDisplayCell
            .subscribe(onNext: ({ cell, indexPath in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
        
        daysTableView.rx.modelSelected(ConsolidatedWeather.self).subscribe { [weak self] day in
            guard let self = self else { return }
            let carModelViewController = DetailsViewController(date: day.element?.applicableDate?.replacingOccurrences(of: "-", with: "/") ?? "", cityId: String(self.homeResponseModel?.woeid ?? 0))
            
            self.navigationController?.pushViewController(carModelViewController, animated: true)
        }.disposed(by: disposeBag)
    }
}
