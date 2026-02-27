@testable
import CoreToolkit
import XCTest

final class RgbTests : XCTestCase {
    
    // MARK: hex / integerLiteral init and int property
    func testConstruct() {
        let hex: Int = 0x11223344
        let colorFromHex: Rgb = .init(hex)
        let colorFromLiteral: Rgb = 0x11223344
        
        XCTAssertEqual(colorFromHex, colorFromLiteral)
        XCTAssertEqual(colorFromHex.int, hex)
        XCTAssertEqual(colorFromLiteral.int, hex)
    }
    
    // MARK: rrggbb / rrggbbaa
    func testRrggbbaa() {
        let color: Rgb = 0xA1B2C3D4
        
        XCTAssertEqual(color.rrggbb, "A1B2C3")
        XCTAssertEqual(color.rrggbbaa, "A1B2C3D4")
    }
    
    // MARK: String.rgb
    func testStringRgb() {
        XCTAssertNil("".rgb)
        XCTAssertNil("#123".rgb)
        XCTAssertNil("ZZZZZZ".rgb)
        
        let rgb1: Rgb? = "FF0000".rgb
        XCTAssertNotNil(rgb1)
        XCTAssertEqual(rgb1?.r, 0xFF)
        XCTAssertEqual(rgb1?.g, 0x00)
        XCTAssertEqual(rgb1?.b, 0x00)
        XCTAssertEqual(rgb1?.a, 0xFF)
        
        let rgb2: Rgb? = "#00FF00".rgb
        XCTAssertNotNil(rgb2)
        XCTAssertEqual(rgb2?.r, 0x00)
        XCTAssertEqual(rgb2?.g, 0xFF)
        XCTAssertEqual(rgb2?.b, 0x00)
    }
    
}
