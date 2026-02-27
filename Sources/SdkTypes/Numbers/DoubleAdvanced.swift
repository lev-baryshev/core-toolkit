//
//  DoubleAdvanced.swift
//  CoreToolkit
//
//  Created by sugarbaron on 18.11.2021.
//

import Foundation

public extension Double {

    var int: Int {
        Int(self)
    }
    
    var cgFloat: CGFloat {
        CGFloat(self)
    }

    func string(leadingZeroes: Int, precision: Int) -> String {
        String(format: "%0\(leadingZeroes).\(precision)f", self)
    }
    
    func string(precision: Int) -> String {
        String(format: "%.\(precision)f", self)
    }

}

public extension Optional where Wrapped == Double {
    
    static func +=(_ this: inout Double?, _ that: Double?) {
        guard let that: Double else { return }
        guard let it: Double = this else { this = that; return }
        this = it + that
    }
    
}
