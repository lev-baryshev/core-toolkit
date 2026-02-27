//  FileSystemPathContributions.swift
//  CoreToolkit
//
//  Created by sugarbaron on 27.10.2022.
//

import Foundation

public extension URL {

    static func /(_ left: URL, _ right: FileSystem.Path) -> URL {
        var result: URL = left
        right.items.forEach { result = result.appendingPathComponent($0) }
        return result
    }

}

public extension Optional where Wrapped == URL {

    static func /(_ left: URL?, _ right: FileSystem.Path) -> URL? {
        var result: URL? = left
        right.items.forEach { result = result?.appendingPathComponent($0) }
        return result
    }

}

public extension String {

    var path: FileSystem.Path {
        .init(self)
    }

}

public extension Array where Element == String {

    var path: FileSystem.Path {
        .init(self)
    }

}
