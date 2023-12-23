//
//  Bundle+Extension.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/11/21.
//

import Foundation

extension Bundle {
    var apiKey: String? {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
        else {
            return nil
        }
        return key
    }
}
