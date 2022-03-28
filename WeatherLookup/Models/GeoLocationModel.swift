//
//  GeoLocationModel.swift
//  WeatherLookup
//
//  Created by Utkarsh Upadhyay (BLR GSS) on 20/03/22.
//

import Foundation

// Model for store the location data
struct GeoLocationModel: Codable {
    let name: String?
    let lat: Double?
    let lon: Double?
}
