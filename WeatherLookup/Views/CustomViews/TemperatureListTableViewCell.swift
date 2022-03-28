//
//  TemperatureListTableViewCell.swift
//  WeatherLookup
//
//  Created by Utkarsh Upadhyay (BLR GSS) on 20/03/22.
//

import UIKit

class TemperatureListTableViewCell: UITableViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(with hourlyWeatherReport: HourlyWeatherReport?) {
        guard let hourlyWeatherReport = hourlyWeatherReport, let temp =  hourlyWeatherReport.temp else {
            return
        }
        headingLabel.text = hourlyWeatherReport.weather?[0].main
        descriptionLabel.text = temp.convertToCelsius()
    }
}
