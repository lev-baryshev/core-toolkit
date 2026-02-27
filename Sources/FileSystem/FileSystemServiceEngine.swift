//
//  FileSystemServiceEngine.swift
//  CoreToolkit
//
//  Created by sugarbaron on 02.09.2021.
//

import Foundation

// MARK: constructor
public extension FileSystem {

    final class ServiceEngine {

        private let rootFolder: URL
        private let fileManager: FileManager

        public init?(root rootFolderName: String) {
            let fileManager: FileManager = .default
            guard let root: URL = fileManager.documentFolder/rootFolderName
            else {
                log(error: "[FileSystem] unable to construct engine")
                return nil
            }
            self.rootFolder = root
            self.fileManager = fileManager
        }

    }

}

// MARK: interface
extension FileSystem.ServiceEngine : FileSystem.Service {

    public var dynamicRoot: URL {
        rootFolder
    }

    public func readSize(of file: FileSystem.File) throws -> Int {
        try readFileSize(file.name, file.path)
    }

    public func readSize(file fileName: String, at path: FileSystem.Path) throws -> Int {
        try readFileSize(fileName, path)
    }

    private func readFileSize(_ fileName: String, _ path: FileSystem.Path) throws -> Int {
        let pathUrl: URL = rootFolder/path
        let fullPathUrl: URL = pathUrl/fileName
        guard fileManager.fileExists(atPath: fullPathUrl.path),
              let parameters: [FileAttributeKey : Any] = try? fileManager.attributesOfItem(atPath: fullPathUrl.path),
              let fileSize: Int = (parameters[.size] as? NSNumber)?.intValue
        else {
            throw Exception("[FileSystem] unable to read file size:[\(fileName)]")
        }
        return fileSize
    }
    
    public func load(_ file: FileSystem.File) throws -> Data {
        try loadFile(file.name, file.path)
    }
    
    public func load(file fileName: String, at path: FileSystem.Path) throws -> Data {
        try loadFile(fileName, path)
    }
    
    private func loadFile(_ fileName: String, _ path: FileSystem.Path) throws -> Data {
        let pathUrl: URL = rootFolder/path
        let fullPathUrl: URL = pathUrl/fileName
        guard fileManager.fileExists(atPath: fullPathUrl.path)
        else {
            throw Exception()
        }
        return try Data(contentsOf: fullPathUrl)
    }
    
    public func save(_ file: FileSystem.File, _ content: Data) throws {
        try saveFile(named: file.name, at: file.path, content)
    }
    
    public func save(file fileName: String, at path: FileSystem.Path, _ content: Data) throws {
        try saveFile(named: fileName, at: path, content)
    }
    
    private func saveFile(named fileName: String, at path: FileSystem.Path, _ content: Data) throws {
        let pathUrl: URL = rootFolder/path
        let fullPathUrl: URL = pathUrl/fileName
        do {
            try createNewFolder(at: path)
            try content.write(to: fullPathUrl)
        } catch {
            throw Exception("[FileSystem] unable to write file[\(fullPathUrl)]. error:[\(error)]")
        }
    }

    public func createFolder(at path: FileSystem.Path) throws {
        try createNewFolder(at: path)
    }

    private func createNewFolder(at path: FileSystem.Path?) throws {
        guard let path: FileSystem.Path else { throw Exception("[FileSystem] illegal argument") }

        let fullPath: URL = rootFolder/path
        do    { try ensureFolderExistence(at: fullPath) }
        catch { throw Exception("[FileSystem] unable to create folder:[\(path)]. error:[\(error)]") }
    }

    private func ensureFolderExistence(at localUrl: URL) throws {
        if fileManager.fileExists(atPath: localUrl.path) { return }
        try fileManager.createDirectory(at: localUrl, withIntermediateDirectories: true)
    }

    public func createUniqueFolderName(at path: FileSystem.Path) -> FileSystem.Path {
        createUniqueName(at: path)
    }

    private func createUniqueName(at path: FileSystem.Path) -> FileSystem.Path {
        var pathFolders: [String] = path.items
        pathFolders += UUID().string
        return FileSystem.Path(pathFolders)
    }
    
    public func delete(_ file: FileSystem.File) throws {
        try deleteFile(named: file.name, at: file.path)
    }
    
    public func delete(file fileName: String, at path: FileSystem.Path) throws {
        try deleteFile(named: fileName, at: path)
    }
    
    private func deleteFile(named fileName: String, at path: FileSystem.Path) throws {
        let pathUrl: URL = rootFolder/path
        let fullPathUrl: URL = pathUrl/fileName
        guard fileManager.fileExists(atPath: fullPathUrl.path) else { return }
        do    { try fileManager.removeItem(at: fullPathUrl) }
        catch { throw Exception("[FileSystem] unable to delete file:[\(fullPathUrl)] error:[\(error)]") }
    }
    
    public func deleteAllFiles() {
        deleteAllFilesFrom(FileSystem.Path([]))
    }

    public func deleteAll(from folder: FileSystem.Path) {
        deleteAllFilesFrom(folder)
    }

    private func deleteAllFilesFrom(_ folder: FileSystem.Path) {
        guard isTherePath(folder) else { return }
        let folderUrl: String = (rootFolder/folder).path
        guard let allFilesPaths: [String] = fileManager.enumerator(atPath: folderUrl)?.reversed() as? [String]
        else { log(error: "[FileSystem] (all) unable to read file tree at:[\(folder)]"); return }

        allFilesPaths.forEach { pathItem in
            let url: URL = rootFolder/folder/pathItem
            guard fileManager.fileExists(atPath: url.path) else { return }
            do    { try fileManager.removeItem(at: url) }
            catch { log(error: "[FileSystem] (all) unable to delete file:[\(url)] error:[\(error)]") }
        }
    }
    
    public func getUrl(of file: FileSystem.File) -> URL {
        absoluteUrl(of: file)/file.name
    }
    
    private func absoluteUrl(of file: FileSystem.File) -> URL {
        rootFolder/file.path
    }
    
    public func isThere(_ file: FileSystem.File) -> Bool {
        isThereFile(file.name, at: file.path)
    }
    
    public func isThereNo(_ file: FileSystem.File) -> Bool {
        isThereFile(file.name, at: file.path) == false
    }
    
    public func isThere(file fileName: String, at filePath: FileSystem.Path) -> Bool {
        isThereFile(fileName, at: filePath)
    }
    
    public func isThereNo(file fileName: String, at filePath: FileSystem.Path) -> Bool {
        isThereFile(fileName, at: filePath) == false
    }
    
    private func isThereFile(_ fileName: String, at filePath: FileSystem.Path) -> Bool {
        let fullPath: URL = rootFolder/filePath/fileName
        return fileManager.fileExists(atPath: fullPath.path)
    }

    public func isThere(_ path: FileSystem.Path) -> Bool {
        isTherePath(path)
    }

    public func isThereNo(_ path: FileSystem.Path) -> Bool {
        isTherePath(path) == false
    }

    private func isTherePath(_ path: FileSystem.Path) -> Bool {
        let fullPath: URL = rootFolder/path
        return fileManager.fileExists(atPath: fullPath.path)
    }
    
}

private extension FileManager {

    var documentFolder: URL? {
        urls(for: .documentDirectory, in: .userDomainMask).first
    }

}
