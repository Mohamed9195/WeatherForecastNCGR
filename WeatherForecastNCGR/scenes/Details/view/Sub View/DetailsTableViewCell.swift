//
//  DetailsTableViewCell.swift
//  WeatherForecastNCGR
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsTextField: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUI(day: DayResponseModel) {
        detailsTextField.text = """
"id":  \(day.id ?? 0)
"weather_state_name":  \(day.weatherStateName ?? "-")
"weather_state_abbr":  \(day.weatherStateAbbr ?? "-")
"wind_direction_compass":  \(day.windDirection ?? 0.0)
"created":  \(day.created ?? "-")
"applicable_date":  \(day.applicableDate ?? "-")
,"min_temp":  \(day.minTemp ?? 0.0)
"max_temp":  \(day.maxTemp ?? 0.0)
"wind_speed":  \(day.windSpeed ?? 0.0)
"wind_direction":  \(day.windDirection ?? 0.0)
"humidity":  \(day.humidity ?? 0)
"visibility":  \(day.visibility ?? 0.0)
"predictability":  \(day.predictability ?? 0)
"""

    }
}
