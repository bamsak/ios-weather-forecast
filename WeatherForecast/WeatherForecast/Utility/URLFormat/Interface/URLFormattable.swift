//
//  URLFormattable.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/11/21.
//

import Foundation

protocol URLFormattable {
    associatedtype T: APIBaseURLProtocol
    
    func makeURL(path: String, with queries: [String: String]?) -> URL?
    func makeURLRequest(url: URL, httpMethodType: HTTPMethod) -> URLRequest
}

extension URLFormattable {
    func makeURL(path: String, with queries: [String: String]?) -> URL? {
        let urlString = "\(T.baseURLString)"
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.path = "\(path)"
        if let queries = queries {
            let queryItems = queries.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
            urlComponents?.queryItems = queryItems
        }
        return urlComponents?.url
    }
    
    func makeURLRequest(url: URL, httpMethodType: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "\(httpMethodType)".uppercased()
        
        return request
    }
}
