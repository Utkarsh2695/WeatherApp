//
//  ViewController.swift
//  WeatherLookup
//
//  Created by Utkarsh Upadhyay (BLR GSS) on 19/03/22.
//

import UIKit

class InputViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!

    let viewModel: InputViewModelContract = InputViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.layer.cornerRadius = 8
        inputTextField.placeholder = "eg: London"
    }

    @IBAction func LookUpButtonAction(_ sender: Any) {
        getWeatherReport()
    }

    private func setDoneButtonActive() {
        doneButton.isEnabled = true
        doneButton.backgroundColor = UIColor.systemGreen
    }

    private func setDoneButtonInactive() {
        doneButton.isEnabled = false
        doneButton.backgroundColor = .lightGray
    }

    private func getWeatherReport() {
        setDoneButtonInactive()
        guard let cityName = inputTextField.text, cityName.count > 0  else {
            setDoneButtonActive()
            self.showAlert(with: "Please enter any place's name!")
            return
        }
        viewModel.getGeoLocation(for: cityName) { [weak self] (error) in
            guard let self = self else {return}
            self.setDoneButtonActive()
            if let error = error {
                switch error {
                case .unkownError:
                    self.showAlert(with: "Something went wrong, please check the input and try again.")
                case .noDataError:
                    self.showAlert(with: "No data has been found for this location. Please check the input and try again")
                }
            } else {
                self.naviagateToTempListViewController(for: cityName, with: self.viewModel.weatherData)
            }
        }
    }

    private func naviagateToTempListViewController(for location: String = "", with weatherData: WeatherReport?) {
        guard let tempListViewController = self.storyboard?.instantiateViewController(withIdentifier: "TemperatureListViewController") as? TemperatureListViewController else {
            return
        }
        tempListViewController.weatherReport = weatherData
        tempListViewController.locationName = location
        self.navigationController?.pushViewController(tempListViewController, animated: true)
    }

    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

