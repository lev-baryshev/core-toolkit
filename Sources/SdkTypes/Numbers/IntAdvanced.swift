//
//  IntAdvanced.swift
//  CoreToolkit
//
//  Created by sugarbaron on 19.11.2021.
//

import Foundation
import UIKit

public extension Int {

    var float: Float {
        Float(self)
    }

    var double: Double {
        Double(self)
    }
    
    var timeInterval: TimeInterval {
        TimeInterval(self)
    }

    var cgFloat: CGFloat {
        CGFloat(self)
    }
    
    var hexString: String {
        String(format: "0x%X", self)
    }
    
    func restrict(_ range: Range<Int>) -> Int {
        if self <  range.lowerBound { return range.lowerBound }
        if self >= range.upperBound { return range.upperBound - 1 }
        return self
    }
    
    func restrict(_ range: ClosedRange<Int>) -> Int {
        if self < range.lowerBound { return range.lowerBound }
        if self > range.upperBound { return range.upperBound }
        return self
    }

}

public extension UInt8 {
    
    var int: Int {
        Int(self)
    }
    
}
