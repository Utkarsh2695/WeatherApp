//
//  TemperatureDetailsViewController.swift
//  WeatherLookup
//
//  Created by Utkarsh Upadhyay (BLR GSS) on 27/03/22.
//

import UIKit

class TemperatureDetailsViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!

    var hourlyWeatherReport : HourlyWeatherReport?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupIntialView()
        setupViews()
        setupImageView()
    }

    private func setupIntialView() {
        tempLabel.text = ""
        descriptionLabel.text = ""
        humidityLabel.text = ""
        feelsLikeLabel.text = ""
    }

    private func setupViews() {
        guard let hourlyReport = hourlyWeatherReport else { return }
        if let temp = hourlyReport.temp {
            self.tempLabel.text = temp.convertToCelsius()
        }
        if let description = hourlyReport.weather?[0].description {
            self.descriptionLabel.text = description
        }

        if let humidity = hourlyReport.humidity {
            self.humidityLabel.text = "Humidity - \(humidity)"
        }
        if let feelsLike = hourlyReport.humidity {
            self.feelsLikeLabel.text = "Feels Like - \(feelsLike)"
        }
    }

    private func setupImageView() {
        guard let hourlyReport = hourlyWeatherReport, let main = hourlyReport.weather?[0].main  else {
            return
        }
        if main.uppercased() == "CLOUDS" {
            self.weatherImageView.image = UIImage.init(named: "cloud")
        } else if main.uppercased() == "RAIN" {
            self.weatherImageView.image = UIImage.init(named: "rain")
        } else if main.uppercased() == "CLEAR" {
            self.weatherImageView.image = UIImage.init(named: "clear")
        } else {
            self.weatherImageView.image = UIImage.init(named: "clear")
        }
    }
}
