//
//  DataDisplay.swift
//  CryptoTools
//
//  Created by Chris Downie on 4/25/21.
//

import Foundation

/// This namspace has a collection of functions for creating more easy-to-read displays of byte arrays.
/// Foundation provides implementations for these methods, so we're using our own namespace to be sure we're using our own implementation
enum DataDisplay {
    
    /// Convert a string of 2-digit hexidecimal numbers into a Data object
    /// - Parameter hexString: The hex string to convert
    /// - Returns: Those bytes as a Data object
    static func data(forHexString hexString: String) -> Data? {
        guard hexString.count % 2 == 0 else {
            return nil
        }
        var bytes = [UInt8]()
        for i in stride(from: 0, to: hexString.count, by: 2) {
            let rangeStart = hexString.index(hexString.startIndex, offsetBy: i)
            let rangeEnd = hexString.index(rangeStart, offsetBy: 2)
            let range = rangeStart..<rangeEnd
            guard let byte = UInt8(hexString[range], radix: 16) else {
                return nil
            }
            bytes.append(byte)
        }
        return Data(bytes)
    }
    
    /// Convert a data object onto a string represention of 2-digit hex bytes
    /// - Parameter data: The data to convert
    /// - Returns: A hex string
    static func hexString(for data: Data) -> String {
        data
            .map { String($0, radix: 16) }
            .reduce("", +)
    }
    
    
    private static func base64IndexFor(char: Character) -> Int? {
        let index: Int
        guard let asciiValue = char.asciiValue else {
            return nil
        }
        switch asciiValue {
        case 65...90: // A to Z
            index = Int(char.asciiValue! - Character("A").asciiValue!)
        case 97...122: // a to z
            index = Int(char.asciiValue! - Character("a").asciiValue!)
        case 48...57: // 0 to 9
            index = Int(char.asciiValue! - Character("0").asciiValue!)
        case Character("+").asciiValue:
            index = 62
        case Character("/").asciiValue:
            index = 63
        default:
            return nil
        }
        return index
    }
    
    private static func characterFor(base64Index: Int) -> Character? {
        guard 0 <= base64Index, base64Index <= 63 else {
            return nil
        }
        let index = UInt8(base64Index)
        
        let value: UInt8
        switch index {
        case 0...25:
            value = index + Character("A").asciiValue!
        case 26...51:
            value = (index - 26) + Character("a").asciiValue!
        case 52...61:
            value = (index - 52) + Character("0").asciiValue!
        case 62:
            value = Character("+").asciiValue!
        case 63:
            value = Character("/").asciiValue!
        default:
            fatalError("Invalid Base64 index should have already returned nil")
        }
        
        return Character(Unicode.Scalar(value))
    }

    /// Convert a base64-encoded string into its underlying Data representation
    /// - Parameter base64String: A valid base64-encoded string
    /// - Returns: Those bytes as a Data object
    static func data(forBase64String base64String: String) -> Data {
        Data()
    }
    
    /// Convert a data object into its base64-encoded String representation
    /// - Parameter data: The data to convert
    /// - Returns: A base64-encoded string
    static func base64String(for data: Data) -> String {
        ""
    }
}
