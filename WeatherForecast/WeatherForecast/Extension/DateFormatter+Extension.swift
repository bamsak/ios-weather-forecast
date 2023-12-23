//
//  DateFormatter+Extension.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/12/12.
//

import Foundation

extension DateFormatter {
    static func convertTimeToString(with dataTime: Int) -> String {
        let time = NSDate(timeIntervalSince1970: TimeInterval(dataTime))
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd(E) HH시"
        
        let convertedString = formatter.string(from: time as Date)
        
        return convertedString
    }
}
