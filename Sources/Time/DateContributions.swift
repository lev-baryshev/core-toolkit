//
//  DateContributions.swift
//  CoreToolkit
//
//  Created by sugarbaron on 24.10.2022.
//

import Foundation

public extension String {

    /// `"yyyy-MM-dd HH:mm:ss" timezone: utc`
    var date: Date? { DateFormatter.with("yyyy-MM-dd HH:mm:ss", timezone: .utc).date(from: self) }

    func date(template: String = "yyyy-MM-dd HH:mm:ss", timezone: TimeZoneId = .utc) -> Date? {
        DateFormatter.with(template, timezoneSeconds: timezone.seconds).date(from: self)
    }

    func date(template: String = "yyyy-MM-dd HH:mm:ss", timezoneHours hours: Int) -> Date? {
        return DateFormatter.with(template, timezoneHours: hours).date(from: self)
    }

}
