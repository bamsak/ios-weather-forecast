//
//  MainWeatherViewDelelgate.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/12/19.
//

import UIKit

protocol MainWeatherViewDelegate: AnyObject {
    func updateCell(_ cell: WeeklyWeatherCell, at index: Int)
    func updateHeaderView(_ headerView: CurrentHeaderView, collectionView: UICollectionView)
    func getCellCount() -> Int?
    func setRefreshControl(with collectionView: UICollectionView)
}
