//
//  Debounce.swift
//  CoreToolkit
//
//  Created by sugarbaron on 23.03.2021.
//

import Foundation

// MARK: constructor
public final class Debounce {
    
    private let latency: TimeInterval
    private var fireAt: Date
    private var cancelled: Bool
    private let mutex: NSRecursiveLock
    private let background: Async.Fifo
    
    public init(for latency: TimeInterval) {
        self.latency = latency
        self.fireAt = .now
        self.cancelled = false
        self.mutex = NSRecursiveLock()
        self.background = Async.Fifo()
    }
    
}

// MARK: interface
public extension Debounce {
    
    func arm(_ action: @escaping @Sendable () async -> Void) {
        mutex.lock()
        fireAt = .now + latency
        cancelled = false
        mutex.unlock()
        background.cancelPending()
        background.enqueue { [weak self] in
            await self?.sleep()
            guard let self: Debounce else { return }
            if rearmed || declined { return }
            await action()
        }
    }
    
    var armed: Bool { background.isBusy }
    
    var disarmed: Bool { background.isIdling }
    
    func disarm() {
        background.cancelPending()
        mutex.lock()
        cancelled = true
        mutex.unlock()
    }
    
}

// MARK: tools
private extension Debounce {
    
    func sleep() async {
        await idle(delay)
    }
    
    var delay: TimeInterval {
        mutex.lock()
        let delay: TimeInterval = fireAt - .now
        mutex.unlock()
        return delay
    }
    
    var rearmed: Bool {
        background.queueSize > 1
    }
    
    var declined: Bool {
        mutex.lock()
        let declined: Bool = cancelled
        mutex.unlock()
        return declined
    }
    
}
