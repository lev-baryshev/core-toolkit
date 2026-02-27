//
//  RateLimit.swift
//  CoreToolkit
//
//  Created by sugarbaron on 18.03.2021.
//


import Foundation

// MARK: constructor
public final class RateLimit {
    
    private let seconds: TimeInterval
    private var lastExecution: Date?
    private let access: NSRecursiveLock
    
    public init(seconds: TimeInterval) {
        self.seconds = seconds
        self.lastExecution = nil
        self.access = NSRecursiveLock()
    }
    
}

// MARK: interface
public extension RateLimit {
    
    func execute(_ action: () -> Void) {
        if tooEarly { return }
        action()
    }
    
    func execute(_ action: () async -> Void) async {
        if tooEarly { return }
        await action()
    }
    
    func reset() {
        access.lock()
        lastExecution = nil
        access.unlock()
    }
    
    func cooldown() {
        access.lock()
        lastExecution = .now
        access.unlock()
    }
    
}

// MARK: tools
private extension RateLimit {
    
    var tooEarly: Bool {
        access.lock()
        if let lastAttempt = lastExecution, Date.now.since(lastAttempt) < seconds {
            access.unlock()
            return true
        }
        lastExecution = .now
        access.unlock()
        return false
    }
    
}
