//
//  WeatherReportEndPomit.swift
//  WeatherLookup
//
//  Created by Utkarsh Upadhyay (BLR GSS) on 20/03/22.
//

import Foundation

enum WeatherReportEndPoint: EndPoints {

    case getGeoLocation(cityName: String?, lat: Double?, long: Double?)

    var scheme: String {
        switch self {
        default: return "https"
        }
    }

    var baseURL: String {
        switch self {
        default:
            return "api.openweathermap.org"
        }
    }

    var path: String {
        switch self {
        case .getGeoLocation:
            return "/data/2.5/onecall"
        }
    }

    var parameter: [URLQueryItem] {
        let apiKey = "5417df4826c2a2d509c8a0db17a3f6b5"
        switch self {
        case let .getGeoLocation(cityName, lat, long):
            if let lat = lat, let long = long {
                return [URLQueryItem(name: "lat", value: "\(lat)"),
                        URLQueryItem(name: "lon", value: "\(long)"),
                        URLQueryItem(name: "appid", value: apiKey)]
            } else {
                return [URLQueryItem(name: "q", value: cityName),
                        URLQueryItem(name: "appid", value: apiKey)]
            }
        }
    }

    var method: Methods {
        switch self {
        case .getGeoLocation:
            return .get
        }
    }
}
