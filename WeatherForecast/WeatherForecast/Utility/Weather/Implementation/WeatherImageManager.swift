//
//  WeatherImageManager.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/12/14.
//

import UIKit

final class WeatherImageManager: WeatherImageDelegate {
    private let networkManager: NetworkManagable
    private let urlFormatter: any URLFormattable = WeatherImageURLFormatter()
    
    init(networkManager: NetworkManagable) {
        self.networkManager = networkManager
    }
    
    func requestImage(name: String, completion: @escaping (UIImage?) -> ()) {
        let imagePath = WeatherImageURL.image(icon: name).path
        
        if let cachedImage = NSCacheManager.shared.cachedImage(urlString: imagePath) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        
        networkManager.getData(formatter: urlFormatter, path: imagePath, with: nil) { result in
            switch result {
            case .success(let imageData):
                let weatherImage = UIImage(data: imageData)
                NSCacheManager.shared.setObject(image: weatherImage, urlString: imagePath)
                DispatchQueue.main.async {
                    completion(weatherImage)
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}
