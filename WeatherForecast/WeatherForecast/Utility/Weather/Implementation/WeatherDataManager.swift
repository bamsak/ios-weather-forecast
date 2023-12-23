//
//  WeatherDataManager.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/12/12.
//

import Foundation

final class WeatherDataManager: WeatherUpdateDelegate {
    private let networkManager: NetworkManagable
    let currentLocationManager: CurrentLocationManager
    private let urlFormatter: any URLFormattable = WeatherURLFormatter()
    
    weak var delegate: UIUpdatable?
    
    private var currentWeather: CurrentWeather?
    private var weeklyWeather: WeeklyWeather?
    
    init(networkManager: NetworkManagable, currentLocationManager: CurrentLocationManager) {
        self.networkManager = networkManager
        self.currentLocationManager = currentLocationManager
    }
    
    func sendRequest() {
        let queries = currentLocationManager.makeQueries()
        networkManager.getData(formatter: urlFormatter, path: WeatherDataURL.current.path, with: queries) { [weak self] result in
            switch result {
            case .success(let data):
                guard let weather = try? JSONDecoder().decode(CurrentWeather.self, from: data) else {
                    //Alert Delegate
                    return
                }
                self?.currentWeather = weather
            case .failure(let error):
                print("\(error)")
            }
        }
        networkManager.getData(formatter: urlFormatter, path: WeatherDataURL.weekly.path, with: queries) { [weak self] result in
            switch result {
            case .success(let data):
                guard let weather = try? JSONDecoder().decode(WeeklyWeather.self, from: data) else {
                    return
                }
                self?.weeklyWeather = weather
                
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.updateUI()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}

extension WeatherDataManager: WeatherDataDelegate {
    func getCellCount() -> Int? {
        return weeklyWeather?.list?.count
    }
    
    func getAddress() -> String {
        let address = currentLocationManager.getAddress()
        return address
    }
    
    func getCurrentWeatherData() -> CurrentWeather? {
        return currentWeather
    }
    
    func geticonName() -> String? {
        return currentWeather?.weather?.last?.icon
    }
    
    func getDataTime(_ index: Int) -> String? {
        guard let date = weeklyWeather?.list?[index].dataTime else { return nil }
        let convertedDate = DateFormatter.convertTimeToString(with: date)
        return convertedDate
    }
    
    func getTemperature(_ index: Int) -> String? {
        guard let temperature = weeklyWeather?.list?[index].main?.temperature else { return nil }
        return String(format: "%.1f", temperature)
    }
    
    func getWeeklyIconName(_ index: Int) -> String? {
        return weeklyWeather?.list?[index].weather?[0].icon
    }
}

