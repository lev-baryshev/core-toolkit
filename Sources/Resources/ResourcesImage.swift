//
//  ResourcesImage.swift
//  CoreToolkit
//
//  Created by sugarbaron on 03.04.2023.
//

import SwiftUI

// MARK: constructor
public extension Resources {
    
    struct Image {
        
        public let key: Swift.String
        
        public init(_ key: Swift.String) {
            self.key = key
        }
        
    }
    
}

public extension String {
    
    var imageResource: Resources.Image {
        .init(self)
    }
    
}

// MARK: contributions
public extension UIImage {
    
    convenience init?(_ resource: Resources.Image) {
        self.init(named: resource.key)
    }
    
}

public extension Image {
    
    init(_ resource: Resources.Image) {
        self.init(resource.key)
    }
    
}
