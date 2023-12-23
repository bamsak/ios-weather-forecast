//
//  WeatherDataDelegate.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/12/14.
//

import Foundation

protocol WeatherDataDelegate: AnyObject {
    func getCellCount() -> Int?
    
    func getAddress() -> String
    func getCurrentWeatherData() -> CurrentWeather?
    func geticonName() -> String?
    
    func getDataTime(_ index: Int) -> String?
    func getTemperature(_ index: Int) -> String?
    func getWeeklyIconName(_ index: Int) -> String?
}
