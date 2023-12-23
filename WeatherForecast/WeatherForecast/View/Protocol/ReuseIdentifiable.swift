//
//  ReuseIdentifiable.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/12/08.
//

import Foundation

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
