//
//  Threads.swift
//  CoreToolkit
//
//  Created by sugarbaron on 08.06.2021.
//

import Foundation

public class Threads { }

public extension Thread {

    static var isMain: Bool {
        Thread.isMainThread
    }

    static func sleep(_ duration: TimeInterval) {
        sleep(forTimeInterval: duration)
    }

}
