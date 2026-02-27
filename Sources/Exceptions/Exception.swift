//
//  Exception.swift
//  CoreToolkit
//
//  Created by sugarbaron on 18.11.2021.
//

public final class Exception : Error {

    public let type: ExceptionType
    public let cause: String

    public enum ExceptionType : String {
        case illegalState       = "illegal_state"
        case illegalArgument    = "illegal_argument"
        case outOfRange         = "out_of_range"
        case actionFailed       = "action_failed"
    }

    public init(
        _ cause: String = "",
         type: ExceptionType = .actionFailed,
         file: String = #file,
         method: String = #function,
         line: Int = #line
    ) {
        self.type = type
        self.cause = cause
        if cause.isEmpty { return }
        log(error: "[\(type.rawValue)] \(cause)", file: file, method: method, line: line)
    }

}

extension Exception : CustomStringConvertible {

    public var description: String { cause }

}
