//
//  CurrentLocationManagable.swift
//  WeatherForecast
//
//  Created by 김수경 on 2023/12/01.
//

import CoreLocation

protocol CurrentLocationManagable: AnyObject {
    func updateLocationInfo(with placemark: CLPlacemark)
    func defaultLocationInfo()
}
