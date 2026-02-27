//
//  ConcurrentMapTests.swift
//  CoreToolkit
//
//  Created by sugarbaron on 24.02.2026.
//

@testable
import CoreToolkit
import XCTest

final class ConcurrentMapTests : XCTestCase {
    
    // MARK: subscript
    func testSubscript() {
        let map: ConcurrentMap<String, Int> = .init()
        
        XCTAssertTrue(map.isEmpty)
        XCTAssertNil(map["a"])
        
        map["a"] = 10
        map["b"] = 20
        
        XCTAssertFalse(map.isEmpty)
        XCTAssertTrue(map.isNotEmpty)
        XCTAssertEqual(map["a"], 10)
        XCTAssertEqual(map["b"], 20)
        XCTAssertNil(map["c"])
    }
    
    // MARK: access(_:)
    func testAccess() {
        let map: ConcurrentMap<String, Int> = .init()
        map["a"] = 1
        map["b"] = 2
        
        var snapshot: [String : Int] = [:]
        map.access { current in
            snapshot = current
        }
        
        XCTAssertEqual(snapshot.count, 2)
        XCTAssertEqual(snapshot["a"], 1)
        XCTAssertEqual(snapshot["b"], 2)
    }
    
    // MARK: <~ operator
    func testWriteOperator() {
        let map: ConcurrentMap<String, Int> = .init()
        map["x"] = 100
        
        map <~ ["a" : 1, "b" : 2]
        
        XCTAssertEqual(map["a"], 1)
        XCTAssertEqual(map["b"], 2)
        XCTAssertNil(map["x"])
    }
    
}
