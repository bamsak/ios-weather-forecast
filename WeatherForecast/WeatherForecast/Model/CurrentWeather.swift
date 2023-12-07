//
//  CurrentWeather.swift
//  WeatherForecast
//
//  Created by 김수경 on 2023/11/20.
//

import Foundation

struct CurrentWeather: Decodable {
    var coordinate: CommonWeatherDTO.Coordinate?
    var weather: [CommonWeatherDTO.Weather]?
    var base: String?
    var main: CommonWeatherDTO.Main?
    var visibility: Int?
    var wind: CommonWeatherDTO.Wind?
    var clouds: CommonWeatherDTO.Clouds?
    var rain: CommonWeatherDTO.Rain?
    var snow: CommonWeatherDTO.Snow?
    var dataTime: Int?
    var system: System?
    var timezone: Int?
    var id: Int?
    var name: String?
    var cod: Int?
    
    enum CodingKeys: String, CodingKey {
        case weather, base, main, visibility, wind, clouds, rain, snow, timezone, id, name, cod
        case coordinate = "coord"
        case dataTime = "dt"
        case system = "sys"
    }
    
    struct System: Decodable {
        var type: Int?
        var id: Int?
        var country: String?
        var sunrise: Int?
        var sunset: Int?
    }
}
