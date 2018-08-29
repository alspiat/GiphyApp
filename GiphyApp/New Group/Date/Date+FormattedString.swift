//
//  Date+FormattedString.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/27/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import Foundation

extension Date {
    public static func date(string: String) -> Date? {
        let dateFormats = ["yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"]
        for format in dateFormats {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            if let dateObj = dateFormatter.date(from: string) {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day, .hour], from: dateObj)
                return calendar.date(from:components)
            }
        }
        return nil
    }
    
    public func formattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
