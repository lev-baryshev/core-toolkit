//
//  LogContributions.swift
//  CoreToolkit
//
//  Created by sugarbaron on 20.10.2022.
//

import CoreLocation

public extension Double {
    
    var log: String { .init(format: "%03.6f", self) }
    
}

public extension Optional {

    var logNil: String { self == nil ? "<nil>" : "<not_nil>" }

    var log: String { print(self) }

}

// MARK: arrays
public extension Optional where Wrapped == [Int] {
    
    var log: String { unwrap(self) { $0.log } ?? print(self) }
    
}

public extension Optional where Wrapped == [Int?] {
    
    var log: String { unwrap(self) { $0.log } ?? print(self) }
    
}

public extension Optional where Wrapped == [String] {
    
    var log: String { unwrap(self) { $0.log } ?? print(self) }
    
}

public extension Optional where Wrapped == [String?] {
    
    var log: String { unwrap(self) { $0.log } ?? print(self) }
    
}

public extension Array {
    
    var log: String { "[\(String(map { print($0) }.joined))]" }
    
}

public extension CLLocation {

    var log:  String {
        let time: String = timestamp.as("HH:mm:ss")
        let lat: String = coordinate.latitude.string(leadingZeroes: 3, precision: 6)
        let lon: String = coordinate.longitude.string(leadingZeroes: 3, precision: 6)
        let tolerance: Int = horizontalAccuracy.int
        return "t:[\(time)] lat:[\(lat)] lon:[\(lon)] tol:[\(tolerance)]"
    }

}

private func print(_ optional: Optional<Any>) -> String { unwrap(optional) { "\($0)" } ?? "<nil>" }
