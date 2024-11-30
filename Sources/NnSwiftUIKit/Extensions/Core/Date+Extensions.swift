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
    static func createDate(day: Int? = nil, month: Int? = nil, year: Int? = nil) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.day = day ?? components.day
        components.month = month ?? components.month
        components.year = year ?? components.year
        return Calendar.current.date(from: components) ?? Date()
    }
    
    /// Creates a random time on a given date within the specified hour range.
    /// - Parameters:
    ///   - date: The base date for the random time.
    ///   - startHour: The earliest hour for the random time (24-hour format).
    ///   - endHour: The latest hour for the random time (24-hour format).
    static func randomTime(on date: Date, between startHour: Int, and endHour: Int) -> Date {
        let randomHour = Int.random(in: startHour...endHour)
        let randomMinute = Int.random(in: 0...59)
        var components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.hour = randomHour
        components.minute = randomMinute
        return Calendar.current.date(from: components) ?? date
    }
}
