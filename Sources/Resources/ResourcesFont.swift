//
//  ResourcesFont.swift
//  CoreToolkit
//
//  Created by sugarbaron on 03.04.2023.
//

import SwiftUI
import UIKit

// MARK: constructor
public extension Resources {
    
    struct Font {
        
        public let key: Swift.String
        
        public init(_ key: Swift.String) {
            self.key = key
        }
        
    }
    
}

public extension String {

    var fontResource: Resources.Font { .init(self) }
    
}

// MARK: contributions
public extension UIFont {
    
    convenience init?(_ resource: Resources.Font, size: CGFloat) {
        self.init(name: resource.key, size: size)
    }
    
}

public extension Font {
    
    init(_ resource: Resources.Font, size: CGFloat) {
        self = Font.custom(resource.key, size: size)
    }
    
}
