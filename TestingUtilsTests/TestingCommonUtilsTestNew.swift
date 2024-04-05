//
//  TestingCommonUtilsTestNew.swift
//  TestingUtilsTests
//
//  Created by Muhammad's on 05.04.24.
//

import XCTest
import Foundation
@testable import TestingUtils

final class TestingCommonUtilsTestNew: XCTestCase {
    
    // MARK: - Test Cases for findInFile
    
    func testFindInFile_ExistingNeedleInFile() {
        let fileContent = "This is a test file with some content."
        let fileURL = createTempFile(withContent: fileContent)
        
        XCTAssertTrue(CommonUtils.findInFile(needle: "test", haystack: fileURL.path))
        deleteTempFile(fileURL)
    }
    
    func testFindInFile_NonExistingNeedleInFile() {
        let fileContent = "This is a test file with some content."
        let fileURL = createTempFile(withContent: fileContent)
        
        XCTAssertFalse(CommonUtils.findInFile(needle: "needle", haystack: fileURL.path))
        deleteTempFile(fileURL)
    }
    
    func testFindInFile_EmptyFile() {
        let fileURL = createTempFile(withContent: "")
        
        XCTAssertFalse(CommonUtils.findInFile(needle: "test", haystack: fileURL.path))
        deleteTempFile(fileURL)
    }
    
    // Additional test case for file not found
    func testFindInFile_FileNotFound() {
        XCTAssertFalse(CommonUtils.findInFile(needle: "test", haystack: "invalid_path/file.txt"))
    }
    
    // MARK: - Test Cases for findInString
    
    func testFindInString_ExistingNeedleInString() {
        XCTAssertTrue(CommonUtils.findInString(needle: "Hello", haystack: "Hello, world!"))
    }
    
    func testFindInString_NonExistingNeedleInString() {
        XCTAssertFalse(CommonUtils.findInString(needle: "Swift", haystack: "Hello, world!"))
    }
    
    func testFindInString_EmptyHaystack() {
        XCTAssertFalse(CommonUtils.findInString(needle: "needle", haystack: ""))
    }
    
    // MARK: - Test Cases for findInDirectory
    
    func testFindInDirectory_ExistingNeedleInDirectory() {
        let tempDirectory = createTempDirectory()
        let fileURL = tempDirectory.appendingPathComponent("testfile.txt")
        let fileContent = "This is a test file with some content."
        try? fileContent.write(to: fileURL, atomically: true, encoding: .utf8)
        
        XCTAssertTrue(CommonUtils.findInDirectory(needle: "test", haystackDirectory: tempDirectory.path))
        deleteTempDirectory(tempDirectory)
    }
    
    func testFindInDirectory_NonExistingNeedleInDirectory() {
        let tempDirectory = createTempDirectory()
        
        XCTAssertFalse(CommonUtils.findInDirectory(needle: "needle", haystackDirectory: tempDirectory.path))
        deleteTempDirectory(tempDirectory)
    }
    
    func testFindInDirectory_EmptyDirectory() {
        let emptyDirectory = createEmptyTempDirectory()
        
        XCTAssertFalse(CommonUtils.findInDirectory(needle: "test", haystackDirectory: emptyDirectory.path))
        deleteTempDirectory(emptyDirectory)
    }
    
    // Additional test case for directory not found
    func testFindInDirectory_DirectoryNotFound() {
        XCTAssertFalse(CommonUtils.findInDirectory(needle: "test", haystackDirectory: "invalid_path"))
    }
    
    // MARK: - Test Cases for sieveOfEratosthenes
    
    func testNegative() {
        let n = -1
        XCTAssertEqual(CommonUtilsSolutions.sieveOfEratosthenes(n: n), 0)
    }
    
    func testZero() {
        let n = 0
        XCTAssertEqual(CommonUtilsSolutions.sieveOfEratosthenes(n: n), 0)
    }
    
    func test10() {
        let n = 10
        XCTAssertEqual(CommonUtilsSolutions.sieveOfEratosthenes(n: n), 4)
    }
    
    func test100() {
        let n = 100
        XCTAssertEqual(CommonUtilsSolutions.sieveOfEratosthenes(n: n), 25)
    }
    
    func test1000() {
        let n = 1000
        XCTAssertEqual(CommonUtilsSolutions.sieveOfEratosthenes(n: n), 168)
    }
    
    // MARK: - Test Cases for levenshteinDistance
    
    func testCalcDistance0() {
        let lhs = ""
        let rhs = ""
        XCTAssertEqual(CommonUtilsSolutions.levenshteinDistance(lhs: lhs, rhs: rhs), 0)
    }
    
    func testCalcDistance1() {
        let lhs = "AA"
        let rhs = "AB"
        XCTAssertEqual(CommonUtilsSolutions.levenshteinDistance(lhs: lhs, rhs: rhs), 1)
    }
    
    func testCalcDistance2() {
        let lhs = "AAA"
        let rhs = "ABC"
        XCTAssertEqual(CommonUtilsSolutions.levenshteinDistance(lhs: lhs, rhs: rhs), 2)
    }
    
    func testCalcDistanceN() {
        let lhs = "dsfgdfhdfer"
        let rhs = "fgjtykfgnsd"
        XCTAssertTrue(CommonUtilsSolutions.levenshteinDistance(lhs: lhs, rhs: rhs) > 5)
    }
    
    // MARK: - Test Helper Functions
    
    func createTempFile(withContent content: String) -> URL {
        let dir = FileManager.default.temporaryDirectory
        let fileURL = dir.appendingPathComponent("testfile.txt")
        try? content.write(to: fileURL, atomically: true, encoding: .utf8)
        return fileURL
    }
    
    func deleteTempFile(_ fileURL: URL) {
        try? FileManager.default.removeItem(at: fileURL)
    }
    
    func createTempDirectory() -> URL {
        let dir = FileManager.default.temporaryDirectory
        let tempDirectory = dir.appendingPathComponent(UUID().uuidString)
        try? FileManager.default.createDirectory(at: tempDirectory, withIntermediateDirectories: true, attributes: nil)
        return tempDirectory
    }
    
    func createEmptyTempDirectory() -> URL {
        let dir = FileManager.default.temporaryDirectory
        let tempDirectory = dir.appendingPathComponent(UUID().uuidString)
        try? FileManager.default.createDirectory(at: tempDirectory, withIntermediateDirectories: true, attributes: nil)
        return tempDirectory
    }
    
    func deleteTempDirectory(_ directoryURL: URL) {
        try? FileManager.default.removeItem(at: directoryURL)
    }
}

