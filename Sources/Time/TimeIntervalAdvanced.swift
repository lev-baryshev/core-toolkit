//
//  TimeIntervalAdvanced.swift
//  CoreToolkit
//
//  Created by sugarbaron on 16.05.2024.
//

import Foundation

public extension TimeInterval {
    
    static let week: TimeInterval = 7 * day
    
    static let day: TimeInterval = 24 * hour
    
    static let hour: TimeInterval = 60 * minute
    
    static let minute: TimeInterval = 60
    
    func express(in units: NSCalendar.Unit, units style: DateComponentsFormatter.UnitsStyle) -> String {
        express(in: units, style)
    }
    
    private func express(in units: NSCalendar.Unit, _ style: DateComponentsFormatter.UnitsStyle) -> String {
        var calendar: Calendar = .current
        calendar.locale = .currentLanguage
        let format: DateComponentsFormatter = .init()
        format.calendar = calendar
        format.allowedUnits = units
        format.unitsStyle = style
        return format.string(from: self) ?? "\(self)s"
    }
    
}
