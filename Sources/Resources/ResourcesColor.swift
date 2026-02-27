//
//  ResourcesColor.swift
//  CoreToolkit
//
//  Created by sugarbaron on 03.04.2023.
//

import SwiftUI
import UIKit

// MARK: constructor
public extension Resources {
    
    struct Color {
        
        public let key: Swift.String
        
        public init(_ key: Swift.String) {
            self.key = key
        }
        
    }
    
}

public extension String {
    
    var colorResource: Resources.Color {
        .init(self)
    }
    
}

// MARK: interface
public extension Resources.Color {
    
    static func customize(_ key: Resources.Color, _ color: Rgb) {
        Custom.colorScheme[key] = color
    }
    
    static func recover(_ key: Resources.Color) {
        Custom.colorScheme[key] = nil
    }
    
}

extension Resources.Color : Hashable {
    
    public static func == (lhs: Resources.Color, rhs: Resources.Color) -> Bool {
        lhs.key == rhs.key
    }
    
    public func hash(into hasher: inout Hasher) {
        key.hash(into: &hasher)
    }
    
}

// MARK: tools
private extension Resources.Color {
    
    final class Custom {
        
        static var colorScheme: ConcurrentMap<Resources.Color, Rgb> = .init()
        
    }
    
}

// MARK: contributions
public extension Color {
    
    init(_ resource: Resources.Color) {
        self = Resources.Color.Custom.colorScheme[resource]?.color ?? Color(resource.key)
    }
    
}

public extension UIColor {
    
    convenience init(_ resource: Resources.Color, alpha: CGFloat = 1.0) {
        let color: UIColor = (alpha == 1.0) ? .construct(resource) : .construct(resource).withAlphaComponent(alpha)
        self.init(cgColor: color.cgColor)
    }
    
    private static func construct(_ resource: Resources.Color) -> UIColor {
        Resources.Color.Custom.colorScheme[resource]?.uiColor ?? UIColor(named: resource.key) ?? .purple
    }
    
}
