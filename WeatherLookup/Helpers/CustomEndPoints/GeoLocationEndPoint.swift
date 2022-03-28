//
//  GeoLocationEndPoint.swift
//  WeatherLookup
//
//  Created by Utkarsh Upadhyay (BLR GSS) on 20/03/22.
//

import Foundation

enum GeoLocationEndPoint: EndPoints {
    case getGeoLocation(cityName: String, limit: Int)

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
            return "/geo/1.0/direct"
        }
    }

    var parameter: [URLQueryItem] {
        let apiKey = "662111f8837f75fbed3b3c53533f60f5"
        switch self {
        case let .getGeoLocation(cityName, limit):
            return [URLQueryItem(name: "q", value: cityName),
                    URLQueryItem(name: "limit", value: "\(limit)"),
                    URLQueryItem(name: "appid", value: apiKey)]
        }
    }

    var method: Methods {
        switch self {
        case .getGeoLocation:
            return .get
        }
    }
}
