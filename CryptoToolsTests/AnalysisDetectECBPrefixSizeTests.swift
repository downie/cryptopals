//
//  AnalysisDetectECBPrefixSizeTests.swift
//  CryptoToolsTests
//
//  Created by Chris Downie on 5/8/21.
//

import XCTest
@testable import CryptoTools

class AnalysisDetectECBPrefixSizeTests: XCTestCase {

    func testWithNoPrefix() throws {
        let key = Data(repeating: 0, count: AES128.blockSize)
        let cipher = AES128.ECBCipher(key: key)
        let suffix = Data()
        let output = Analysis.detectECBPrefixSize(blockSize: AES128.blockSize) { data in
            try! cipher.encrypt(data: data + suffix)
        }

        XCTAssertEqual(output, suffix.count)
    }

    func testWithOneBytePrefix() throws {
        let key = Data(repeating: 0, count: AES128.blockSize)
        let cipher = AES128.ECBCipher(key: key)
        let suffix = Data([0x42])
        let output = Analysis.detectECBPrefixSize(blockSize: AES128.blockSize) { data in
            try! cipher.encrypt(data: data + suffix)
        }

        XCTAssertEqual(output, suffix.count)
    }

    func testWithFewBytePrefix() throws {
        let key = Data(repeating: 0, count: AES128.blockSize)
        let cipher = AES128.ECBCipher(key: key)
        let suffix = Data(repeating: 0x42, count: 7)
        let output = Analysis.detectECBPrefixSize(blockSize: AES128.blockSize) { data in
            try! cipher.encrypt(data: data + suffix)
        }

        XCTAssertEqual(output, suffix.count)
    }

    func testWithMultiBlockPrefix() throws {
        let key = Data(repeating: 0, count: AES128.blockSize)
        let cipher = AES128.ECBCipher(key: key)
        let suffix = Data(repeating: 0x42, count: AES128.blockSize * 2 + 4)
        let output = Analysis.detectECBPrefixSize(blockSize: AES128.blockSize) { data in
            try! cipher.encrypt(data: data + suffix)
        }

        XCTAssertEqual(output, suffix.count)
    }
}
