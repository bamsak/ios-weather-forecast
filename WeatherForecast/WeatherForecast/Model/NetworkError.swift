//
//  NetworkError.swift
//  WeatherForecast
//
//  Created by 김수경 on 2023/11/22.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case unknownError(description: String)
    case urlFormattingError
    case responseError(statusCode: Int)
    case emptyDataError
    case decodingError
    
    var description: String {
        switch self {
        case .unknownError(let description):
            return "\(description)"
        case .urlFormattingError:
            return "url 변환 실패"
        case .responseError(let statusCode):
            return "Response Error: \(statusCode)"
        case .emptyDataError:
            return "서버에 해당 데이터가 존재하지 않아 데이터를 불러오지 못했습니다."
        case .decodingError:
            return "디코딩에 실패하였습니다."
        }
    }
}
