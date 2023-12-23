//
//  WeatherImageURL.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/12/14.
//

import Foundation

enum WeatherImageURL: APIBaseURLProtocol {
    static let baseURLString: String = "https://openweathermap.org"
    
    case image(icon: String)
    
    var path: String {
        switch self {
        case .image(let icon):
            return "/img/wn/\(icon)@2x.png"
        }
    }
}
