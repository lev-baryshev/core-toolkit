//
//  IntTests.swift
//  CoreToolkit
//
//  Created by sugarbaron on 24.02.2026.
//

@testable
import CoreToolkit
import XCTest
import UIKit

final class IntTests : XCTestCase {
    
    // MARK: basic conversions
    func testConversions() {
        let value: Int = 42
        
        XCTAssertEqual(value.float, 42.0 as Float)
        XCTAssertEqual(value.double, 42.0 as Double)
        XCTAssertEqual(value.timeInterval, 42.0 as TimeInterval)
        XCTAssertEqual(value.cgFloat, 42.0 as CGFloat)
    }
    
    // MARK: hexString
    func testHexString() {
        XCTAssertEqual(0.hexString, "0x0")
        XCTAssertEqual(0xFF.hexString, "0xFF")
        XCTAssertEqual(0x1A2B.hexString, "0x1A2B")
    }
    
    // MARK: restrict with Range<Int>
    func testRestrictWithRange() {
        let range: Range<Int> = 0..<10
        let closed: ClosedRange<Int> = 0...10
        
        XCTAssertEqual((-5).restrict(range), 0)
        XCTAssertEqual(0.restrict(range), 0)
        XCTAssertEqual(5.restrict(range), 5)
        XCTAssertEqual(9.restrict(range), 9)
        XCTAssertEqual(10.restrict(range), 9)
        XCTAssertEqual(100.restrict(range), 9)
        
        XCTAssertEqual((-5).restrict(closed), 0)
        XCTAssertEqual(0.restrict(closed), 0)
        XCTAssertEqual(5.restrict(closed), 5)
        XCTAssertEqual(10.restrict(closed), 10)
        XCTAssertEqual(11.restrict(closed), 10)
    }
    
}
