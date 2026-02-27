//
//  FileSystemServiceTests.swift
//  CoreToolkit
//
//  Created by sugarbaron on 24.02.2026.
//

@testable
import CoreToolkit
import XCTest

final class FileSystemServiceTests : XCTestCase {
    
    // MARK: save / load / readSize
    func testGeneral() throws {
        let service: FileSystem.Service = try new()
        let path: FileSystem.Path = path(["folder", "subfolder"])
        let file: FileSystem.File = file("test.bin", path: path)
        let payload: Data = .init([0x01, 0x02, 0x03])
        
        try service.save(file, payload)
        
        XCTAssertTrue(service.isThere(file))
        XCTAssertEqual(try service.readSize(of: file), payload.count)
        
        let loaded: Data = try service.load(file)
        XCTAssertEqual(loaded, payload)
    }
    
    // MARK: delete single file
    func testDelete() throws {
        let service: FileSystem.Service = try new()
        let path:  FileSystem.Path = path(["delete", "one"])
        let fileA: FileSystem.File = file("a.txt", path: path)
        let fileB: FileSystem.File = file("b.txt", path: path)
        let payload: Data = .init([0xFF])
        
        try service.save(fileA, payload)
        try service.save(fileB, payload)
        
        XCTAssertTrue(service.isThere(fileA))
        XCTAssertTrue(service.isThere(fileB))
        
        try service.delete(fileA)
        
        XCTAssertFalse(service.isThere(fileA))
        XCTAssertTrue(service.isThere(fileB))
    }
    
    // MARK: delete all
    func testDeleteAll() throws {
        let service: FileSystem.Service = try new()
        let path1: FileSystem.Path = path(["root", "one"])
        let path2: FileSystem.Path = path(["root", "two"])
        let file1: FileSystem.File = file("1.txt", path: path1)
        let file2: FileSystem.File = file("2.txt", path: path2)
        let payload: Data = .init([0xAA])
        
        try service.save(file1, payload)
        try service.save(file2, payload)
        
        XCTAssertTrue(service.isThere(file1))
        XCTAssertTrue(service.isThere(file2))
        
        service.deleteAllFiles()
        
        XCTAssertFalse(service.isThere(file1))
        XCTAssertFalse(service.isThere(file2))
    }
    
    func testDeleteAllFromFolder() throws {
        let service: FileSystem.Service = try new()
        let folderA: FileSystem.Path = path(["A"])
        let folderB: FileSystem.Path = path(["B"])
        let fileA: FileSystem.File = file("a.txt", path: folderA)
        let fileB: FileSystem.File = file("b.txt", path: folderB)
        let payload: Data = .init([0xBB])
        
        try service.save(fileA, payload)
        try service.save(fileB, payload)
        
        service.deleteAll(from: folderA)
        
        XCTAssertFalse(service.isThere(fileA))
        XCTAssertTrue(service.isThere(fileB))
    }
    
    // MARK: folder creation and existence checks
    func testCreateFolder() throws {
        let service: FileSystem.Service = try new()
        let folder: FileSystem.Path = path(["folder", "nested"])
        
        XCTAssertTrue(service.isThereNo(folder))
        
        try service.createFolder(at: folder)
        
        XCTAssertTrue(service.isThere(folder))
        XCTAssertFalse(service.isThereNo(folder))
    }
    
    // MARK: tools
    private func new() throws -> FileSystem.Service {
        let root: String = "root"
        guard let fileSystem: FileSystem.Service = FileSystem.ServiceEngine(root: root)
        else {
            XCTFail("[FileSystem] unable to construct")
            throw Exception()
        }
        fileSystem.deleteAllFiles()
        return fileSystem
    }
    
    private func path(_ components: [String]) -> FileSystem.Path {
        FileSystem.Path(components)
    }

    private func file(_ name: String, path: FileSystem.Path) -> FileSystem.File {
        File(name: name, path: path)
    }
    
}

private struct File : FileSystem.File {
    
    var name: String
    var path: FileSystem.Path
    
}
