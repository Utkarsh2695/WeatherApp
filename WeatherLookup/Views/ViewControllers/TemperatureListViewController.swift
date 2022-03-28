//
//  TemperatureViewController.swift
//  WeatherLookup
//
//  Created by Utkarsh Upadhyay (BLR GSS) on 19/03/22.
//

import UIKit

class TemperatureListViewController: UIViewController {

    var weatherReport: WeatherReport?
    var locationName: String = ""


    @IBOutlet weak var tempTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.register(UINib(nibName: "TemperatureListTableViewCell", bundle: nil), forCellReuseIdentifier: "TemperatureListTableViewCell")
        self.navigationItem.title = "\(locationName)'s Hourly Report"

    }
}

extension TemperatureListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tempDetailsVC  = self.storyboard?.instantiateViewController(withIdentifier: "TemperatureDetailsViewController") as? TemperatureDetailsViewController,
              let weatherReport = weatherReport
        else {  return }
        tempDetailsVC.hourlyWeatherReport = weatherReport.hourly?[indexPath.row]
        self.navigationController?.pushViewController(tempDetailsVC, animated: true)
    }
}

extension TemperatureListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weatherReport = weatherReport else { return 0 }
        return weatherReport.hourly?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tempTableView.dequeueReusableCell(withIdentifier: "TemperatureListTableViewCell", for: indexPath) as? TemperatureListTableViewCell,
         let weatherReport = weatherReport else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configCell(with: weatherReport.hourly?[indexPath.row])
        return cell
    }
}
