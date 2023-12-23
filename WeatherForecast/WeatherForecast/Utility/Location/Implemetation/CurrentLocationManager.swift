//
//  CurrentLocationManager.swift
//  WeatherForecast
//
//  Created by 김수경 on 2023/12/01.
//

import CoreLocation

final class CurrentLocationManager {
    private var locationInfo: CurrentLocationInfo?
    
    func makeQueries() -> [String: String]? {
        guard let longitude = locationInfo?.coordinates?.longitude,
              let latitude = locationInfo?.coordinates?.latitude
        else {
            return nil
        }
        guard let appid = Bundle.main.apiKey
        else {
            return nil
        }
        
        let queries = [
            "lon": "\(longitude)",
            "lat": "\(latitude)",
            "appid": appid,
            "units": "metric"
        ]
        
        return queries
    }
    
    func getAddress() -> String {
        guard let city = locationInfo?.city else {
            return ""
        }
        guard let district = locationInfo?.district else {
            return "\(city)"
        }
        
        return "\(city) \(district)"
    }
}

extension CurrentLocationManager: CurrentLocationManagable {
    func updateLocationInfo(with placemark: CLPlacemark) {
        locationInfo = CurrentLocationInfo(
            coordinates: placemark.location?.coordinate,
            city: placemark.locality,
            district: placemark.subLocality
        )
    }
    
    func defaultLocationInfo() {
        locationInfo = CurrentLocationInfo(
            coordinates: CLLocationCoordinate2D(latitude: 37.5336766, longitude: 126.9632199),
            city: "서울시",
            district: "용산구"
        )
    }
}
