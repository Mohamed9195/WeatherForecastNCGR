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
        
        detailsTableView.rx.willDisplayCell
            .subscribe(onNext: ({ cell, indexPath in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
    }
}
