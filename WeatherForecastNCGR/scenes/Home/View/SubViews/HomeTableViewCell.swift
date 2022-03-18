//
//  HomeTableViewCell.swift
//  WeatherForecastNCGR
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var parentStackView: UIStackView!
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        parentStackView.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUI(model: ConsolidatedWeather, cityName: String, icon: String) {
        weatherDegreeLabel.text = String(format: "%.3f", model.theTemp ?? 0.0) + " ˚"
        timeLabel.text = model.applicableDate ?? ""
        cityNameLabel.text = cityName
        weatherIcon.load(the: icon)
    }
}
