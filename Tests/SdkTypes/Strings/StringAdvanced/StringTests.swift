@testable
import CoreToolkit
import XCTest
import UIKit

final class StringTests : XCTestCase {
    
    // MARK: init(bytes:)
    func testInitUtf8() {
        let bytes: [UInt8] = Array("Hello".utf8)
        let string: String? = .init(bytes: bytes)
        
        XCTAssertEqual(string, "Hello")
    }
    
    // MARK: conversions
    func testConversions() {
        XCTAssertEqual("123".int, 123)
        XCTAssertNil("abc".int)
        
        XCTAssertTrue("x".isNotEmpty)
        XCTAssertFalse("".isNotEmpty)
    }
    
    // MARK: replace
    func testReplace() {
        let original: String = "foo bar foo"
        
        XCTAssertEqual(original.replace("foo", with: "baz"), "baz bar baz")
        XCTAssertEqual(original.without(all: "foo"), " bar ")
    }
    
    // MARK: size calculations
    func testSize() {
        let text: String = "Hello, world"
        let font: UIFont = .systemFont(ofSize: 14)
        
        let height: CGFloat = text.height(withConstrainedWidth: 100, font: font)
        let width:  CGFloat = text.width(withConstrainedHeight: 20, font: font)
        
        XCTAssertGreaterThan(height, 0)
        XCTAssertGreaterThan(width, 0)
    }
    
    // MARK: identifier format
    func testIdentifierFormat() {
        XCTAssertEqual("12345678".toIdentifier, "1234 5678")
        XCTAssertEqual(" 12 34 56 ".toIdentifier, "1234 56")
        XCTAssertEqual("".toIdentifier, "")
    }
    
    // MARK: getString
    func testGetString() {
        let source: String = "prefix [target] suffix"
        
        XCTAssertEqual(source.getString(from: "[", to: "]"), "target")
        XCTAssertNil(source.getString(from: "]", to: "[")) // invalid order
    }
    
    // MARK: safe pop
    func testSafePop() {
        XCTAssertEqual("abc".safePopLast(), "ab")
        XCTAssertEqual("a".safePopLast(), "")
    }
    
    // MARK: hexadecimal()
    func testHexadecimal() {
        XCTAssertNil("ABC".hexadecimal()) // odd length
        XCTAssertNil("ZZ".hexadecimal())  // invalid hex
        
        let binary: Data? = "DEADBEEF".hexadecimal()
        XCTAssertNotNil(binary)
        XCTAssertEqual(binary, Data([0xDE, 0xAD, 0xBE, 0xEF]))
    }
    
    // MARK: contains(caseInsensitive:)
    func testContainsCaseInsensitive() {
        let base: String = "Hello World"
        
        XCTAssertTrue( base.contains(caseInsensitive: "hello"))
        XCTAssertTrue( base.contains(caseInsensitive: "WORLD"))
        XCTAssertFalse(base.contains(caseInsensitive: "swift"))
    }
    
    // MARK: split(with:)
    func testSplit() {
        let text: String = "a|b|c"
        XCTAssertEqual(text.split(with: "|"), ["a", "b", "c"])
    }
    
    // MARK: firstLetters
    func testFirstLetters() {
        let text: String = "hello, world! swift"
        XCTAssertEqual(text.firstLetters, "HWS")
    }
    
    // MARK: url coding
    func testUrlCoding() {
        let encoded: String = "Hello%20World"
        XCTAssertEqual(encoded.urlDecoded, "Hello World")
        
        let invalid: String = "%"
        XCTAssertNil(invalid.urlDecoded)
        
        let validUrlString: String = "https://example.com"
        XCTAssertNotNil(validUrlString.url)
    }
    
    // MARK: trim
    func testTrim() {
        let text: String = "  hello\n"
        let trimmed: String = text.trim(.whitespacesAndNewlines)
        
        XCTAssertEqual(trimmed, "hello")
    }
    
    // MARK: [String] joined helpers
    func testJoined() {
        let items: [String] = ["a", "b", "c"]
        XCTAssertEqual(items.joined, "a, b, c")
        XCTAssertEqual(items.joined(by: "|"), "a|b|c")
    }
    
}

