//
//  WeatherUpdateDelegate.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/12/01.
//

import Foundation

protocol WeatherUpdateDelegate: AnyObject {
    func sendRequest()
}
