//
//  Double + Extension.swift
//  WeatherLookup
//
//  Created by Utkarsh Upadhyay (BLR GSS) on 28/03/22.
//

import Foundation

extension Double {

    /// Covert from kelvin to celsius and giving back string with only 2 place of decimal value
    func convertToCelsius() -> String {
        let celsius = self - 273.15
        return "\(celsius.rounded(toPlaces: 2)) °c"
    }

    /// Rounds the double to decimal places value
     func rounded(toPlaces places:Int) -> Double {
         let divisor = pow(10.0, Double(places))
         return (self * divisor).rounded() / divisor
     }
}
