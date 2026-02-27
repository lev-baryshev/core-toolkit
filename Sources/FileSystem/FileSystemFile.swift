//
//  FileSystemFile.swift
//  CoreToolkit
//
//  Created by sugarbaron on 11.10.2022.
//

public extension FileSystem {

    typealias File = FileSystemFile

}

public protocol FileSystemFile {

    var name: String { get }
    
    var path: FileSystem.Path { get }

}
