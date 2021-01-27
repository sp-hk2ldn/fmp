//
//  Date+Utils.swift
//  fmp
//
//  Created by Stephen Parker on 27/1/2021.
//

import Foundation

extension Date {
    func toDateString(_ dateFormat: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat ?? "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
