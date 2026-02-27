//
//  DictionaryTests.swift
//  CoreToolkit
//
//  Created by sugarbaron on 24.02.2026.
//

@testable
import CoreToolkit
import XCTest

final class DictionaryTests : XCTestCase {
    
    // MARK: merge
    func testMerge() {
        let original: [String : Int] = ["a" : 10, "b" : 2]
        let update:   [String : Int] = ["b" : 20, "c" : 3]
        
        let merged: [String : Int] = original.merge(update)
        XCTAssertEqual(merged["a"], 10)
        XCTAssertEqual(merged["b"], 20)
        XCTAssertEqual(merged["c"], 3)
    }
    
    // MARK: exclude
    func testExclude() {
        let original: [String : Int] = ["a" : 1, "b" : 2]
        let excluded: [String : Int] = original.exclude(["b" : 0])
        XCTAssertNil(excluded["b"])
        XCTAssertEqual(excluded["a"], 1)
    }
    
    // MARK: += / -= operators
    func testPlusEqualAndMinusEqualOperatorsMutateInPlace() {
        var lhs: [String : Int] = ["a" : 1, "b" : 2]
        let rhs: [String : Int] = ["b" : 20, "c" : 3]
        
        lhs += rhs
        XCTAssertEqual(lhs["a"], 1)
        XCTAssertEqual(lhs["b"], 20)
        XCTAssertEqual(lhs["c"], 3)
        
        lhs -= ["b" : 0]
        XCTAssertNil(lhs["b"])
        XCTAssertEqual(lhs["a"], 1)
        XCTAssertEqual(lhs["c"], 3)
    }
    
    // MARK: convert
    func testConvert() {
        let source: [String : String] = [
            "1" : "one",
            "2" : "two",
            "x" : "skip"
        ]
        
        let converted: [Int : String] = source.convert()
        
        XCTAssertEqual(converted[1], "one")
        XCTAssertEqual(converted[2], "two")
        XCTAssertNil(converted[0])
        XCTAssertNil(converted[3])
    }
    
}
