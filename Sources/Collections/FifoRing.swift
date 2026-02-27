//
//  FifoRing.swift
//  CoreToolkit
//
//  Created by sugarbaron on 12.01.2023.
//

import Foundation

// MARK: constructor
public final class FifoRing<Element> {
    
    private var elements: [Element?]
    private var readIndex: Int
    private var writeIndex: Int
    private let mutex: NSRecursiveLock
    
    public init(size: Int) {
        self.elements = Array(repeating: nil, count: size)
        self.readIndex = 0
        self.writeIndex = 0
        self.mutex = NSRecursiveLock()
    }
    
}

// MARK: interface
public extension FifoRing {
    
    func write(_ element: Element) {
        mutex.lock()
        if writeIndex == readIndex && isNotEmpty{
            readIndex = increment(readIndex)
        }
        elements[writeIndex] = element
        writeIndex = increment(writeIndex)
        mutex.unlock()
    }
    
    func read() -> Element? {
        mutex.lock()
        if isEmpty {
            mutex.unlock()
            return nil
        }
        let element: Element? = elements[readIndex]
        elements[readIndex] = nil
        readIndex = increment(readIndex)
        mutex.unlock()
        return element
    }
    
    var isNotEmpty: Bool {
        isEmpty == false
    }
    
    var isEmpty: Bool {
        elements[readIndex] == nil
    }
    
}

// MARK: tools
private extension FifoRing {
    
    private func increment(_ index: Int) -> Int {
        ((index + 1) < elements.count) ? (index + 1) : 0
    }
    
}
