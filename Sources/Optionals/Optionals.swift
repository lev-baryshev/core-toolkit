//
//  Optionals.swift
//  CoreToolkit
//
//  Created by sugarbaron on 19.03.2021.
//

@discardableResult
public func unwrap<T, R:Nullable>(_ wrapped: T?, _ action: (T) -> R) -> R {
    if let unwrapped: T = wrapped { return action(unwrapped) } else { return nil }
}

@discardableResult
public func unwrap<T, R>(_ wrapped: T?, _ action: (T) -> R) -> R? {
    if let unwrapped: T = wrapped { return action(unwrapped) } else { return nil }
}

@discardableResult
public func unwrap<T, R>(_ wrapped: T?, _ action: (T) -> R, else: () -> R) -> R {
    if let unwrapped: T = wrapped { return action(unwrapped) } else { return `else`() }
}

@discardableResult
public func unwrap<T, R:Nullable>(_ wrapped: T?, _ action: (T) async -> R) async -> R {
    if let unwrapped: T = wrapped { return await action(unwrapped) } else { return nil }
}

@discardableResult
public func unwrap<T, R>(_ wrapped: T?, _ action: (T) async -> R) async -> R? {
    if let unwrapped: T = wrapped { return await action(unwrapped) } else { return nil }
}

@discardableResult
public func unwrap<T, R>(_ wrapped: T?, _ action: (T) async -> R, else: () async -> R) async -> R {
    if let unwrapped: T = wrapped { return await action(unwrapped) } else { return await `else`() }
}

@discardableResult
public func unwrap<T, R:Nullable>(_ wrapped: T?, _ action: (T) throws -> R) rethrows -> R {
    if let unwrapped: T = wrapped { return try action(unwrapped) } else { return nil }
}

@discardableResult
public func unwrap<T, R>(_ wrapped: T?, _ action: (T) throws -> R) rethrows -> R? {
    if let unwrapped: T = wrapped { return try action(unwrapped) } else { return nil }
}

@discardableResult
public func unwrap<T, R>(_ wrapped: T?, _ action: (T) throws -> R, else: () throws -> R) rethrows -> R {
    if let unwrapped: T = wrapped { return try action(unwrapped) } else { return try `else`() }
}

@discardableResult
public func unwrap<T, R:Nullable>(_ wrapped: T?, _ action: (T) async throws -> R) async rethrows -> R {
    if let unwrapped: T = wrapped { return try await action(unwrapped) } else { return nil }
}

@discardableResult
public func unwrap<T, R>(_ wrapped: T?, _ action: (T) async throws -> R) async rethrows -> R? {
    if let unwrapped: T = wrapped { return try await action(unwrapped) } else { return nil }
}

@discardableResult
public func unwrap<T, R>(_ wrapped: T?, _ action: (T) async throws -> R, else: () async throws -> R)
async rethrows -> R {
    if let unwrapped: T = wrapped { return try await action(unwrapped) } else { return try await `else`() }
}

public typealias Nullable = ExpressibleByNilLiteral
