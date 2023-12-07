//
//  NetworkManager.swift
//  WeatherForecast
//
//  Created by 김수경 on 2023/11/22.
//

import Foundation

final class NetworkManager {
    private let urlFormatter: any URLFormattable
    private let session: URLSession
    
    init(urlFormatter: any URLFormattable, session: URLSession = URLSession.shared) {
        self.urlFormatter = urlFormatter
        self.session = session
    }
    
    func getData<T: Decodable>(path: String, with queries: [String: String], completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = urlFormatter.makeURL(path: path, with: queries)
        else {
            return completion(.failure(NetworkError.urlFormattingError))
        }
        
        let request = URLRequest(url: url)
        
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
            do {
                let decodingData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodingData))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        task.resume()
    }
}
