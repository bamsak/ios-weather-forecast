//
//  WeeklyWeather.swift
//  WeatherForecast
//
//  Created by 김수경 on 2023/11/20.
//

import Foundation

struct WeeklyWeather: Decodable {
    var cod: String?
    var message: Int?
    var timestampCount: Int?
    var list: [List]?
    var city: City?
    
    enum CodingKeys:String, CodingKey {
        case cod, message, list, city
        case timestampCount = "cnt"
    }
    
    struct List: Decodable {
        var dataTime: Int?
        var main: CommonWeatherDTO.Main?
        var weather: [CommonWeatherDTO.Weather]?
        var clouds: CommonWeatherDTO.Clouds?
        var wind: CommonWeatherDTO.Wind?
        var visibility: Int?
        var probabilityOfPrecipitation: Double?
        var rain: CommonWeatherDTO.Rain?
        var snow: CommonWeatherDTO.Snow?
        var system: System?
        var dateText: String?
        
        struct System: Decodable {
            var partOfTheDay: String?
            
            enum CodingKeys:String, CodingKey {
                case partOfTheDay = "pod"
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case main, weather, clouds, wind, visibility, rain, snow
            case dataTime = "dt"
            case probabilityOfPrecipitation = "pop"
            case system = "sys"
            case dateText = "dt_txt"
        }
    }

    struct City: Decodable {
        var id: Int?
        var name: String?
        var coordinate: CommonWeatherDTO.Coordinate?
        var country: String?
        var population: Int?
        var timezone: Int?
        var sunrise: Int?
        var sunset: Int?
        
        enum CodingKeys: String, CodingKey {
            case id, name, country, population, timezone, sunrise, sunset
            case coordinate = "coord"
        }
    }
}

