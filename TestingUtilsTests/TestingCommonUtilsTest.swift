//
//  TestingCommonUtilsTest.swift
//  TestingUtilsTests
//
//  Created by Muhammad's on 05.04.24.
//

import XCTest
import TestingUtils

final class TestingCommonUtilsTest: XCTestCase {
    
    let testdata = "Hi this is some testdata to use for our tests"
    
    func testFindInFile() {
        let dir = FileManager.default.temporaryDirectory
        let fileURL = dir.appendingPathComponent("testfile.txt")
        do {
            try testdata.write(to: fileURL, atomically: true, encoding: .utf8)
            let result = CommonUtils.findInFile(needle: "this", haystack: fileURL.path)
            XCTAssertTrue(result, "Failed to find 'this' in file.")
        } catch {
            XCTFail("Error writing test data to file: \(error)")
        }
    }
    
    func testFindInString() {
        let result = CommonUtils.findInString(needle: "Hi", haystack: testdata)
        XCTAssertTrue(result, "'Hi' not found in testdata.")
    }
    
    func testFindInDirectory() {
        let dir = FileManager.default.temporaryDirectory
        let fileURL = dir.appendingPathComponent("testfile.txt")
        do {
            try testdata.write(to: fileURL, atomically: true, encoding: .utf8)
            let result = CommonUtils.findInDirectory(needle: "this", haystackDirectory: dir.path)
            XCTAssertTrue(result, "'this' not found in directory.")
        } catch {
            XCTFail("Error writing test data to file or accessing directory: \(error)")
        }
    }
    
    func testNegative() {
        let result = CommonUtils.sieveOfEratosthenes(n: -1)
        XCTAssertEqual(result, 0, "Expected zero for negative input.")
    }
    
    func testZero() {
        let result = CommonUtils.sieveOfEratosthenes(n: 0)
        XCTAssertEqual(result, 0, "Expected zero for zero input.")
    }
    
    func test10() {
        let result = CommonUtils.sieveOfEratosthenes(n: 10)
        XCTAssertEqual(result, 4, "Incorrect count of primes for 10.")
    }
    
    func test100() {
        let result = CommonUtils.sieveOfEratosthenes(n: 100)
        XCTAssertEqual(result, 25, "Incorrect count of primes for 100.")
    }
    
    func test1000() {
        let result = CommonUtils.sieveOfEratosthenes(n: 1000)
        XCTAssertEqual(result, 168, "Incorrect count of primes for 1000.")
    }
    
    func test1000000() {
        let result = CommonUtils.sieveOfEratosthenes(n: 1000000)
        XCTAssertEqual(result, 78498, "Incorrect count of primes for 1000000.")
    }
    
    func test1000000000() {
        let result = CommonUtils.sieveOfEratosthenes(n: 1000000000)
        XCTAssertEqual(result, 50847534, "Incorrect count of primes for 1000000000.")
    }
    
    func testcalcDistance0() {
        let result = CommonUtils.levenshteinDistance(lhs: "", rhs: "")
        XCTAssertEqual(result, 0, "Expected Levenshtein distance of 0 for empty strings.")
    }
    
    func testcalcDistance1() {
        let result = CommonUtils.levenshteinDistance(lhs: "AA", rhs: "AB")
        XCTAssertEqual(result, 1, "Expected Levenshtein distance of 1 for 'AA' and 'AB'.")
    }
    
    func testcalcDistance2() {
        let result = CommonUtils.levenshteinDistance(lhs: "AAA", rhs: "ABC")
        XCTAssertEqual(result, 2, "Expected Levenshtein distance of 2 for 'AAA' and 'ABC'.")
    }
    
    func testcalcDistanceN() {
        let result = CommonUtils.levenshteinDistance(lhs: "dsfgdfhdfer", rhs: "fgjtykfgnsd")
        XCTAssertTrue(result > 5, "Levenshtein distance should be greater than 5.")
    }
}
