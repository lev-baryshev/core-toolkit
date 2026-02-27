//
//  JsonCodingTools.swift
//  CoreToolkit
//
//  Created by sugarbaron on 18.11.2021.
//

import Foundation

public extension KeyedDecodingContainer {

    func deserialize<T:Decodable>(_ key: K) throws -> T {
        try self.decode(T.self, forKey: key)
    }
    
    func deserialize<T:Decodable>(optional key: K) throws -> T? {
        try decodeIfPresent(T.self, forKey: key)
    }
    
    func deserialize(_ key: K, _ template: String) throws -> Date {
        let dateString: String = try decode(String.self, forKey: key)
        if let date: Date = dateString.date(template: template) { return date }
        throw Exception("[NavixyApi.Json] unable to convert:[\(dateString)][\(template)]")
    }
    
    func deserialize(optional key: K, _ template: String) throws -> Date? {
        guard let dateString: String = try decodeIfPresent(String.self, forKey: key) else { return nil }
        return dateString.date(template: template)
    }
    
    func deserialize<T:Decodable>(array key: K) throws -> [T] {
        try deserializeArray(key) ?? [ ]
    }

    func deserialize<T:Decodable>(array key: K) throws -> [T]? {
        try deserializeArray(key)
    }
    
    private func deserializeArray<T:Decodable>(_ key: K) throws -> [T]? {
        guard contains(key) else { return nil }
        var array: [T] = [ ]
        guard var json: UnkeyedDecodingContainer = try? nestedUnkeyedContainer(forKey: key) else { return [ ] }
        while json.isAtEnd == false {
            do    { array += try json.decode(T.self) }
            catch { log(error: "[Json][array item] \(error)"); json.skipElement() }
        }
        return array
    }
    
    func nested<T:CodingKey>(_ key: K) throws -> KeyedDecodingContainer<T> {
        try nestedContainer(keyedBy: T.self, forKey: key)
    }
    
}

public extension KeyedEncodingContainer {
    
    mutating func serialize<T:Encodable>(_ original: T, key: KeyedEncodingContainer.Key) throws {
        if case Optional<Any>.none = original as Any { return }
        try encode(original, forKey: key)
    }
    
    mutating func serialize<T:Encodable>(required original: T, key: KeyedEncodingContainer.Key) throws {
        try encode(original, forKey: key)
    }
    
    mutating func serialize<T:Encodable>(array: [T], key: KeyedEncodingContainer.Key) throws {
        if array.isEmpty { return }
        try encode(array, forKey: key)
    }
    
}

public extension UnkeyedDecodingContainer {

    /// brown magic (crutch) for ability to skip json elements with UnkeyedDecodingContainer
    mutating func skipElement() { _ = try? decode(DecodableStub.self) }

}

private final class DecodableStub : Decodable { }
