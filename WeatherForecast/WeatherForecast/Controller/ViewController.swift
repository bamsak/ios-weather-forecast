//
//  WeatherForecast - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ViewController: UIViewController {
    
    let locationManager = LocationManager()
    let weatherManager = WeatherDataManager(networkManager: NetworkManager(),
                                        currentLocationManager: CurrentLocationManager())
    
    private var mainWeatherView: MainWeatherView!
    
    override func loadView() {
        super.loadView()
        mainWeatherView = MainWeatherView(delegate: self)
        weatherManager.delegate = self
        view = mainWeatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.manager.requestLocation()
        locationManager.currentLocationManager = weatherManager.currentLocationManager
        locationManager.weatherDelgate = weatherManager
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellCount = weatherManager.weeklyWeather?.list?.count else {
            return 0
        }
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeklyWeatherCell.reuseIdentifier, for: indexPath) as? WeeklyWeatherCell else {
            return WeeklyWeatherCell()
        }
        guard let date = weatherManager.weeklyWeather?.list?[indexPath.row].dataTime,
              let temperature = weatherManager.weeklyWeather?.list?[indexPath.row].main?.temperature
        else {
            return WeeklyWeatherCell()
        }
        
        cell.dateLabel.text = DateFormatter.convertTimeToString(with: date)
        cell.temperatureLabel.text = "\(temperature)"
        cell.configure()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CurrentHeaderView.reuseIdentifier, for: indexPath) as? CurrentHeaderView else {
            return CurrentHeaderView()
        }
        
        if let weatherData = weatherManager.currentWeather {
            let address = weatherManager.currentLocationManager.getAddress()
            headerView.updateUI(address: address, weather: weatherData)
        }
        
        headerView.headerViewConfigure()
        return headerView
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 13)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width / 2)
    }
}

extension ViewController: UIUpdatable {
    func updateUI() {
        mainWeatherView.updateUI()
    }
}
