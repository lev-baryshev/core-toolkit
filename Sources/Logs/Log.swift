//
//  Log.swift
//  CoreToolkit
//
//  Created by sugarbaron on 18.11.2021.
//

import Foundation

/// reminder: don't forget to add Log.Assembly to Di container
public class Log {

    public static func record(into storage: Log.Storage?) {
        engine?.record(into: storage)
    }

}

public func log(
    _ record:   String,
    file:       String = #file,
    method:     String = #function,
    line:       Int    = #line
) {
    log(.info, record, file, method, line)
}

public func log(
    error:      String,
    file:       String = #file,
    method:     String = #function,
    line:       Int    = #line
) {
    log(.error, error, file, method, line)
}

public func log(
    warning:    String,
    file:       String = #file,
    method:     String = #function,
    line:       Int    = #line
) {
    log(.warning, warning, file, method, line)
}

private func log(
    _ level:    Log.Record.Level,
    _ record:   String,
    _ file:     String,
    _ method:   String,
    _ line:     Int
) {
    Log.engine?.log(level, record, file, method, line)
}

internal extension Log {
    
    static weak var engine: Engine? = nil
    
    static func constructEngine() -> Engine? {
        let engine: Engine = .init()
        Log.engine = engine
        return engine
    }
    
}
