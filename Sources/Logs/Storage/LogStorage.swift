//
//  LogStorage.swift
//  CoreToolkit
//
//  Created by sugarbaron on 18.11.2021.
//

import Foundation

public extension Log {

    typealias Recorder = LogRecorder
    typealias Reader   = LogReader
    typealias Storage  = Recorder & Reader

}

public protocol LogRecorder : AnyObject {

    func save(_ record: Log.Record.Draft)

}

public protocol LogReader : AnyObject {

    func loadLoggedDays() async -> [Date]

    func load(forDay day: Date) async -> [Log.Record]

}
