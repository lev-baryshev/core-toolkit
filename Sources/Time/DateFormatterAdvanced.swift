//
//  DateFormatterAdvanced.swift
//  CoreToolkit
//
//  Created by sugarbaron on 18.11.2021.
//

import Foundation

public extension DateFormatter {

    static func with(_ template: String, timezone: TimeZoneId = .utc, locale: Locale? = .currentLanguage) -> DateFormatter {
        create(template, timezone.seconds, locale)
    }

    static func with(_ template: String, timezoneHours: Int, locale: Locale? = .currentLanguage) -> DateFormatter {
        let secondsFromGMT = timezoneHours * 3600
        return create(template, secondsFromGMT, locale)
    }

    static func with(_ template: String, timezoneSeconds: Int, locale: Locale? = .currentLanguage) -> DateFormatter {
        create(template, timezoneSeconds, locale)
    }

    private static func create(_ template: String, _ secondsFromGmt: Int, _ locale: Locale?) -> DateFormatter {
        let converter = DateFormatter()
        converter.dateFormat = template
        converter.locale = locale
        converter.calendar = Calendar(identifier: .iso8601)
        converter.timeZone = TimeZone(secondsFromGMT: secondsFromGmt)
        return converter
    }

}
