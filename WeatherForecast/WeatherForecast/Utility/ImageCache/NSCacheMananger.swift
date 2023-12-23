//
//  NSCacheMananger.swift
//  WeatherForecast
//
//  Created by 김수경 on 2023/12/18.
//

import UIKit

final class NSCacheManager {
    static let shared = NSCacheManager()
    private init() { }
    
    private let storage = NSCache<NSString, UIImage>()
    
    func cachedImage(urlString: String) -> UIImage? {
        let cacheKey = NSString(string: urlString)
        guard let cacheImage = storage.object(forKey: cacheKey) else {
            return nil
        }
        return cacheImage
    }
    
    func setObject(image: UIImage?, urlString: String) {
        let key = NSString(string: urlString)
        guard let image = image else { return }
        storage.setObject(image, forKey: key)
    }
}
