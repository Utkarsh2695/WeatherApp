//
//  InputViewModelContract.swift
//  WeatherLookup
//
//  Created by Utkarsh Upadhyay (BLR GSS) on 20/03/22.
//

import Foundation

protocol InputViewModelContract {
    /// To stote weather data
    var weatherData: WeatherReport? {get set}

    /// To get the geo location of ciry/State/Country.
    func getGeoLocation(for location: String, closure: @escaping (WeatherError?) -> ())
}
