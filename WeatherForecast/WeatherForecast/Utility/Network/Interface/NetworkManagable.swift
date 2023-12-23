//
//  NetworkManagable.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/12/01.
//

import Foundation

protocol NetworkManagable {
    func getData(formatter: any URLFormattable, path: String, with queries: [String: String]?, completion: @escaping (Result<Data, Error>) -> Void) 
}
