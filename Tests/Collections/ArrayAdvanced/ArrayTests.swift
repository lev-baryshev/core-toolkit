//
//  ArrayTests.swift
//  CoreToolkit
//
//  Created by sugarbaron on 24.02.2026.
//

@testable
import CoreToolkit
import XCTest

final class ArrayTests : XCTestCase {

    // MARK: lastIndex
    func testLastIndex() {
        let empty: [Int] = []
        let array: [Int] = [10, 20, 30]
        XCTAssertEqual(array.lastIndex, 2)
        XCTAssertNil(empty.lastIndex)
    }

    // MARK: split(partSize:)
    func testSplit() {
        let array: [Int] = [1, 2, 3, 4, 5]
        let parts: [[Int]] = array.split(partSize: 2)
        XCTAssertEqual(parts.count, 3)
        XCTAssertEqual(parts[0], [1, 2])
        XCTAssertEqual(parts[1], [3, 4])
        XCTAssertEqual(parts[2], [5])
        XCTAssertEqual(array.split(partSize: 5),  [array])
        XCTAssertEqual(array.split(partSize: 6),  [array])
        XCTAssertEqual(array.split(partSize: -1), [array])
    }

    // MARK: suffix
    func testSuffix() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array.suffix(last:  2), [4, 5])
        XCTAssertEqual(array.suffix(last:  5), array)
        XCTAssertEqual(array.suffix(last:  7), array)
        XCTAssertTrue( array.suffix(last:  0).isEmpty)
        XCTAssertTrue( array.suffix(last: -1).isEmpty)
    }

    // MARK: addUnique
    func testAddUnique() {
        struct User {
            let id: Int
            let name: String
        }

        var users: [User] = [
            .init(id: 1, name: "Alice"),
            .init(id: 2, name: "Bob")
        ]
        let same:   User = .init(id: 2, name: "Robert")
        let unique: User = .init(id: 3, name: "Charlie")
        
        users.addUnique(same) { lhs, rhs in
            lhs.id == rhs.id
        }
        users.addUnique(unique) { lhs, rhs in
            lhs.id == rhs.id
        }
        
        XCTAssertEqual(users.count, 3)
        XCTAssertTrue(users.contains { $0.id == 3 && $0.name == "Charlie" })
    }

    // MARK: transform
    func testTransform() {
        struct Item {
            let id: Int
            let label: String
        }

        let list: [Item] = [
            .init(id: 1, label: "one"),
            .init(id: 2, label: "two"),
            .init(id: 3, label: "three")
        ]

        let items: [Int : Item] = list.transform(key: \.id)

        XCTAssertEqual(items[1]?.label, "one")
        XCTAssertEqual(items[2]?.label, "two")
        XCTAssertEqual(items[3]?.label, "three")
    }

    // MARK: isAbsent / isOne(of:)
    func testPresenceChecks() {
        let array: [Int] = [1, 2, 3]

        XCTAssertTrue(4.isAbsent(among: array))
        XCTAssertTrue(2.isOne(of: array))
        XCTAssertFalse(2.isAbsent(among: array))
        XCTAssertFalse(5.isOne(of: array))
    }

    // MARK: += operators
    func testAppend() {
        var array: [Int] = [1, 2]
        array += 3
        XCTAssertEqual(array, [1, 2, 3])
    }

    // MARK: isIndex
    func testIsIndex() {
        let array: [Int]? = [10, 20, 30]
        XCTAssertTrue(0.isIndex(of: array))
        XCTAssertTrue(2.isIndex(of: array))
        XCTAssertFalse(3.isIndex(of: array))
        XCTAssertFalse((-1).isIndex(of: array))
    }

    // MARK: safe access
    func testSafeAccess() {
        var array: [Int] = [10, 20, 30]
        XCTAssertEqual(array[safe: 0], 10)
        XCTAssertEqual(array[safe: 2], 30)
        XCTAssertNil( array[safe: -1])
        XCTAssertNil( array[safe:  3])
        
        array[safe: -1] = 99
        array[safe:  1] = 99
        XCTAssertEqual(array, [10, 99, 30])
    }
    
}

