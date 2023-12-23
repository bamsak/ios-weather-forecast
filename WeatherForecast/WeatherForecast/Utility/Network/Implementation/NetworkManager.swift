//
//  NetworkManager.swift
//  WeatherForecast
//
//  Created by 김수경 on 2023/11/22.
//

import Foundation

final class NetworkManager {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}

extension NetworkManager: NetworkManagable {
    func getData(formatter: any URLFormattable, path: String, with queries: [String: String]?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = formatter.makeURL(path: path, with: queries)
        else {
            return completion(.failure(NetworkError.urlFormattingError))
        }
        
        let request = formatter.makeURLRequest(url: url, httpMethodType: .get)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(NetworkError.unknownError(description: error.localizedDescription)))
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            guard (200..<300).contains(response.statusCode)
            else {
                return completion(.failure(NetworkError.responseError(statusCode: response.statusCode)))
            }
            
            guard let data = data
            else {
                return completion(.failure(NetworkError.emptyDataError))
            }
            completion(.success(data))
        }
        task.resume()
    }
}
