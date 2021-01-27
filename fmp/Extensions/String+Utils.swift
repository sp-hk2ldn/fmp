//
//  String+Utils.swift
//  fmp
//
//  Created by Stephen Parker on 25/1/2021.
//

import Foundation

extension String {
    func toDate(dateFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: self) ?? Date()
    }
}
