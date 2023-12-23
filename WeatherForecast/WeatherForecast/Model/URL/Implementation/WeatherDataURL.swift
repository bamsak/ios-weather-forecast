//
//  WeatherURL.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/11/21.
//

import Foundation

enum WeatherDataURL: APIBaseURLProtocol {
    static let baseURLString = "https://api.openweathermap.org"
    
    case current
    case weekly
    
    var path: String {
        switch self {
        case .current:
            return "/data/2.5/weather"
        case .weekly:
            return "/data/2.5/forecast"
        }
    }
}
