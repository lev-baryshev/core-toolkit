//
//  DateTests.swift
//  CoreToolkit
//
//  Created by sugarbaron on 24.02.2026.
//

@testable
import CoreToolkit
import XCTest

final class DateTests : XCTestCase {
    
    // MARK: construction and milliseconds
    func testInit() {
        let seconds: TimeInterval = 1_700_000_000
        let date: Date = .init(since1970: seconds)
        
        XCTAssertEqual(date.since1970, seconds, accuracy: 0.000_001)
        
        let millis: Int64 = date.millisecondsSince1970
        let reconstructed: Date = .init(milliseconds: millis)
        
        XCTAssertEqual(reconstructed.millisecondsSince1970, millis)
    }
    
    // MARK: formatting helpers
    func testFormatting() {
        let date: Date = "1985-05-25 15:35:55".date!
        
        // UTC-based helpers should produce stable, exact strings
        XCTAssertEqual(date.iso8601utc, "1985-05-25T15:35:55+0000")
        XCTAssertEqual(date.utcPrecise, "1985-05-25 15:35:55.0000")
        XCTAssertEqual(date.utcFull, "1985-05-25 15:35:55")
        XCTAssertEqual(date.utcShort, "1985-05-25")
        XCTAssertEqual(date.utcDaytime, "15:35:55")
        XCTAssertEqual(date.yyyyMMdd(timezone: .utc), "1985-05-25")
        XCTAssertEqual(date.HHmmss(timezone: .utc), "15:35:55")
        
        // Local-time helpers should match formatting with the current timezone
        let fullFormatter: DateFormatter = .with("yyyy-MM-dd HH:mm:ss", timezone: .current)
        let shortFormatter: DateFormatter = .with("yyyy-MM-dd", timezone: .current)
        let timeFormatter: DateFormatter = .with("HH:mm:ss", timezone: .current)
        
        XCTAssertEqual(date.full, fullFormatter.string(from: date))
        XCTAssertEqual(date.short, shortFormatter.string(from: date))
        XCTAssertEqual(date.daytime, timeFormatter.string(from: date))
    }
    
    func testTemplates() {
        let date: Date = "1985-05-25 15:35:55".date!
        
        let utcString: String = date.as("yyyy-MM-dd HH:mm:ss", timezone: .utc)
        let offsetString: String = date.as("yyyy-MM-dd HH:mm:ss", timezoneHours: 3)
        
        XCTAssertEqual(utcString, "1985-05-25 15:35:55")
        XCTAssertEqual(offsetString, "1985-05-25 18:35:55")
    }
    
    // MARK: today-relative
    func testTodayRelative() {
        let now: Date = .now
        XCTAssertTrue(now.isToday)
        XCTAssertTrue(now.isTodayOrBefore)
        XCTAssertTrue(now.isTodayOrAfter)
        XCTAssertFalse(now.isBeforeToday)
        XCTAssertFalse(now.isAfterToday)
        
        // build dates clearly in the past and future
        let calendar: Calendar = .current
        let yesterday: Date = calendar.date(byAdding: .day, value: -1, to: now.dayStart)!
        let tomorrow:  Date = calendar.date(byAdding: .day, value: 1, to: now.dayStart)!
        
        XCTAssertTrue(yesterday.isBeforeToday)
        XCTAssertTrue(yesterday.isTodayOrBefore)
        XCTAssertFalse(yesterday.isToday)
        XCTAssertFalse(yesterday.isAfterToday)
        
        XCTAssertTrue(tomorrow.isAfterToday)
        XCTAssertTrue(tomorrow.isTodayOrAfter)
        XCTAssertFalse(tomorrow.isToday)
        XCTAssertFalse(tomorrow.isBeforeToday)
    }
    
    // MARK: day / week start
    func testDayStart() {
        let now: Date = .now
        let dayStart: Date = now.dayStart
        let utcDayStart: Date = now.utcDayStart
        
        // dayStart should be at midnight in current timezone
        let calendar: Calendar = .current
        let components: DateComponents = calendar.dateComponents([.hour, .minute, .second], from: dayStart)
        
        XCTAssertEqual(components.hour, 0)
        XCTAssertEqual(components.minute, 0)
        XCTAssertEqual(components.second, 0)
        
        // utcDayStart is shifted by current offset
        XCTAssertNotEqual(dayStart, utcDayStart)
    }
    
    func testWeekStart() {
        let now: Date = .now
        
        XCTAssertNotNil(now.weekStart)
        XCTAssertNotNil(now.weekStart(accordingTo: .iso8601))
        
        if let utcWeek: Date = now.utcWeekStart {
            // utcWeekStart is just weekStart shifted, so should differ from weekStart when offset != 0
            if TimeZone.current.secondsFromGMT() != 0 {
                XCTAssertNotEqual(utcWeek, now.weekStart)
            }
        }
    }
    
    // MARK: yesterday / daysBefore
    func testDaysBefore() {
        let nowStart: Date = .now.dayStart
        let calendar: Calendar = .current
        
        let yesterday: Date? = nowStart.yesterday
        XCTAssertNotNil(yesterday)
        if let yesterday: Date = yesterday {
            let diff: DateComponents = calendar.dateComponents([.day], from: yesterday.dayStart, to: nowStart)
            XCTAssertEqual(diff.day, 1)
        }
        
        XCTAssertNil(nowStart.daysBefore(0))
        XCTAssertNil(nowStart.daysBefore(-1))
        
        let twoDaysBefore: Date? = nowStart.daysBefore(2)
        XCTAssertNotNil(twoDaysBefore)
        if let twoDaysBefore: Date = twoDaysBefore {
            let diff: DateComponents = calendar.dateComponents([.day], from: twoDaysBefore.dayStart, to: nowStart)
            XCTAssertEqual(diff.day, 1)
        }
    }
    
}
