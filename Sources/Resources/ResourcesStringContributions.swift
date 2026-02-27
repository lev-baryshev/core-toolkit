//
//  ResourcesStringContributions.swift
//  CoreToolkit
//
//  Created by sugarbaron on 15.10.2024.
//

import SwiftUI

public extension Text {
    
    init(_ resource: Resources.String) {
        self.init(String(resource))
    }
    
}

public extension String {
    
    init(_ resource: Resources.String) {
        self = resource.string
    }
    
    init(quantified resource: Resources.String, _ items: Int) {
        self = resource.quantified(items)
    }
    
    init(_ resource: Resources.String, inserting numberOfItems: Int) {
        let template: String = resource.string
        if template.contains("%d") {
            self.init(format: template, numberOfItems)
        } else {
            self.init()
        }
    }
    
}
