//
//  Downstreams.swift
//  CoreToolkit
//
//  Created by sugarbaron on 04.12.2024.
//

import Combine

// MARK: Downstream
public typealias Downstream<T> = AnyPublisher<T, Never>

// MARK: ReadableStream: constructor
public final class ReadableStream<T> {
    
    private let core: SolidDownstream<T>
    
    public init(_ core: SolidDownstream<T>) {
        self.core = core
    }
    
}

// MARK: ReadableStream: interface
public extension ReadableStream {
    
    func abstract() -> Downstream<T> {
        core.abstract()
    }
    
    func read() -> T {
        core.read()
    }
    
    func subscribe(_ react: @escaping (T) -> Void) -> AnyCancellable {
        core.abstract().subscribe(onEvent: react)
    }
    
}

// MARK: SolidDownstream: constructor
public final class SolidDownstream<T> {
    
    private let this: ThreadSafe<T>
    private let downstream: CurrentValueSubject<T, Never>
    
    public init(_ this: T) {
        self.this = ThreadSafe(this)
        self.downstream = CurrentValueSubject(this)
    }
    
}

// MARK: SolidDownstream: interface
public extension SolidDownstream {
    
    func abstract() -> Downstream<T> {
        downstream.abstract()
    }
    
    var sealed: ReadableStream<T> { .init(self) }
    
    func read() -> T {
        this.it
    }
    
    func send(_ new: T) {
        this <~ new
        downstream.send(new)
    }
    
}

public extension SolidDownstream where T == Void {
    
    func send() {
        send(())
    }
    
}

// MARK: PulseDownstream: constructor
public final class PulseDownstream<T> {
    
    private let downstream: PassthroughSubject<T, Never>
    
    public init() {
        self.downstream = PassthroughSubject()
    }
    
}

// MARK: PulseDownstream: interface
public extension PulseDownstream {
    
    func abstract() -> Downstream<T> {
        downstream.abstract()
    }
    
    func send(_ new: T) {
        downstream.send(new)
    }
    
}

public extension PulseDownstream where T == Void {
    
    func send() {
        send(())
    }
    
}
