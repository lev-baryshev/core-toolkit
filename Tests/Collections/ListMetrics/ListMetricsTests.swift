//
//  ListMetricsTests.swift
//  CoreToolkit
//
//  Created by sugarbaron on 24.02.2026.
//

@testable
import CoreToolkit
import XCTest

final class ListMetricsTests : XCTestCase {
    
    // MARK: total / lastIndex
    func testParameters() {
        let list: [Int] = [1, 2, 3, 4]
        let matrix: [[Int]] = [
            [1, 2],
            [3],
            [4, 5, 6]
        ]
        
        let metrics: (plain: ListMetrics, matrix: ListMetrics) = (
            ListMetrics(plain: list),
            ListMetrics(matrix: matrix)
        )
        
        XCTAssertEqual(metrics.plain.total, 4)
        XCTAssertEqual(metrics.plain.lastIndex, 3)
        XCTAssertEqual(metrics.matrix.total, 6)
        XCTAssertEqual(metrics.matrix.lastIndex, 5)
    }
    
    // MARK: offset
    func testOffset() {
        let matrix: [[String]] = [
            ["a", "b"],     // section 0
            ["c"],          // section 1
            ["d", "e", "f"] // section 2
        ]
        let metrics: ListMetrics = .init(matrix: matrix)
        
        XCTAssertEqual(metrics.offset(for: IndexPath(item: 0, section: 0)), 0)
        XCTAssertEqual(metrics.offset(for: IndexPath(item: 1, section: 0)), 1)
        XCTAssertEqual(metrics.offset(for: IndexPath(item: 0, section: 1)), 2)
        XCTAssertEqual(metrics.offset(for: IndexPath(item: 2, section: 2)), 5)
        XCTAssertEqual(metrics.offset(for: IndexPath(item: 100, section: 100)), metrics.lastIndex)
    }
    
}
