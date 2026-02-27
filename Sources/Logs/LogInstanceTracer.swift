//
//  LogInstanceTracer.swift
//  CoreToolkit
//
//  Created by sugarbaron on 15.07.2024.
//

public extension Log {
    
    final class InstanceTracer {
        
        private static var instances: ConcurrentMap<String, Int> = .init()
        
        private let name: String
        
        public init(_ name: String) {
            self.name = name
            Self.increment(numberOf: name)
            log("[\(name)] constructed :[\(Self.instances[name] ?? 0)]")
        }
        
        deinit {
            Self.decrement(numberOf: name)
            log("[\(name)] deallocating:[\(Self.instances[name] ?? 0)]")
        }
        
        private static func increment(numberOf name: String) {
            var number: Int = instances[name] ?? 0
            number += 1
            instances[name] = number
        }
        
        private static func decrement(numberOf name: String) {
            guard var number: Int = instances[name], number > 0 else { return }
            number -= 1
            instances[name] = number
        }
        
    }
    
}
