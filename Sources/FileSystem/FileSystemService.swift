//
//  FileSystemService.swift
//  CoreToolkit
//
//  Created by sugarbaron on 02.09.2021.
//

import Foundation

/// namespace class
public final class FileSystem {  }

public extension FileSystem {
    
    typealias Service = FileSystemService
    
}

public protocol FileSystemService : AnyObject {

    /// root url is different for every run of application
    var dynamicRoot: URL { get }
    
    func readSize(of file: FileSystem.File) throws -> Int

    func readSize(file fileName: String, at path: FileSystem.Path) throws -> Int

    ///  Creates folder at specified path `(/path/to/Documents/rootFolder/specified path)`.
    ///  Also creates all required subdirectories.
    ///  Does nothing if folder already exists.
    func createFolder(at path: FileSystem.Path) throws
    
    func createUniqueFolderName(at basePath: FileSystem.Path) -> FileSystem.Path
    
    func load(_ file: FileSystem.File) throws -> Data
    
    func load(file fileName: String, at path: FileSystem.Path) throws -> Data
    
    func save(_ file: FileSystem.File, _ content: Data) throws
    
    func save(file fileName: String, at path: FileSystem.Path, _ content: Data) throws
    
    func delete(_ file: FileSystem.File) throws
    
    func delete(file fileName: String, at path: FileSystem.Path) throws
    
    func deleteAllFiles()

    func deleteAll(from folder: FileSystem.Path)
    
    func isThere(_ file: FileSystem.File) -> Bool
    
    func isThereNo(_ file: FileSystem.File) -> Bool
    
    func isThere(file fileName: String, at filePath: FileSystem.Path) -> Bool
    
    func isThereNo(file fileName: String, at filePath: FileSystem.Path) -> Bool

    func isThere(_ path: FileSystem.Path) -> Bool

    func isThereNo(_ path: FileSystem.Path) -> Bool
    
    func getUrl(of file: FileSystem.File) -> URL
    
}
