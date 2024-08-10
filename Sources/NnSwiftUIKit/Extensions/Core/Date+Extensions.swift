//
//  Date+Extensions.swift
//  
//
//  Created by Nikolai Nobadi on 7/14/24.
//

import Foundation

/// Extension for Date to provide additional utility methods.
public extension Date {
    /// Creates a `Date` object from the specified month, day, and year.
    /// - Parameters:
    ///   - month: The month component of the date.
    ///   - day: The day component of the date.
    ///   - year: The year component of the date. If not provided, defaults to the current year.
    /// - Returns: A `Date` object representing the specified date.
    static func nnCreateDate(month: Int, day: Int, year: Int? = nil) -> Date {
        var components = DateComponents()
        components.year = year ?? Calendar.current.component(.year, from: Date())
        components.month = month
        components.day = day
        
        return Calendar.current.date(from: components)!
    }
}

