//
//  CommonWeatherDTO.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/11/24.
//

import Foundation

enum CommonWeatherDTO {

    struct Coordinate: Decodable {
        var longitude: Double
        var latitude: Double
        
        enum CodingKeys: String, CodingKey {
            case longitude = "lon"
            case latitude = "lat"
        }
    }

    struct Weather: Decodable {
        var id: Int?
        var main: String?
        var description: String?
        var icon: String?
    }

    struct Main: Decodable {
        var temperature: Double?
        var feelsLike: Double?
        var minTemperature: Double?
        var maxTemperature: Double?
        var pressure: Int?
        var humidity: Int?
        var seaLevel: Int?
        var groundLevel: Int?
        
        enum CodingKeys: String, CodingKey {
            case pressure, humidity
            case temperature = "temp"
            case feelsLike = "feels_like"
            case minTemperature = "temp_min"
            case maxTemperature = "temp_max"
            case seaLevel = "sea_level"
            case groundLevel = "grnd_level"
        }
    }

    struct Wind: Decodable {
        var speed: Double?
        var direction: Int?
        var gust: Double?
        
        enum CodingKeys: String, CodingKey {
            case speed, gust
            case direction = "deg"
        }
    }

    struct Clouds: Decodable {
        var all: Int?
    }

    struct Rain: Decodable {
        var oneHour: Double?
        var threeHour: Double?
        
        enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
            case threeHour = "3h"
        }
    }

    struct Snow: Decodable {
        var oneHour: Double?
        var threeHour: Double?
        
        enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
            case threeHour = "3h"
        }
    }
}
