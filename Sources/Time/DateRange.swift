//
//  DateRange.swift
//  CoreToolkit
//
//  Created by sugarbaron on 06.07.2021.
//

import Foundation

public extension Date {
    
    enum Range : String {
        
        case lastWeek   = "last_week"
        case today      = "today"
        case tomorrow   = "tomorrow"
        case thisWeek   = "this_week"
        
    }
    
}

public extension Date.Range {
    
    init?(_ id: String) {
        guard let range: Date.Range = .init(rawValue: id)
        else {
            return nil
        }
        self = range
    }
    
    var id: String {
        rawValue
    }
                               
    var points: (min: Date, max: Date)? {
        switch self {
        case .lastWeek: lastWeek
        case .today:    today
        case .tomorrow: tomorrow
        case .thisWeek: thisWeek
        }
    }
    
}

private extension Date.Range {
    
    var tomorrow: (min: Date, max: Date)? {
        guard let today: (min: Date, max: Date) = today else { return nil }
        let min: Date = today.min + day
        let max: Date = today.max + day
        return (min, max)
    }
    
    var today: (min: Date, max: Date)? {
        let components: DateComponents = Calendar.current.dateComponents(Set([.year, .month, .day]), from: .now)
        guard let today: Date = Calendar.current.date(from: components)
        else {
            log(error: "[DateRange] unable to construct today date")
            return nil
        }
        let tomorrow: Date = today + (day - 1)
        return (today, tomorrow)
    }
    
    var lastWeek: (min: Date, max: Date)? {
        guard let thisWeek: (min: Date, max: Date) = thisWeek else { return nil }
        let min: Date = thisWeek.min - week
        let max: Date = thisWeek.min - 1
        return (min, max)
    }
    
    var thisWeek: (min: Date, max: Date)? {
        let calendar: Calendar = Calendar(identifier: .iso8601)
        let components: DateComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: .now)
        guard let monday: Date = calendar.date(from: components)
        else {
            log(error: "[DateRange] unable to construct this week date")
            return nil
        }
        let nextMonday: Date = monday + (week - 1)
        return (monday, nextMonday)
    }
    
    var week: TimeInterval { .week }
    var day:  TimeInterval { .day }
    
}
