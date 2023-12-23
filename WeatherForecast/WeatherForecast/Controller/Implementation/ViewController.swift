//
//  WeatherForecast - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ViewController: UIViewController {
    private let networkManager = NetworkManager()
    private let locationManager = LocationManager()
    private lazy var weatherManager = WeatherDataManager(networkManager: networkManager,
                                                         currentLocationManager: CurrentLocationManager())
    private lazy var weatherImageManager = WeatherImageManager(networkManager: networkManager)
    
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

extension ViewController: MainWeatherViewDelegate {
    func updateCell(_ cell: WeeklyWeatherCell, at index: Int) {
        guard let date = weatherManager.getDataTime(index),
              let temperature = weatherManager.getTemperature(index),
              let iconName = weatherManager.getWeeklyIconName(index)
        else { return }
        weatherImageManager.requestImage(name: iconName) { image in
            cell.updateUI(date: date, temperature: temperature, image: image)
        }
    }
    
    func updateHeaderView(_ headerView: CurrentHeaderView, collectionView: UICollectionView) {
        let address = weatherManager.getAddress()
        guard let weatherData = weatherManager.getCurrentWeatherData(),
              let iconName = weatherManager.geticonName()
        else { return }
        weatherImageManager.requestImage(name: iconName) { image in
            headerView.updateUI(address: address, weather: weatherData, image: image)
            collectionView.refreshControl?.endRefreshing()
        }
    }
    
    func getCellCount() -> Int? {
        let cellCount = weatherManager.getCellCount()
        return cellCount
    }
    
    func setRefreshControl(with collectionView: UICollectionView) {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        locationManager.updateLocation()
    }
}

extension ViewController: UIUpdatable {
    func updateUI() {
        mainWeatherView.updateUI()
    }
}

extension ViewController: AlertPresentable {
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치변경", message: "변경할 좌표를 선택해주세요", preferredStyle: .alert)
        alert.addTextField { UITextField in
            UITextField.placeholder = "위도"
        }
        alert.addTextField { UITextField in
            UITextField.placeholder = "경도"
        }
        
        let change = UIAlertAction(title: "변경", style: .default) { [weak self] _ in
            guard let latitude = alert.textFields?[0].text, let longitude = alert.textFields?[1].text else { return }
            self?.locationManager.changeLocation(latitude: latitude, longitude: longitude)
        }
        let resetLocation = UIAlertAction(title: "현재 위치로 재설정", style: .default) { [weak self] _ in
            self?.locationManager.updateLocation()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(change)
        alert.addAction(resetLocation)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
