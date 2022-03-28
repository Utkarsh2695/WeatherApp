//
//  InputViewModel.swift
//  WeatherLookup
//
//  Created by Utkarsh Upadhyay (BLR GSS) on 20/03/22.
//

import Foundation

enum WeatherError: Error {
    case unkownError 
    case noDataError
}

class InputViewModel: InputViewModelContract {
    private var geoLocationModel: GeoLocationModel?
    var weatherData: WeatherReport?

    /// Get the geo location for any location name.
    func getGeoLocation(for location: String, closure: @escaping (WeatherError?) -> ()) {
        NetworkEngine.request(endPoint: GeoLocationEndPoint.getGeoLocation(cityName: location, limit: 2)) { [weak self] (result: Result<[GeoLocationModel], Error>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.geoLocationModel = response.first
            case .failure(let error):
                print(error.localizedDescription)
            }

            // Calling weather api to get the weather data for a defined location.
            self.getWeatherData(for: location, lat: self.geoLocationModel?.lat, long: self.geoLocationModel?.lon) { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let response):
                    self.weatherData = response
                    if self.weatherData?.hourly == nil {
                        closure(.noDataError)
                    } else {
                        closure(nil)
                    }
                case .failure(_):
                    closure(.unkownError)
                }
            }
        }
    }

    /// Caling weather api to get the waether data for location's lattitue or longitude or city name.
    private func getWeatherData(for city: String, lat: Double?, long: Double?, closure: @escaping (Result<WeatherReport, Error>) -> ()) {
        NetworkEngine.request(endPoint: WeatherReportEndPoint.getGeoLocation(cityName: city, lat: lat, long: long)) {(result: Result<WeatherReport, Error>) in
            switch result {
            case .success(let response):
                closure(.success(response))
            case .failure(let error):
                closure(.failure(WeatherError.unkownError))
                print(error.localizedDescription)
            }
        }
    }
}
