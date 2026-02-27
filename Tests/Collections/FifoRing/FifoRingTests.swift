//
//  FifoRingTests.swift
//  CoreToolkit
//
//  Created by sugarbaron on 24.02.2026.
//

@testable
import CoreToolkit
import XCTest

final class FifoRingTests : XCTestCase {
    
    // MARK: basic FIFO behavior
    func testFifo() {
        let fifo: FifoRing<Int> = .init(size: 3)
        
        XCTAssertTrue(fifo.isEmpty)
        XCTAssertFalse(fifo.isNotEmpty)
        XCTAssertNil(fifo.read())
        
        fifo.write(1)
        fifo.write(2)
        
        XCTAssertFalse(fifo.isEmpty)
        XCTAssertTrue(fifo.isNotEmpty)
        XCTAssertEqual(fifo.read(), 1)
        XCTAssertEqual(fifo.read(), 2)
        XCTAssertTrue(fifo.isEmpty)
        XCTAssertNil(fifo.read())
    }
    
    // MARK: ring overwrite behavior
    func testOverwrite() {
        let fifo: FifoRing<Int> = .init(size: 3)
        
        // capacity 3, write 5 elements; first two should be overwritten
        fifo.write(1)
        fifo.write(2)
        fifo.write(3)
        fifo.write(4)
        fifo.write(5)
        
        XCTAssertEqual(fifo.read(), 3)
        XCTAssertEqual(fifo.read(), 4)
        XCTAssertEqual(fifo.read(), 5)
        XCTAssertTrue(fifo.isEmpty)
        XCTAssertNil(fifo.read())
    }
    
    // MARK: wrap-around
    func testWrapAround() {
        let fifo: FifoRing<Int> = .init(size: 3)
        
        fifo.write(1)
        fifo.write(2)
        XCTAssertEqual(fifo.read(), 1)
        
        fifo.write(3)
        fifo.write(4)
        fifo.write(5) // this should overwrite the oldest remaining (2)
        
        XCTAssertEqual(fifo.read(), 3)
        XCTAssertEqual(fifo.read(), 4)
        XCTAssertEqual(fifo.read(), 5)
        XCTAssertTrue(fifo.isEmpty)
    }
    
}
