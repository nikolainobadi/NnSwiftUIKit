//
//  Date+Extensions.swift
//  
//
//  Created by Nikolai Nobadi on 7/14/24.
//

import Foundation

public extension Date {
    static func nnCreateDate(month: Int, day: Int, year: Int? = nil) -> Date {
        var components = DateComponents()
        components.year = year ?? Calendar.current.component(.year, from: Date())
        components.month = month
        components.day = day
        
        return Calendar.current.date(from: components)!
    }
}
