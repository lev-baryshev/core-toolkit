//
//  FileSystemPath.swift
//  CoreToolkit
//
//  Created by sugarbaron on 18.11.2021.
//

import Foundation

// MARK: constructor
public extension FileSystem {
    
    struct Path {
        
        public let items: [String]
        
        public init(_ path: String) {
            if (path.isEmpty) { self.items = [ ]; return }
            self.items = path.components(separatedBy: "/")
        }
        
        public init(_ items: [String]) { self.items = items }
        
    }
    
}

// MARK: interface
public extension FileSystem.Path {
    
    static func /(_ left: FileSystem.Path, _ right: String) -> FileSystem.Path {
        var pathItems: [String] = left.items
        pathItems += right
        return FileSystem.Path(pathItems)
    }
    
    static func == (lhs: FileSystem.Path, rhs: FileSystem.Path) -> Bool {
        lhs.items == rhs.items
    }
    
    var string: String {
        "\(String(items.joined(by: "/")))"
    }
    
}

// MARK: json
extension FileSystem.Path : JsonCodable {
    
    public static func deserialize(with json: Deserializer) throws -> FileSystem.Path {
        let pathItems: [String] = try json.deserialize(.pathItems)
        return FileSystem.Path(pathItems)
    }
    
    public func serialize(with json: inout Serializer) throws {
        try json.serialize(items, key: .pathItems)
    }
    
    public enum JsonKey : String, CodingKey {
        case pathItems = "path_items"
    }
    
    public typealias Key = JsonKey
    
}
