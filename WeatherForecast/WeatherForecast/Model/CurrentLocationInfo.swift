//
//  CurrentLocationInfo.swift
//  WeatherForecast
//
//  Created by 김수경 on 2023/11/30.
//

import CoreLocation

struct CurrentLocationInfo {
    let coordinates: CLLocationCoordinate2D?
    let city: String?
    let district: String?
}
