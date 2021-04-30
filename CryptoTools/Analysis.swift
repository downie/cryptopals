//
//  Analysis.swift
//  CryptoTools
//
//  Created by Chris Downie on 4/29/21.
//

import Foundation

public class Analysis {
    // From https://en.wikipedia.org/wiki/Letter_frequency
    static let englishLetterScore: [Character: Double] = [
        "a": 8.2,
        "b": 1.5,
        "c": 2.8,
        "d": 4.3,
        "e": 13.0,
        "f": 2.2,
        "g": 2.0,
        "h": 6.1,
        "i": 7,
        "j": 0.15,
        "k": 0.77,
        "l": 4,
        "m": 2.4,
        "n": 6.7,
        "o": 7.5,
        "p": 1.9,
        "q": 0.095,
        "r": 6,
        "s": 6.3,
        "t": 9.1,
        "u": 2.8,
        "v": 0.98,
        "w": 2.4,
        "x": 0.15,
        "y": 2,
        "z": 0.074,
    ]
    
    // From http://www.viviancook.uk/Punctuation/PunctFigs.htm
    static let englishPunctuationScore: [Character: Double] = [
        ".":  65.3 / 1000,
        ",":  61.6 / 1000,
        ";":   3.2 / 1000,
        ":":   3.4 / 1000,
        "!":   3.3 / 1000,
        "?":   5.6 / 1000,
        "'":  24.3 / 1000,
        "\"": 26.7 / 1000,
        "-":  15.3 / 1000,
        " ": 100.0 / 1000,
    ]
    
    /// Analyze the given text and return a score based on how much the text looks like normal English. This is a relative score -- the value is irrelevant on its own, but is useful when compared to other texts scored with this same function.
    /// - Parameter text: The text to score
    /// - Returns: A number representing how English the text is. Higher scores are better.
    public static func englishScore(for text: String) -> Double {
        var characterFrequencies = [Character: Double]()
        
        // Accumulate character counts
        text.forEach { letter in
            let currentCount = characterFrequencies[letter, default: 0]
            characterFrequencies[letter] = currentCount + 1
        }
        
        // Divide by total characters
        characterFrequencies.forEach { (key: Character, value: Double) in
            characterFrequencies[key] = value / Double(text.count)
        }

        let perfectScore = 100.0
        func letterScore(expectedFrequency: Double, actualFrequency: Double) -> Double {
            max(perfectScore - pow(abs(expectedFrequency - actualFrequency), 2.0), 0)
        }
        
        let letterScoreSum = englishLetterScore.reduce(0.0) { sum, pair in
            let actualFrequency = characterFrequencies[pair.key, default: 0.0]
            return sum + letterScore(expectedFrequency: pair.value, actualFrequency: actualFrequency)
        }
        
        let punctuationScoreSum = englishPunctuationScore.reduce(0.0) { sum, pair in
            let actualFrequency = characterFrequencies[pair.key, default: 0.0]
            return sum + letterScore(expectedFrequency: pair.value, actualFrequency: actualFrequency)
        }

        return letterScoreSum + punctuationScoreSum
    }
}