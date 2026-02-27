//
//  DateAdvanced.swift
//  CoreToolkit
//
//  Created by sugarbaron on 28.07.2022.
//

import Foundation

// MARK: construction
public extension Date {

    init(since1970 seconds: TimeInterval) {
        self.init(timeIntervalSince1970: seconds)
    }

    init(milliseconds: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }

}

// MARK: parse/format
public extension Date {
    
    func `as`(_ template: String, timezone: TimeZoneId = .utc) -> String {
        formatDate(as: template, timezone: timezone.seconds)
    }
    
    func `as`(_ template: String, timezoneHours hours: Double) -> String {
        let timezoneSeconds: Int = .init(hours * 3600)
        return formatDate(as: template, timezone: timezoneSeconds)
    }
    
    var iso8601utc: String {
        formatDate(as: "yyyy-MM-dd'T'HH:mm:ssZ", timezone: TimeZoneId.utc.seconds)
    }
    
    var utcPrecise: String {
        formatDate(as: "yyyy-MM-dd HH:mm:ss.SSSS", timezone: TimeZoneId.utc.seconds)
    }
    
    var utcFull: String {
        formatDate(as: "yyyy-MM-dd HH:mm:ss", timezone: TimeZoneId.utc.seconds)
    }
    
    var utcShort: String {
        formatDate(as: "yyyy-MM-dd", timezone: TimeZoneId.utc.seconds)
    }
    
    var utcDaytime: String {
        formatDate(as: "HH:mm:ss", timezone: TimeZoneId.utc.seconds)
    }
    
    var full: String {
        formatDate(as: "yyyy-MM-dd HH:mm:ss", timezone: TimeZoneId.current.seconds)
    }
    
    var short: String {
        formatDate(as: "yyyy-MM-dd", timezone: TimeZoneId.current.seconds)
    }
    
    var daytime: String {
        formatDate(as: "HH:mm:ss", timezone: TimeZoneId.current.seconds)
    }
    
    func yyyyMMdd(timezone: TimeZoneId = .utc) -> String {
        formatDate(as: "yyyy-MM-dd", timezone: timezone.seconds)
    }
    
    func HHmmss(timezone: TimeZoneId = .utc) -> String {
        formatDate(as: "HH:mm:ss", timezone: timezone.seconds)
    }
    
}

private extension Date {

    func formatDate(as template: String, timezone secondsFromGMT: Int) -> String {
        let converter: DateFormatter = .with(template, timezoneSeconds: secondsFromGMT)
        return converter.string(from: self)
    }

}

// MARK: advancements
public extension Date {

    var since1970: TimeInterval {
        timeIntervalSince1970
    }

    var millisecondsSince1970: Int64 {
        Int64((timeIntervalSince1970 * 1000.0).rounded())
    }
    
    static func -(from: Date, to: Date) -> TimeInterval {
        from.timeIntervalSince(to)
    }
    
    func since(_ date: Date) -> TimeInterval {
        timeIntervalSince(date)
    }

}

public extension TimeInterval {
    
    var dateSince1970: Date { .init(since1970: self) }
    
}

// MARK: time zone
public extension TimeZone {
    
    var offset: TimeInterval {
        secondsFromGMT().timeInterval
    }
    
}

public enum TimeZoneId {

    case current
    case utc

    public var seconds: Int {
        switch self {
        case .utc:     return 0
        case .current: return TimeZone.current.secondsFromGMT()
        }
    }

}

// MARK: today-relative
public extension Date {
    
    var isToday: Bool {
        isDateInToday
    }
    
    var isBeforeToday: Bool {
        isDateEarlierThanToday
    }
    
    var isAfterToday: Bool {
        isDateLaterThanToday
    }
    
    var isTodayOrBefore: Bool {
        isDateInToday || isDateEarlierThanToday
    }
    
    var isTodayOrAfter: Bool {
        isDateInToday || isDateLaterThanToday
    }
    
}

private extension Date {

    var isDateLaterThanToday: Bool {
        !(isDateInToday) && self.timeIntervalSinceNow > 0
    }

    var isDateEarlierThanToday: Bool {
        !(isDateInToday) && self.timeIntervalSinceNow < 0
    }
    
    var isDateInToday: Bool {
        Calendar.current.isDateInToday(self)
    }

}

// MARK: day start, week start
public extension Date {
    
    var utcDayStart: Date {
        dayStart - TimeZone.current.offset
    }
    
    var dayStart: Date {
        var calendar: Calendar = .init(identifier: .iso8601)
        calendar.timeZone = .current
        return calendar.startOfDay(for: self)
    }
    
    var utcWeekStart: Date? {
        unwrap(weekStart) { $0 - TimeZone.current.offset }
    }
    
    var yesterday: Date? {
        let calendar: Calendar = .current
        return calendar.date(byAdding: .day, value: -1, to: .now.dayStart)
    }
    
    func daysBefore(_ days: Int) -> Date? {
        guard days > 0 else { return nil }
        let calendar: Calendar = .current
        return calendar.date(byAdding: .day, value: -(days - 1), to: .now.dayStart)
    }
    
    var weekStart: Date? {
        let calendar: Calendar = .current
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }
    
    func weekStart(accordingTo calendarId: Calendar.Identifier) -> Date? {
        let calendar: Calendar = .init(identifier: calendarId)
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }
    
}

// MARK: utc <-> current
public extension Date {
    
    var inUtc: Date {
        self - TimeZone.current.offset
    }
    
    func utc(to timezone: TimeZoneId) -> Date {
        convertUtc(to: timezone.seconds) }
    
    func utc(to timezone: TimeZone) -> Date {
        convertUtc(to: timezone.offset.int)
    }
    
    private func convertUtc(to timezoneSeconds: Int) -> Date {
        self + timezoneSeconds.timeInterval
    }
    
}
